//
//  MoteTabView.swift
//  Mote Watch App
//
//  Created by Ярослав on 29.01.2024.
//

import SwiftUI

struct MoteTabView: View {
    @State private var selection: TabSelection
    
    var body: some View {
        TabView(selection: $selection) {
            BasicControlsView()
                .tag(TabSelection.basic)
            MediaControlsView()
                .tag(TabSelection.media)
        }
        .tabViewStyle(.verticalPage)
        .background(BackgroundView())
        .ignoresSafeArea(.all)
//        .onChange(of: scenePhase) { newPhase in
//            switch newPhase {
//            case .inactive:
//                print("inactive")
//            case .active:
//                print("active")
//            case .background:
//                print("background")
//            @unknown default:
//                fatalError()
//            }
//        }
    }
    
    init(selection: TabSelection = .basic) {
        self.selection = .basic
    }
    
    enum TabSelection {
        case basic
        case media
    }
}
