//
//  MoteViewModel.swift
//  Mote
//
//  Created by Ярослав on 28.01.2024.
//

import SwiftUI
import WatchConnectivity
import WebOSClient

enum PopupType {
    case prompted
    case disconnected
    case connected
    case tvGoingOff
}

extension PopupType {
    var iconColor: Color {
        switch self {
        case .prompted:
            return .accent
        case .disconnected:
            return .red
        case .connected:
            return .green
        case .tvGoingOff:
            return .accent
        }
    }
    
    var systemName: String {
        switch self {
        case .prompted:
            return "tv.circle.fill"
        case .disconnected:
            return "exclamationmark.circle.fill"
        case .connected:
            return "checkmark.circle.fill"
        case .tvGoingOff:
            return "power.circle.fill"
        }
    }
    
    var message: String {
        switch self {
        case .prompted:
            return "Please accept the registration\nprompt on the TV"
        case .disconnected:
            return "Disconnected,\nattempting to reconnect"
        case .connected:
            return "Connected to the TV\nsuccessfully"
        case .tvGoingOff:
            return "The TV is going off,\ndisconnecting"
        }
    }
}

fileprivate enum Constants {
    static let volumeSubscriptionRequestId = "volumeSubscription"
}

final class MoteViewModel: NSObject, ObservableObject {
    @Published var isPopupPresentedPrompted: Bool = false
    @Published var isPopupPresentedDisconnected: Bool = false
    @Published var isPopupPresentedConnected: Bool = false
    @Published var isPopupPresentedTVGoingOff: Bool = false
    
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

    private var subscriptions: [String: ((WebOSResponse) -> Void)] = [:]
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
    
    func subscribe(_ id: String, completion: @escaping (WebOSResponse) -> Void) {
        subscriptions[id] = completion
    }
    
    func unsubscribe(_ id: String) {
        subscriptions.removeValue(forKey: id)
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
}

extension MoteViewModel {
    func connectAndRegister() {
        tv?.delegate = self
        tv?.connect()
        tv?.send(.register(clientKey: AppSettings.shared.clientKey))
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
            isPopupPresentedPrompted = true
        }
    }
    
    func didRegister(with clientKey: String) {
        AppSettings.shared.clientKey = clientKey
        
        subscribeAll()

        Task { @MainActor in
            isPopupPresentedPrompted = false
            isPopupPresentedDisconnected = false
            if !isPopupPresentedTVGoingOff {
                withAnimation(.easeInOut(duration: GlobalConstants.AnimationIntervals.buttonFadeInterval)) {
                    isConnected = true
                }
                
                //isPopupPresentedConnected = true
            }
            
        }
    }
    
    func didReceive(_ result: Result<WebOSResponse, Error>) {
        if case .success(let response) = result,
           let id = response.id,
           subscriptions.keys.contains(id) {
            subscriptions[id]?(response)
        }
        
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
                    if !isPopupPresentedTVGoingOff {
                        isPopupPresentedDisconnected = true
                    }
                }
            }
        }
        
        if let error = error as? NSError {
            print("~err:\(error.localizedDescription) code: \(error.code) ")
        }
    }
}
