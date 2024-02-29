//
//  MediaControlsView.swift
//  Mote Watch App
//
//  Created by Ярослав on 30.01.2024.
//

import SwiftUI

struct MediaControlsView: View {
    @EnvironmentObject var viewModel: MoteViewModel
    var body: some View {
        NavigationStack {
            MoteButtonGroup {
                if viewModel.preferencesAlternativeView {
                    MediaAlternativeView()
                } else {
                    MediaDefaultView()
                }
            }
            .navigationTitle("Media")
        }
    }
}

#Preview {
    MoteTabView(selection: .media)
}
