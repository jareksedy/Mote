//
//  WebOSClientDelegate.swift
//  Mote
//
//  Created by Ярослав Седышев on 29.03.2024.
//

import SwiftUI
import WebOSClient

extension MoteViewModel: WebOSClientDelegate {
    func didPrompt() {
        Task { @MainActor in
            toast(.prompted)
        }
    }

    func didRegister(with clientKey: String) {
        AppSettings.shared.clientKey = clientKey

        subscribeAll()

        Task { @MainActor in
            isConnected = true
            isToastPresented = false
        }
    }

    func didReceive(_ result: Result<WebOSResponse, Error>) {
        if case .success(let response) = result,
           response.id == Globals.SubscriptionIds.remoteKeyboardRequestId,
           let focus = response.payload?.currentWidget?.focus {
            Task { @MainActor in
                keyboardPresented = focus
                isFocused = focus
            }
        }

        if case .success(let response) = result,
           response.id == Globals.SubscriptionIds.mediaPlaybackInfoRequestId,
           let playState = response.payload?.foregroundAppInfo?.first?.playState {
            Task { @MainActor in
                self.playState = playState
            }
        }

        if case .failure(let error) = result {
            print("~e: \(error.localizedDescription)")
        }
    }

    func didReceiveNetworkError(_ error: Error?) {
        if let error = error as NSError? {
            if error.code == 57 || error.code == 60 || error.code == 54 {
                Task { @MainActor in
                    isConnected = false
                    // connectAndRegister()
                }
            }
        }

//        if let error = error as? NSError {
//            print("~err:\(error.localizedDescription) code: \(error.code) ")
//        }
    }
}
