//
//  AppSettings.swift
//  Mote
//
//  Created by Ярослав on 29.01.2024.
//

import Foundation
import Foil

final class AppSettings {
    static let shared = AppSettings()

    @FoilDefaultStorageOptional(key: "host")
    var host: String?

    @FoilDefaultStorageOptional(key: "clientKey")
    var clientKey: String?

    @FoilDefaultStorage(key: "phoneAlternativeView")
    var phoneAlternativeView: Bool = false

    @FoilDefaultStorage(key: "phoneHaptics")
    var phoneHaptics: Bool = true

    @FoilDefaultStorage(key: "watchAlternativeView")
    var watchAlternativeView: Bool = false

    @FoilDefaultStorage(key: "watchHaptics")
    var watchHaptics: Bool = true
}
