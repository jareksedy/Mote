//
//  AlertView.swift
//  Mote
//
//  Created by Ярослав Седышев on 21.03.2024.
//

import SwiftUI

struct AlertView: View {
    @State private var animateSymbol: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 20) {
                Image(systemName: "bell.circle.fill")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundStyle(.white, .accent)
                    .shadow(color: .accent, radius: 16)
                    .symbolEffect(.bounce.up.byLayer, value: animateSymbol)
                    .onAppear {
                        animateSymbol.toggle()
                    }
                Text("Are you sure you want\nto turn off the TV?")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(Color(uiColor: .label))
                    .multilineTextAlignment(.leading)
                    .lineSpacing(3)
                Spacer()
            }
            .padding(.top, 1)
            .padding(.leading, 25)
            .padding(.trailing, 5)

            HStack(spacing: 20) {
                Image(systemName: "bell.circle.fill")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.clear)
                    .shadow(color: .accent, radius: 16)
                HStack {
                    Button(
                        action: {},
                        label: {
                            Text("Yes")
                                .padding([.leading, .trailing], 10)
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                        })
                    .buttonStyle(.borderedProminent)

                    Button(
                        action: {},
                        label: {
                            Text("Cancel")
                                .padding([.leading, .trailing], 10)
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                        })
                    .buttonStyle(.borderedProminent)
                }
                Spacer()
            }
            .padding(.leading, 25)
            .padding(.trailing, 5)
        }
        .frame(height: 150)
        .frame(maxWidth: .greatestFiniteMagnitude)
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(32)
        .shadow(radius: 64)
        .padding([.leading, .trailing], 10)
        .padding(.bottom, 30)

    }
}
