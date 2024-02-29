//
//  PreferencesView.swift
//  Mote Watch App
//
//  Created by Ярослав on 28.02.2024.
//

import SwiftUI

struct PreferencesView: View {
    @EnvironmentObject var viewModel: MoteViewModel
    var body: some View {
        NavigationStack {
            List {
                Toggle("Alternative view", isOn: $viewModel.preferencesAlternativeView)
                    .tint(.accentColor)
                Toggle("Haptic feedback", isOn: $viewModel.preferencesHapticFeedback)
                    .tint(.accentColor)
            }
            .padding()
            .navigationTitle("Preferences")
            .onChange(of: viewModel.preferencesAlternativeView) {
                if viewModel.preferencesHapticFeedback {
                    WKInterfaceDevice.current().play(.click)
                }
            }
            .onChange(of: viewModel.preferencesHapticFeedback) {
                if viewModel.preferencesHapticFeedback {
                    WKInterfaceDevice.current().play(.click)
                }
            }
        }
    }
}

#Preview {
    MoteTabView(selection: .preferences)
}
