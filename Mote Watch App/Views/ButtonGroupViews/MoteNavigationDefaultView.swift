//
//  MoteNavigationDefaultView.swift
//  Mote Watch App
//
//  Created by Ярослав on 29.02.2024.
//

import SwiftUI

struct MoteNavigationDefaultView: View {
    var body: some View {
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
}
