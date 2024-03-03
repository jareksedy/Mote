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
    @Published var preferencesAlternativeView: Bool = AppSettings.shared.watchAlternativeView {
        didSet {
            AppSettings.shared.watchAlternativeView = preferencesAlternativeView
        }
    }
    @Published var preferencesHapticFeedback: Bool = AppSettings.shared.watchHaptics {
        didSet {
            AppSettings.shared.watchHaptics = preferencesHapticFeedback
        }
    }
    
    private var session: WCSession

    init(session: WCSession = .default){
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
    }
}

extension MoteViewModel {    
    func send(_ target: WebOSTarget) {
        guard let targetJSON = target.request.jsonWithId(UUID().uuidString) else {
            return
        }
        session.sendMessage([.commonTarget: targetJSON], replyHandler: nil) { [weak self] error in
            guard let self else {
                return
            }
            Task { @MainActor in
                self.isConnected = false
            }
        }
    }
    
    func sendKey(_ target: WebOSKeyTarget) {
        guard let targetData = target.request else {
            return
        }
        let targetString = String(decoding: targetData, as: UTF8.self)
        session.sendMessage([.keyTarget: targetString], replyHandler: nil) { [weak self] error in
            guard let self else {
                return
            }
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
