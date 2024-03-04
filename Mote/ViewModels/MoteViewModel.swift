//
//  MoteViewModel.swift
//  Mote
//
//  Created by Ярослав on 28.01.2024.
//

import SwiftUI
import WatchConnectivity
import WebOSClient

final class MoteViewModel: NSObject, ObservableObject {
    @Published var isConnected: Bool = false
    @Published var preferencesPresented: Bool = false
    
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
        Task { @MainActor in
            isConnected = true
        }
    }
    
    func didReceiveNetworkError(_ error: Error?) {
        Task { @MainActor in
            isConnected = false
        }
        connectAndRegister()
    }
}
