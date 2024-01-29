//
//  AppVersionProvider.swift
//  Mote
//
//  Created by Ярослав on 29.01.2024.
//

import Foundation

enum AppVersionProvider {
    static func appVersion(in bundle: Bundle = .main) -> String {
        guard let version = bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            fatalError("CFBundleShortVersionString should not be missing from info dictionary")
        }
        return version
    }
}
