//
//  AppIconProvider.swift
//  Mote
//
//  Created by Ярослав on 29.01.2024.
//

import Foundation

enum AppIconProvider {
    static func appIcon(in bundle: Bundle = .main) -> String {
        guard let icons = bundle.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any],
              let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
              let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
              let iconFileName = iconFiles.first else {
            fatalError("Could not find icons in bundle")
        }
        return iconFileName
    }
}
