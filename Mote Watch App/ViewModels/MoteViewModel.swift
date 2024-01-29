//
//  MoteViewModel.swift
//  Mote Watch App
//
//  Created by Ярослав on 28.01.2024.
//

import SwiftUI
import WatchConnectivity

final class MoteViewModel: NSObject, ObservableObject {
    private var session: WCSession
    
    init(session: WCSession = .default){
        self.session = session
        session.activate()
    }
}

extension MoteViewModel: WCSessionDelegate {
    func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: Error?
    ) {
    }
}
