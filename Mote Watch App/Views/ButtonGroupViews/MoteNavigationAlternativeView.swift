//
//  MoteNavigationAlternativeView.swift
//  Mote Watch App
//
//  Created by Ярослав on 29.02.2024.
//

import SwiftUI

struct MoteNavigationAlternativeView: View {
    var body: some View {
        MoteButtonRow {
            MoteButton(.homeAlternative)
            MoteButton(.up)
            MoteButton(.volumeUp)
        }
        MoteButtonRow {
            MoteButton(.left)
            MoteButton(.ok)
            MoteButton(.right)
        }
        MoteButtonRow {
            MoteButton(.backAlternative)
            MoteButton(.down)
            MoteButton(.volumeDown)
        }
    }
}
