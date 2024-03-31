//
//  MoteButtonGroupColorAlternativeView.swift
//  Mote
//
//  Created by Ярослав Седышев on 31.03.2024.
//

import SwiftUI

struct MoteButtonGroupColorAlternativeView: View {
    var body: some View {
        MoteButtonGroup {
            MoteButtonRow {
                MoteButton(.powerOff)
                MoteButton(.grid)
                MoteButton(.settings)
            }
            MoteButtonRow {
                MoteButton(.red)
                MoteButton(.green)
                MoteButton(.yellow)
            }
            MoteButtonRow {
                MoteButton(.num4)
                MoteButton(.blue)
                MoteButton(.num6)
            }
            MoteButtonRow {
                MoteButton(.num7)
                MoteButton(.num8)
                MoteButton(.num9)
            }
            MoteButtonRow {
                MoteButton(.screenOff)
                MoteButton(.num0)
                MoteButton(.mute)
            }
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
            MoteButtonRow {
                MoteButton(.rewind)
                MoteButton(.playPause)
                MoteButton(.fastForward)
            }
        }
    }
}
