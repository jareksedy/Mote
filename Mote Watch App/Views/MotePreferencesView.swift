//
//  MotePreferencesView.swift
//  Mote Watch App
//
//  Created by Ярослав on 28.02.2024.
//

import SwiftUI

struct MotePreferencesView: View {
    @EnvironmentObject var viewModel: MoteViewModel

    var body: some View {
        NavigationStack {
            List {
                Toggle(Strings.Preferences.alternativeLayout, isOn: $viewModel.preferencesAlternativeView)
                    .tint(.accentColor)
                    .listRowPlatterColor(.gray.opacity(0.1))
                Toggle(Strings.Preferences.hapticFeedback, isOn: $viewModel.preferencesHapticFeedback)
                    .tint(.accentColor)
                    .listRowPlatterColor(.gray.opacity(0.1))
            }
            .padding(.top, GlobalConstants.negativeTopPadding)
            .padding()
            .navigationTitle(Strings.Titles.preferencesViewTitle)
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
                .font(.system(size: 7, weight: .regular, design: .monospaced))
                .foregroundStyle(.gray.opacity(0.5))
                .multilineTextAlignment(.center)
        }
    }
}
