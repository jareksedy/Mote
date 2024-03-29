//
//  WCSessionDelegate.swift
//  Mote
//
//  Created by Ярослав Седышев on 29.03.2024.
//

import SwiftUI
import WatchConnectivity

extension MoteViewModel: WCSessionDelegate {
    func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: Error?
    ) {}

    func session(
        _ session: WCSession,
        didReceiveMessage message: [String: Any]
    ) {
        connectAndRegisterWatch()

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
