//
//  GuideView.swift
//  Mote
//
//  Created by Ярослав Седышев on 30.03.2024.
//

import SwiftUI

struct GuideView: View {
    @ObservedObject var viewModel: MoteViewModel
    var body: some View {
        ScrollView {
            Spacer().frame(height: 25)
            
            DisclosureGroup(content: {
                Text(Strings.FAQ.a1)
                    .font(.system(size: Globals.bodyFontSize, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(Globals.lineHeight)
            }, label: {
                Text(Strings.FAQ.q1)
                    .font(.system(size: Globals.smallTitleSize, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(Globals.lineHeight)
            })
            .padding([.leading, .trailing], 25)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemGray6))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "arrow.backward")
                    .font(.system(size: Globals.smallTitleSize, weight: .bold, design: .rounded))
                    .foregroundColor(.accent)
                    .padding(.top, 10)
                    .onTapGesture {
                        viewModel.navigationPath.removeAll()
                    }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Text(Strings.Titles.faq)
                    .font(.system(size: Globals.smallTitleSize, weight: .bold, design: .rounded))
                    .foregroundColor(.accent)
                    .padding(.trailing, Globals.iconPadding)
                    .padding(.top, 10)
            }
        }
    }
}
