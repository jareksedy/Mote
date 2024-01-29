//
//  MoteViewModel.swift
//  Mote Watch App
//
//  Created by Ярослав on 28.01.2024.
//

import SwiftUI
import WatchConnectivity

final class MoteViewModel: NSObject, ObservableObject {
    var session: WCSession
    @Published var message: String = "..."
    
    init(session: WCSession = .default){
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
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
        if let receivedMessage = message["message"] as? String {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.message = receivedMessage
            }
        }
    }
}
