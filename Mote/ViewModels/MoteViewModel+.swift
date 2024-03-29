//
//  MoteViewModel+.swift
//  Mote
//
//  Created by Ярослав Седышев on 29.03.2024.
//

import SwiftUI
import WebOSClient

extension MoteViewModel {
    func connectAndRegisterWatch() {
        guard !isConnected else { return }
        
        tv = WebOSClient(url: URL(string: "wss://192.168.8.10:3001"))
        tv?.delegate = self
        tv?.connect()
        tv?.send(.register(clientKey: AppSettings.shared.clientKey), id: "registration")
    }
    
    func connectAndRegister() {
        tv = WebOSClient(url: URL(string: "wss://192.168.8.10:3001"))
        tv?.delegate = self
        tv?.connect()
        tv?.send(.register(clientKey: AppSettings.shared.clientKey), id: "registration")
    }
    
    func disconnect() {
        tv?.disconnect()
        Task { @MainActor in
            isConnected = false
        }
    }
    
    func discoverDevices() {
        deviceDiscoveryFinished = false
        devices.removeAll()
        ssdpClient.discoverService()
    }
    
    func subscribeAll() {
        tv?.send(.registerRemoteKeyboard, id: GlobalConstants.SubscriptionIds.remoteKeyboardRequestId)
        tv?.send(.getForegroundAppMediaStatus(subscribe: true), id: GlobalConstants.SubscriptionIds.mediaPlaybackInfoRequestId)
    }
}
