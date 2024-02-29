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
                MoteButtonRow {
                    MoteButton(.screenOff)
                    MoteButton(.powerOff)
                    MoteButton(.mute)
                }
                MoteButtonRow {
                    MoteButton(.rewind)
                    MoteButton(.playPause)
                    MoteButton(.fastForward)
                }
                MoteButtonRow {
                    if viewModel.preferencesAlternativeView {
                        MoteButton(.channelUpAlt)
                    } else {
                        MoteButton(.home)
                    }
                    MoteButton(.settings)
                    if viewModel.preferencesAlternativeView {
                        MoteButton(.channelDownAlt)
                    } else {
                        MoteButton(.back)
                    }
                }
            }
            .navigationTitle("Media")
        }
    }
}

#Preview {
    MoteTabView(selection: .media)
}
