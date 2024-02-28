//
//  BasicControlsView.swift
//  Mote Watch App
//
//  Created by Ярослав on 28.01.2024.
//

import SwiftUI

struct BasicControlsView: View {
    @EnvironmentObject var viewModel: MoteViewModel
    var body: some View {
        NavigationStack {
            MoteButtonGroup {
                MoteButtonRow {
                    if viewModel.preferencesAlternativeView {
                        MoteButton(.homeAlt)
                    } else {
                        MoteButton(.channelUp)
                    }
                    MoteButton(.up)
                    MoteButton(.volumeUp)
                }
                MoteButtonRow {
                    MoteButton(.left)
                    MoteButton(.ok)
                    MoteButton(.right)
                }
                MoteButtonRow {
                    if viewModel.preferencesAlternativeView {
                        MoteButton(.backAlt)
                    } else {
                        MoteButton(.channelDown)
                    }
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
