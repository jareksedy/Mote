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
    private var session: WCSession
    private var tv: WebOSClient?
    
    init(session: WCSession = .default){
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
        connectAndRegister()
    }
}

private extension MoteViewModel {
    private func connectAndRegister() {
        tv = WebOSClient(url: URL(string: "wss://192.168.8.10"), delegate: self)
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
        if let target = message[.commonTarget] as? WebOSTarget {
            tv?.send(target)
        } else if let target = message[.keyTarget] as? WebOSKeyTarget {
            tv?.sendKey(target)
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {}
    
    func sessionDidDeactivate(_ session: WCSession) {}
}

extension MoteViewModel: WebOSClientDelegate {
    func didRegister(with clientKey: String) {
        AppSettings.shared.clientKey = clientKey
    }
    
    func didReceiveNetworkError(_ error: Error?) {
    }
}
