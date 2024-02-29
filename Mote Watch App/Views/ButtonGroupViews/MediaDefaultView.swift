//
//  MediaDefaultView.swift
//  Mote Watch App
//
//  Created by Ярослав on 29.02.2024.
//

import SwiftUI

struct MediaDefaultView: View {
    var body: some View {
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
}

#Preview {
    MoteTabView(selection: .media)
}
