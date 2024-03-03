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
