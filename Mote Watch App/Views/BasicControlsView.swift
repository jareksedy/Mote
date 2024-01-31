//
//  BasicControlsView.swift
//  Mote Watch App
//
//  Created by Ярослав on 28.01.2024.
//

import SwiftUI
import WebOSClient

struct BasicControlsView: View {
    var body: some View {
        NavigationStack {
            MoteButtonGroup {
                MoteButtonRow {
                    MoteButton(.channelUp)
                    MoteButton(.up)
                    MoteButton(.volumeUp)
                }
                MoteButtonRow {
                    MoteButton(.left)
                    MoteButton(.ok)
                    MoteButton(.right)
                }
                MoteButtonRow {
                    MoteButton(.channelDown)
                    MoteButton(.down)
                    MoteButton(.volumeDown)
                }
            }
            .navigationTitle("Basic")
        }
        .background(BackgroundView())
    }
}

#Preview {
    MoteTabView()
}
