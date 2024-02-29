//
//  BundleExtension.swift
//  Mote
//
//  Created by Ярослав on 29.02.2024.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String {
        return infoDictionary?["CFBundleShortVersionString"] as! String
    }
    var buildVersionNumber: String {
        return infoDictionary?["CFBundleVersion"] as! String
    }
}
