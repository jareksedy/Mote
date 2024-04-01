//
//  MoteViewModel+.swift
//  Mote
//
//  Created by Ярослав Седышев on 29.03.2024.
//

import SwiftUI
import WebOSClient

extension MoteViewModel {
    func connectAndRegister(forceConnect: Bool = false) {
        guard !isConnected || forceConnect else {
            return
        }

        let url = URL(string: "wss://192.168.8.10:3001")

        tv = WebOSClient(url: url, shouldPerformHeartbeat: true, heartbeatTimeInterval: 4)
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

    func handleScenePhase(_ scenePhase: ScenePhase) {
        switch scenePhase {
        case .active: connectAndRegister()
        case .background: disconnect()
        default: break
        }
    }

    func discoverDevices() {
        deviceDiscoveryFinished = false
        devices.removeAll()
        ssdpClient.discoverService()
    }

    func subscribeAll() {
        tv?.send(
            .registerRemoteKeyboard,
            id: Globals.SubscriptionIds.remoteKeyboardRequestId
        )

        tv?.send(
            .getForegroundAppMediaStatus(subscribe: true),
            id: Globals.SubscriptionIds.mediaPlaybackInfoRequestId
        )
    }
    
    func showConnectionStatus() {
        toast(isConnected ? .connected : .disconnected)
    }

    func resetConnectionData() {
        disconnect()
        AppSettings.shared.host = nil
        AppSettings.shared.clientKey = nil
        preferencesPresented = false
        connectAndRegister(forceConnect: true)
    }

    func setHostManually(host: String) {
        disconnect()
        AppSettings.shared.host = host
        AppSettings.shared.clientKey = nil
        preferencesPresented = false
        connectAndRegister(forceConnect: true)
    }
}
