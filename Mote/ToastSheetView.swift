//
//  ToastSheetView.swift
//  Mote
//
//  Created by Ярослав Седышев on 30.03.2024.
//

import SwiftUI

struct ToastSheetView: View {
    @ObservedObject var viewModel: MoteViewModel

    var configuration: ToastConfiguration
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Spacer().frame(height: 25)

            Image(systemName: configuration.type.systemName)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundStyle(.white, configuration.type.iconColor)
                .padding(.top, 25)

            Spacer()

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
