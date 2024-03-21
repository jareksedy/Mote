//
//  MoteViewModel.swift
//  Mote
//
//  Created by Ярослав on 28.01.2024.
//

import SwiftUI
import WatchConnectivity
import WebOSClient

fileprivate enum Constants {
    static let volumeSubscriptionRequestId = "volumeSubscription"
}

final class MoteViewModel: NSObject, ObservableObject {
    @Published var isToastPresented: Bool = false
    @Published var toastConfiguration: ToastConfiguration? = nil
    
    @Published var colorButtonsPresented: Bool = false
    @Published var playState: String? = nil
    
    @Published var keyboardPresented: Bool = false
    @Published var isFocused: Bool = false
    
    @Published var isConnected: Bool = false
    @Published var preferencesPresented: Bool = false
    
    @Published var preferencesAlternativeView: Bool = AppSettings.shared.phoneAlternativeView {
        didSet {
            AppSettings.shared.phoneAlternativeView = preferencesAlternativeView
        }
    }
    @Published var preferencesHapticFeedback: Bool = AppSettings.shared.phoneHaptics {
        didSet {
            AppSettings.shared.phoneHaptics = preferencesHapticFeedback
        }
    }

    private var session: WCSession
    private var tv: WebOSClient?
    
    init(session: WCSession = .default){
        self.session = session
        if let host = AppSettings.shared.host {
            tv = WebOSClient(url: URL(string: "wss://\(host):3001"))
        }
        super.init()
        session.delegate = self
        session.activate()
        connectAndRegister()
    }
    
    @discardableResult
    func send(_ target: WebOSTarget, id: String? = nil) -> String? {
        var newId: String?
        
        if let id {
            newId = tv?.send(target, id: id)
        } else {
            newId = tv?.send(target)
        }
        
        if case .turnOff = target {
            tv?.disconnect()
        }
        
        return newId
    }
    
    func sendKey(_ keyTarget: WebOSKeyTarget) {
        tv?.sendKey(keyTarget)
    }
    
    func toast(_ configuration: ToastConfiguration) {
        toastConfiguration = configuration
        isToastPresented = true
    }
}

extension MoteViewModel {
    func connectAndRegister() {
        tv?.delegate = self
        tv?.connect()
        tv?.send(.register(clientKey: AppSettings.shared.clientKey), id: "registration")
    }
    
    func disconnect() {
        tv?.disconnect()
        Task { @MainActor in
            isConnected = false
        }
    }
    
    private func subscribeAll() {
        tv?.send(.registerRemoteKeyboard, id: GlobalConstants.SubscriptionIds.remoteKeyboardRequestId)
        tv?.send(.getForegroundAppMediaStatus(subscribe: true), id: GlobalConstants.SubscriptionIds.mediaPlaybackInfoRequestId)
    }
}

extension MoteViewModel: WCSessionDelegate {
    func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: Error?
    ) {}
    
    func session(
        _ session: WCSession,
        didReceiveMessage message: [String : Any]
    ) {
        connectAndRegister()
        
        if let targetString = message[.keyTarget] as? String,
           let targetData = targetString.data(using: .utf8) {
            tv?.sendKey(keyData: targetData)
        }
        
        if let targetJSON = message[.commonTarget] as? String {
            tv?.send(jsonRequest: targetJSON)
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        session.activate()
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
}

extension MoteViewModel: WebOSClientDelegate {
    func didPrompt() {
        Task { @MainActor in
            toast(.prompted)
        }
    }
    
    func didRejectPrompt() {
        
    }
    
    func didRegister(with clientKey: String) {
        AppSettings.shared.clientKey = clientKey
        subscribeAll()
        
        Task { @MainActor in
            withAnimation(.easeInOut(duration: GlobalConstants.AnimationIntervals.buttonFadeInterval)) {
                isConnected = true
                isToastPresented = false
            }
        }
    }
    
    func didReceive(_ result: Result<WebOSResponse, Error>) {
        if case .success(let response) = result,
           response.id == GlobalConstants.SubscriptionIds.remoteKeyboardRequestId,
           let focus = response.payload?.currentWidget?.focus {
            Task { @MainActor in
                keyboardPresented = focus
                isFocused = focus
            }
        }
        
        if case .success(let response) = result,
           response.id == GlobalConstants.SubscriptionIds.mediaPlaybackInfoRequestId,
           let playState = response.payload?.foregroundAppInfo?.first?.playState {
            Task { @MainActor in
                self.playState = playState
            }
        }
    }
    
    func didReceiveNetworkError(_ error: Error?) {
        if let error = error as NSError? {
            if error.code == 57 || error.code == 60 || error.code == 54 {
                Task { @MainActor in
                    isConnected = false
                }
            }
        }
        
        if let error = error as? NSError {
            print("~err:\(error.localizedDescription) code: \(error.code) ")
        }
    }
}
