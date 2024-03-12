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
            return "tv"
        case .disconnected:
            return "antenna.radiowaves.left.and.right.slash"
        case .connected:
            return "antenna.radiowaves.left.and.right"
        case .tvGoingOff:
            return "tv.slash"
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
            return "The TV went off,\ndisconnecting"
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
    
    @Published var keyboardPresented: Bool = false
    
    @Published var isConnected: Bool = false
    @Published var preferencesPresented: Bool = false
    @Published var tvVolumeLevel: Int = 0 {
        didSet {
            tvVolumeChanged = true
        }
    }
    @Published var tvVolumeChanged: Bool = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
                guard let self else { return }
                tvVolumeChanged = false
            }
        }
    }
    
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
    private var tv: WebOSClient
    
    init(session: WCSession = .default){
        self.session = session
        tv = WebOSClient(url: URL(string: "wss://192.168.8.10:3001"))
        super.init()
        tv.delegate = self
        session.delegate = self
        session.activate()
        connectAndRegister()
    }
    
    func send(_ target: WebOSTarget) {
        tv.send(target)
        if case .turnOff = target {
            tv.disconnect()
        }
    }
    
    func sendKey(_ keyTarget: WebOSKeyTarget) {
        tv.sendKey(keyTarget)
    }
}

private extension MoteViewModel {
    func connectAndRegister() {
        guard !isConnected else { return }
        tv.connect()
        tv.send(.register(clientKey: AppSettings.shared.clientKey))
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
            tv.sendKey(keyData: targetData)
        }
        if let targetJSON = message[.commonTarget] as? String {
            tv.send(jsonRequest: targetJSON)
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
        tv.send(.getVolume(subscribe: true), id: Constants.volumeSubscriptionRequestId)
        Task { @MainActor in
            isPopupPresentedPrompted = false
            isPopupPresentedDisconnected = false
            if !isPopupPresentedTVGoingOff {
                isConnected = true
                isPopupPresentedConnected = true
            }
            
        }
    }
    
    func didReceive(jsonResponse: String) {
        print(jsonResponse)
    }
    
    func didReceive(_ result: Result<WebOSResponse, Error>) {
        if case .success(let response) = result, response.id == Constants.volumeSubscriptionRequestId {
            session.sendMessage(["volumeChanged": Double(response.payload?.volumeStatus?.volume ?? 0)], replyHandler: nil)
            Task { @MainActor in
                tvVolumeLevel = response.payload?.volumeStatus?.volume ?? 0
            }
        }
    }
    
//    func didDisconnect() {
//        Task { @MainActor in
//            isConnected = false
//            isPopupPresentedTVGoingOff = true
//        }
//    }
    
    func didReceiveNetworkError(_ error: Error?) {
        if let error = error as? NSError {
            print("~err:\(error.localizedDescription) code: \(error.code) ")
        }
        Task { @MainActor in
            isConnected = false
            if !isPopupPresentedTVGoingOff {
                isPopupPresentedDisconnected = true
            }
        }
        connectAndRegister()
    }
}
