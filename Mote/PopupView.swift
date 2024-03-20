//
//  PopupView.swift
//  Mote
//
//  Created by Ярослав Седышев on 18.03.2024.
//

import SwiftUI

struct PopupView: View {
    @State private var animateSymbol: Bool = false
    var type: PopupType
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 20) {
                Image(systemName: type.systemName)
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundStyle(.white, type.iconColor)
                    .shadow(color: type.iconColor, radius: 16)
                    .symbolEffect(.bounce.up.byLayer, value: animateSymbol)
                    .onAppear {
                        animateSymbol.toggle()
                    }
                Text(type.message)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(Color(uiColor: .label))
                    .multilineTextAlignment(.leading)
                    .lineSpacing(4)
                Spacer()
            }
            .padding(.top, 1)
            .padding(.leading, 25)
            .frame(height: 100)
        }
        .frame(maxWidth: .greatestFiniteMagnitude)
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(128)
        .shadow(radius: 64)
        .padding([.leading, .trailing], 10)
        .padding(.bottom, 35)
        
    }
}
