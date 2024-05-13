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

private enum Constants {
    static let volumeSubscriptionRequestId = "volumeSubscription"
}

final class MoteViewModel: NSObject, ObservableObject {
    @Published var isDiscoverDevicesActivityIndicatorShown: Bool = true
    @Published var isToastPresented: Bool = false
    @Published var toastConfiguration: ToastConfiguration?
    @Published var colorButtonsPresented: Bool = false
    @Published var playState: String?
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

    @Published
    var faqItems: [FAQItem] = [
        FAQItem(question: Strings.FAQ.q1, answer: Strings.FAQ.a1, isExpanded: true),
        FAQItem(question: Strings.FAQ.q1, answer: Strings.FAQ.a1),
        FAQItem(question: Strings.FAQ.q1, answer: Strings.FAQ.a1),
        FAQItem(question: Strings.FAQ.q1, answer: Strings.FAQ.a1),
        FAQItem(question: Strings.FAQ.q1, answer: Strings.FAQ.a1),
        FAQItem(question: Strings.FAQ.q1, answer: Strings.FAQ.a1)
    ]
    
    var session: WCSession
    var tv: WebOSClient?
    var ssdpClient = SSDPDiscovery()

    init(session: WCSession = .default) {
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
