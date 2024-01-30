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
            ButtonGroup {
                ButtonRow {
                    ButtonView(.screenOff)
                    ButtonView(.powerOff)
                    ButtonView(.mute)
                }
                ButtonRow {
                    ButtonView(.rewind)
                    ButtonView(.playPause)
                    ButtonView(.fastForward)
                }
                ButtonRow {
                    ButtonView(.home)
                    ButtonView(.settings)
                    ButtonView(.back)
                }
            }
            .navigationTitle("Media")
        }
        .background(
            LinearGradient(
            stops: [.init(color: .black, location: 0), .init(color: .moteDarkerGray, location: 0.25)],
            startPoint: .top, endPoint: .bottom
            )
        )
    }
}
