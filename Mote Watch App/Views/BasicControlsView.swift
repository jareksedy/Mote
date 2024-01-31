//
//  BasicControlsView.swift
//  Mote Watch App
//
//  Created by Ярослав on 28.01.2024.
//

import SwiftUI

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
    }
}

#Preview {
    MoteTabView(selection: .basic)
}
