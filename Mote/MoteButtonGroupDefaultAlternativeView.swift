//
//  MoteButtonGroupDefaultAlternativeView.swift
//  Mote
//
//  Created by Ярослав Седышев on 31.03.2024.
//

import SwiftUI

struct MoteButtonGroupDefaultAlternativeView: View {
    var body: some View {
        MoteButtonGroup {
            MoteButtonRow {
                MoteButton(.powerOff)
                MoteButton(.grid)
                MoteButton(.settings)
            }
            MoteButtonRow {
                MoteButton(.num1)
                MoteButton(.num2)
                MoteButton(.num3)
            }
            MoteButtonRow {
                MoteButton(.num4)
                MoteButton(.num5)
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
