//
//  MoteButtonGroup.swift
//  Mote Watch App
//
//  Created by Ярослав on 31.01.2024.
//

import SwiftUI

struct MoteButtonGroup<Content: View>: View {
    let content: () -> Content
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    var body: some View {
        VStack(spacing: -GlobalConstants.buttonSpacing) {
            Spacer().frame(height: GlobalConstants.topPadding)
            content()
        }
        .ignoresSafeArea(.all)
    }
}
