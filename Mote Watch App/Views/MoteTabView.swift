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
            PreferencesView()
                .tag(TabSelection.settings)
        }
        .background(.darkGrayMote)
        .tabViewStyle(.verticalPage)
        .ignoresSafeArea(.all)
    }
    
    init(selection: TabSelection = .basic) {
        self.selection = .basic
    }
}

enum TabSelection {
    case basic
    case media
    case settings
}

extension TabSelection {
    var title: String {
        switch self {
        case .basic:
            return Strings.Titles.basicControls
        case .media:
            return Strings.Titles.mediaControls
        case .settings:
            return Strings.Titles.settings
        }
    }
}
