//
//  PopupView.swift
//  Mote
//
//  Created by Ярослав Седышев on 18.03.2024.
//

import SwiftUI

struct PopupView: View {
    var type: PopupType
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 25) {
                Image(systemName: type.systemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .font(.system(size: 32, weight: .regular, design: .rounded))
                    .foregroundColor(type.iconColor)
                    .padding(.top, type == .disconnected || type == .tvGoingOff ? -3 : 0)
                Text(type.message)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(Color(uiColor: .label))
                    .multilineTextAlignment(.leading)
                    .lineSpacing(4)
                Spacer()
            }
            .padding(.top, 2.5)
            .padding(.leading, 40)
            .frame(height: 150)
        }
        .frame(maxWidth: .greatestFiniteMagnitude)
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(24)
        .shadow(radius: 128)
        .padding([.leading, .trailing], 10)
        .padding(.bottom, 35)
        
    }
}
