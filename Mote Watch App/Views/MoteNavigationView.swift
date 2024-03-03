//
//  MoteNavigationView.swift
//  Mote Watch App
//
//  Created by Ярослав on 28.01.2024.
//

import SwiftUI

struct MoteNavigationView: View {
    @EnvironmentObject var viewModel: MoteViewModel
    
    var body: some View {
        NavigationStack {
            MoteButtonGroup {
                if viewModel.preferencesAlternativeView {
                    MoteNavigationAlternativeView()
                } else {
                    MoteNavigationDefaultView()
                }
            }
            .navigationTitle(Strings.Titles.navigationViewTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
