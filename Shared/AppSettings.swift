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
    
    @FoilDefaultStorage(key: "watchAltView")
    var watchAltView: Bool = false
    
    @FoilDefaultStorage(key: "watchHaptics")
    var watchHaptics: Bool = true
}
