//
//  MoteViewModel.swift
//  Mote
//
//  Created by Ярослав on 28.01.2024.
//

import SwiftUI
import WatchConnectivity
import WebOSClient
import SSDPClient

fileprivate enum Constants {
    static let volumeSubscriptionRequestId = "volumeSubscription"
}

final class MoteViewModel: NSObject, ObservableObject {
    @Published var isDiscoverDevicesActivityIndicatorShown: Bool = true
    @Published var isToastPresented: Bool = false
    @Published var toastConfiguration: ToastConfiguration? = nil
    @Published var isAlertPresented: Bool = false
    @Published var colorButtonsPresented: Bool = false
    @Published var playState: String? = nil
    @Published var deviceDiscoveryPresented: Bool = false
    @Published var deviceDiscoveryFinished: Bool = false
    @Published var keyboardPresented: Bool = false
    @Published var isFocused: Bool = false
    @Published var isConnected: Bool = false
    @Published var preferencesPresented: Bool = false
    @Published var devices = [DeviceData]()
    @Published var navigationPath = [NavigationScreens]()
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

    var session: WCSession
    var tv: WebOSClient?
    var ssdpClient = SSDPDiscovery()
    
    init(session: WCSession = .default){
        self.session = session
        super.init()
        ssdpClient.delegate = self
        session.delegate = self
        session.activate()
        connectAndRegister()
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
    
    func toast(_ configuration: ToastConfiguration) {
        toastConfiguration = configuration
        isToastPresented = true
    }
}
