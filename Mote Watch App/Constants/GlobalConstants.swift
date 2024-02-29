//
//  GlobalConstants.swift
//  Mote Watch App
//
//  Created by Ярослав on 31.01.2024.
//

import SwiftUI

enum GlobalConstants {
    /// Device relative constants
    static let deviceHeight = WKInterfaceDevice.current().screenBounds.size.height
    static var smallerDevices: Bool { deviceHeight < 240 }
    
    static let topPadding: CGFloat = smallerDevices ? 50 : 60
    static let buttonSize: CGFloat = smallerDevices ? 45 : 55
    static let buttonSpacing: CGFloat = smallerDevices ? 3 : 4
    static let buttonFontSize: CGFloat = smallerDevices ? 14 : 18
}
