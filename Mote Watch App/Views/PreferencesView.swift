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
                    .listRowPlatterColor(.gray.opacity(0.1))
                Toggle("Haptic feedback", isOn: $viewModel.preferencesHapticFeedback)
                    .tint(.accentColor)
                    .listRowPlatterColor(.gray.opacity(0.1))
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
            .font(.system(.body, design: .rounded, weight: .medium))
            .foregroundColor(.gray)
            
            Text("Mote Watch \(Bundle.main.releaseVersionNumber) (\(Bundle.main.buildVersionNumber))")
                .font(.system(size: 8))
                .foregroundStyle(.gray)
                .fontWeight(.medium)
                .fontDesign(.rounded)
        }
    }
}

#Preview {
    MoteTabView(selection: .preferences)
}
