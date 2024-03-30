//
//  MoteButtonRow.swift
//  Mote
//
//  Created by Ярослав on 09.03.2024.
//

import SwiftUI

struct MoteButtonRow<Content: View>: View {
    let content: () -> Content
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    var body: some View {
        HStack(spacing: Globals.buttonSpacing) {
            content()
        }
        .padding(Globals.buttonSpacing)
        .background(.darkerGrayMote)
        .cornerRadius(.greatestFiniteMagnitude)
    }
}
