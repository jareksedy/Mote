//
//  ToastConfiguration.swift
//  Mote
//
//  Created by Ярослав Седышев on 21.03.2024.
//

import SwiftUI

struct ToastConfiguration: Equatable {
    let type: ToastType
    let message: String
    let autohideIn: TimeInterval?
    let closeOnTap: Bool
    let closeOnTapOutside: Bool

    init(
        type: ToastType = .notification,
        message: String,
        autohideIn: TimeInterval? = 4,
        closeOnTap: Bool = true,
        closeOnTapOutside: Bool = true
    ) {
        self.type = type
        self.message = message
        self.autohideIn = autohideIn
        self.closeOnTap = closeOnTap
        self.closeOnTapOutside = closeOnTapOutside
    }
}

extension ToastConfiguration {
    static let prompted = ToastConfiguration(
        type: .notification,
        message: Strings.ToastMessages.prompted,
        autohideIn: nil,
        closeOnTap: true,
        closeOnTapOutside: true
    )

    static let promptAccepted = ToastConfiguration(
        type: .success,
        message: Strings.ToastMessages.connectedAndRegistered
    )
    
    static let connected = ToastConfiguration(
        type: .success,
        message: Strings.ToastMessages.connectedAndRegistered
    )
    
    static let disconnected = ToastConfiguration(
        type: .warning,
        message: Strings.ToastMessages.disconnected
    )
    
    static let goingOff = ToastConfiguration(
        type: .notification,
        message: Strings.ToastMessages.tvGoingOff
    )
}
