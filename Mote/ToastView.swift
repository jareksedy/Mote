//
//  PopupView.swift
//  Mote
//
//  Created by Ярослав Седышев on 18.03.2024.
//

import SwiftUI

struct ToastView: View {
    @State private var animateSymbol: Bool = false
    var configuration: ToastConfiguration
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 20) {
                Image(systemName: configuration.type.systemName)
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundStyle(.white, configuration.type.iconColor)
                    .shadow(color: configuration.type.iconColor, radius: 16)
                    .symbolEffect(.bounce.up.byLayer, value: animateSymbol)
                    .onAppear {
                        animateSymbol.toggle()
                    }
                Text(configuration.message)
                    .font(.system(size: Globals.bodyFontSize, weight: .bold, design: .rounded))
                    .foregroundColor(Color(uiColor: .label))
                    .multilineTextAlignment(.leading)
                    .lineSpacing(Globals.lineHeight)
                Spacer()
            }
            .padding(.top, 1)
            .padding(.leading, 25)
            .padding(.trailing, 5)
            .frame(height: 150)
        }
        .frame(maxWidth: .greatestFiniteMagnitude)
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(36)
        .shadow(radius: 64)
        .padding([.leading, .trailing], 10)
        .padding(.bottom, 35)

    }
}
