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
                .containerBackground(.darkGrayMote, for: .tabView)
            MediaControlsView()
                .tag(TabSelection.media)
                .containerBackground(.darkGrayMote, for: .tabView)
            PreferencesView()
                .tag(TabSelection.preferences)
                .containerBackground(.darkGrayMote, for: .tabView)
        }
        .tabViewStyle(.verticalPage)
        .ignoresSafeArea(.all)
    }
    
    init(selection: TabSelection = .basic) {
        self.selection = .basic
    }
    
    enum TabSelection {
        case basic
        case media
        case preferences
    }
}