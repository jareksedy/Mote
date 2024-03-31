//
//  ToastSheetView.swift
//  Mote
//
//  Created by Ярослав Седышев on 30.03.2024.
//

import SwiftUI

struct ToastSheetView: View {
    @ObservedObject var viewModel: MoteViewModel
    @State private var animateSymbol: Bool = false
    var configuration: ToastConfiguration

    var body: some View {
        VStack {
            Spacer().frame(height: 25)

            Image(systemName: configuration.type.systemName)
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundStyle(.white, configuration.type.iconColor)
                .padding(.top, 25)
                .symbolEffect(.bounce.up.byLayer, value: animateSymbol)
                .onAppear {
                    animateSymbol.toggle()
                }

            Spacer().frame(height: 10)

            Text(configuration.message)
                .font(.system(size: Globals.bodyFontSize, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .lineSpacing(Globals.lineHeight)
                .padding([.leading, .trailing], 50)

            Spacer().frame(height: 25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemGray6))
        .onAppear {
            if viewModel.preferencesHapticFeedback {
                UINotificationFeedbackGenerator()
                    .notificationOccurred(configuration.type.getNotificationFeedbackType())
            }

            guard let interval = configuration.autohideIn else {
                return
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                viewModel.isToastPresented = false
            }
        }
    }

    init(configuration: ToastConfiguration, viewModel: MoteViewModel) {
        self.configuration = configuration
        self.viewModel = viewModel
    }
}
