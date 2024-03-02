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
                Toggle(Strings.Settings.alternativeLayout, isOn: $viewModel.preferencesAlternativeView)
                    .tint(.accentColor)
                    .listRowPlatterColor(.gray.opacity(0.1))
                Toggle(Strings.Settings.hapticFeedback, isOn: $viewModel.preferencesHapticFeedback)
                    .tint(.accentColor)
                    .listRowPlatterColor(.gray.opacity(0.1))
            }
            .padding(.top, GlobalConstants.negativeTopPadding)
            .padding()
            .navigationTitle(Strings.Titles.settings)
            .navigationBarTitleDisplayMode(.inline)
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
            
            Text("\(Strings.General.appName) \(Bundle.main.releaseVersionNumber) (\(Bundle.main.buildVersionNumber))")
                .font(.system(size: 8))
                .foregroundStyle(.gray)
                .fontWeight(.medium)
                .fontDesign(.rounded)
        }
    }
}

#Preview {
    MoteTabView(selection: .settings)
}
