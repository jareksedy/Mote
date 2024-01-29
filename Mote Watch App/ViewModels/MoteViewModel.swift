//
//  MoteViewModel.swift
//  Mote Watch App
//
//  Created by Ярослав on 28.01.2024.
//

import SwiftUI
import WatchConnectivity
import WebOSClient

final class MoteViewModel: NSObject, ObservableObject {
    @Published var isConnected: Bool = false
    
    private var session: WCSession

    init(session: WCSession = .default){
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
    }
}

extension MoteViewModel {    
    func sendKey(_ target: WebOSKeyTarget) {
        session.sendMessage([.keyTarget: String(describing: target)], replyHandler: nil) { [weak self] error in
            guard let self else { return }
            Task { @MainActor in
                self.isConnected = false
            }
        }
    }
}

extension MoteViewModel: WCSessionDelegate {
    func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: Error?
    ) {
        Task { @MainActor in
            isConnected = error == nil ? true : false
        }
    }
    
    func session(
        _ session: WCSession,
        didReceiveMessage message: [String : Any]
    ) {}
}
