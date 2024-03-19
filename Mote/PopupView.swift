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
            VStack(spacing: 25) {
                Spacer()
                Image(systemName: type.systemName)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(type.iconColor)
                Text(type.message)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(Color(uiColor: .label))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                Spacer()
            }
            .padding([.leading, .trailing], 25)
            .frame(height: 175)
        }
        .frame(maxWidth: .greatestFiniteMagnitude)
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(32)
        .shadow(radius: 64)
        .padding([.leading, .trailing], 10)
        .padding(.bottom, 50)
        
    }
}
