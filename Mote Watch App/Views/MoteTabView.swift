//
//  MoteTabView.swift
//  Mote Watch App
//
//  Created by Ярослав on 29.01.2024.
//

import SwiftUI

struct MoteTabView: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var viewModel: MoteViewModel
    @State private var selection: TabSelection
    
    var body: some View {
        TabView(selection: $selection) {
            MoteNavigationView()
                .tag(TabSelection.navigation)
            MotePlaybackView()
                .tag(TabSelection.playback)
            MotePreferencesView()
                .tag(TabSelection.preferences)
        }
        .background(.darkGrayMote)
        .tabViewStyle(.verticalPage)
        .ignoresSafeArea(.all)
        .sheet(isPresented: $viewModel.isVolumeViewPresented) {
            MoteVolumeView()
        }
        .onChange(of: scenePhase) {
            switch scenePhase {
            case .active:
                viewModel.sendWakeUpMessage()
            case .background:
                break
            case .inactive:
                break
            @unknown default:
                break
            }
        }
    }
    
    init(selection: TabSelection = .navigation) {
        self.selection = .navigation
    }
    
    enum TabSelection {
        case navigation
        case playback
        case preferences
    }
}
