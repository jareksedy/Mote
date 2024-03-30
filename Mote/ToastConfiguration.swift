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
        message: "Please accept the registration prompt on the TV",
        autohideIn: nil,
        closeOnTap: true,
        closeOnTapOutside: true
    )

    static let promptAccepted = ToastConfiguration(
        type: .success,
        message: "Successfully connected and registered with the TV"
    )

    static let promptRejected = ToastConfiguration(
        type: .warning,
        message: "Prompt rejected, press the power button to reaccept"
    )
}
