//
//  ToastSheetView.swift
//  Mote
//
//  Created by Ярослав Седышев on 30.03.2024.
//

import SwiftUI

struct ToastSheetView: View {
    @ObservedObject var viewModel: MoteViewModel

    @State var startTime = Date.now
    @State var secondsElapsed: Int = 0

    private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var configuration: ToastConfiguration

    var body: some View {
        VStack {
            TipView(
                systemName: configuration.type.systemName,
                color: configuration.type.iconColor,
                message: configuration.message
            )
            .padding(.top, 25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemGray6))
        .onAppear {
            if viewModel.preferencesHapticFeedback {
                UINotificationFeedbackGenerator()
                    .notificationOccurred(configuration.type.getNotificationFeedbackType())
            }
        }
        .onReceive(timer) { firedTime in
            secondsElapsed = Int(firedTime.timeIntervalSince(startTime))

            guard let interval = configuration.autohideIn else {
                return
            }

            if secondsElapsed >= Int(interval) {
                viewModel.isToastPresented = false
            }
        }
    }

    init(configuration: ToastConfiguration, viewModel: MoteViewModel) {
        self.configuration = configuration
        self.viewModel = viewModel
    }
}
