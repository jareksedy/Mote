//
//  BasicControlsView.swift
//  Mote Watch App
//
//  Created by Ярослав on 28.01.2024.
//

import SwiftUI

struct BasicControlsView: View {
    @EnvironmentObject var viewModel: MoteViewModel
    var body: some View {
        NavigationStack {
            MoteButtonGroup {
                if viewModel.preferencesAlternativeView {
                    BasicAlternativeView()
                } else {
                    BasicDefaultView()
                }
            }
            .navigationTitle(Strings.Titles.basicControls)
        }
    }
}

#Preview {
    MoteTabView(selection: .basic)
}
