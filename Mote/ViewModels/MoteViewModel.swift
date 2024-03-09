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
    @Published var isConnected: Bool = false
    @Published var preferencesPresented: Bool = false
    @Published var tvVolumeLevel: Double = 0
    
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
        super.init()
        session.delegate = self
        session.activate()
        connectAndRegister()
    }
    
    func presentPreferencesView() {
        preferencesPresented = true
    }
    
    func hidePreferencesView() {
        preferencesPresented = false
    }
    
    func send(_ target: WebOSTarget) {
        tv?.send(target)
    }
    
    func sendKey(_ keyTarget: WebOSKeyTarget) {
        tv?.sendKey(keyTarget)
    }
}

private extension MoteViewModel {
    private func connectAndRegister() {
        guard !isConnected else { return }
        tv = WebOSClient(url: URL(string: "wss://192.168.8.10:3001"), delegate: self)
        tv?.connect()
        tv?.send(.register(clientKey: AppSettings.shared.clientKey))
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
    func didRegister(with clientKey: String) {
        AppSettings.shared.clientKey = clientKey
        tv?.send(.getVolume(subscribe: true), id: Constants.volumeSubscriptionRequestId)
        Task { @MainActor in
            isConnected = true
        }
    }
    
    func didReceive(_ result: Result<WebOSResponse, Error>) {
        if case .success(let response) = result, response.id == Constants.volumeSubscriptionRequestId {
            session.sendMessage(["volumeChanged": Double(response.payload?.volumeStatus?.volume ?? 0)], replyHandler: nil)
            Task { @MainActor in
                tvVolumeLevel = Double(response.payload?.volumeStatus?.volume ?? 0)
            }
        }
    }
    
    func didReceiveNetworkError(_ error: Error?) {
        Task { @MainActor in
            isConnected = false
        }
        connectAndRegister()
    }
}
