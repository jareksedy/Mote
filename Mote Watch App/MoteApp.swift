//
//  MoteApp.swift
//  Mote Watch App
//
//  Created by Ярослав on 28.01.2024.
//

import SwiftUI

@main
struct Mote_Watch_AppApp: App {
    @Environment(\.scenePhase) var scenePhase
    var viewModel = MoteViewModel()
    
    var body: some Scene {
        WindowGroup {
            MoteTabView()
                .onChange(of: scenePhase) {
                    if case .active = scenePhase {
                        print("~\(GlobalConstants.deviceHeight)")
                        viewModel.sendKey(.asterisk)
                    }
                }
        }
        .environmentObject(viewModel)
    }
}
