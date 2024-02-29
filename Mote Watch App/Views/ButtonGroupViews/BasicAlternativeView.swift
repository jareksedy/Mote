//
//  BasicAlternativeView.swift
//  Mote Watch App
//
//  Created by Ярослав on 29.02.2024.
//

import SwiftUI

struct BasicAlternativeView: View {
    var body: some View {
        MoteButtonRow {
            MoteButton(.homeAlt)
            MoteButton(.up)
            MoteButton(.volumeUp)
        }
        MoteButtonRow {
            MoteButton(.left)
            MoteButton(.ok)
            MoteButton(.right)
        }
        MoteButtonRow {
            MoteButton(.backAlt)
            MoteButton(.down)
            MoteButton(.volumeDown)
        }
    }
}

#Preview {
    MoteTabView(selection: .basic)
}
