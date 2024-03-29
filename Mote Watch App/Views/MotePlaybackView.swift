//
//  MotePlaybackView.swift
//  Mote Watch App
//
//  Created by Ярослав on 30.01.2024.
//

import SwiftUI

struct MotePlaybackView: View {
    @EnvironmentObject var viewModel: MoteViewModel

    var body: some View {
        NavigationStack {
            MoteButtonGroup {
                if viewModel.preferencesAlternativeView {
                    MotePlaybackAlternativeView()
                } else {
                    MotePlaybackDefaultView()
                }
            }
            .navigationTitle(Strings.Titles.playbackViewTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
