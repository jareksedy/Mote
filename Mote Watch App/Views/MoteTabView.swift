//
//  MoteTabView.swift
//  Mote Watch App
//
//  Created by Ярослав on 29.01.2024.
//

import SwiftUI

struct MoteTabView: View {
    @State private var selection: TabSelection = .basic
    var body: some View {
            TabView(selection: $selection) {
                BasicControlsView()
                MediaControlsView()
            }
            .tabViewStyle(.verticalPage)
    }
}

extension MoteTabView {
    enum TabSelection {
        case basic
        case media
    }
}
