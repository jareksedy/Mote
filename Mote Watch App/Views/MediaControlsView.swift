//
//  MediaControlsView.swift
//  Mote Watch App
//
//  Created by Ярослав on 30.01.2024.
//

import SwiftUI

struct MediaControlsView: View {
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
                    MoteButton(.home)
                    MoteButton(.settings)
                    MoteButton(.back)
                }
            }
            .navigationTitle("Media")
        }
    }
}

#Preview {
    MoteTabView(selection: .media)
}
