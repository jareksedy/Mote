//
//  ToastType.swift
//  Mote
//
//  Created by Ярослав Седышев on 21.03.2024.
//

import SwiftUI

enum ToastType {
    case warning
    case success
    case notification
}

extension ToastType {
    var iconColor: Color {
        switch self {
        case .notification:
            return .accent
        case .warning:
            return .red
        case .success:
            return .green
        }
    }

    var systemName: String {
        switch self {
        case .warning:
            return "exclamationmark.circle.fill"
        case .success:
            return "checkmark.circle.fill"
        case .notification:
            return "bell.circle.fill"
        }
    }

//    var message: String {
//        switch self {
//        case .prompted:
//            return "Please accept the registration\nprompt on the TV"
//        case .disconnected:
//            return "Disconnected,\nattempting to reconnect"
//        case .connected:
//            return "Connected to the TV\nsuccessfully"
//        case .tvGoingOff:
//            return "The TV is going off,\ndisconnecting"
//        }
//    }
}
