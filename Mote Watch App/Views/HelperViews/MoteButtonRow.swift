//
//  MoteButtonRow.swift
//  Mote Watch App
//
//  Created by Ярослав on 31.01.2024.
//

import SwiftUI

struct MoteButtonRow<Content: View>: View {
    let content: () -> Content
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    var body: some View {
        HStack(spacing: GlobalConstants.buttonSpacing) {
            content()
        }
        .padding(GlobalConstants.buttonSpacing)
        .background(.darkerGrayMote)
        .cornerRadius(.greatestFiniteMagnitude)
    }
}
