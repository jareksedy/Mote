//
//  MoteApp.swift
//  Mote Watch App
//
//  Created by Ярослав on 28.01.2024.
//

import SwiftUI

@main
struct MoteWatchApp: App {
    var body: some Scene {
        WindowGroup {
            MoteTabView()
        }
        .environmentObject(MoteViewModel())
    }
}
