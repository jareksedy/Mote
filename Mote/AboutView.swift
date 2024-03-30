//
//  AboutView.swift
//  Mote
//
//  Created by Ярослав on 27.03.2024.
//

import SwiftUI

struct AboutView: View {
    @ObservedObject var viewModel: MoteViewModel
    var body: some View {
        VStack {
            Spacer()

            VStack {
                Image(systemName: "av.remote")
                    .font(.system(size: 100, weight: .light, design: .rounded))
                    .foregroundColor(.accent)

                Text("Mote \(Bundle.main.releaseVersionNumber) (\(Bundle.main.buildVersionNumber))")
                    .font(.system(size: Globals.bodyFontSize, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                    .padding(.top, 25)
                    .lineSpacing(Globals.lineHeight)

                Text("LG Smart TV Remote Control App\nby Yaroslav Sedyshev")
                    .font(.system(size: Globals.bodyFontSize, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.top, 5)
                    .lineSpacing(Globals.lineHeight)
            }
            .padding(.top, 25)

            Spacer()

            HStack(spacing: 5) {
                Text("Made with")
                    .foregroundColor(.primary)
                Text("♥")
                    .foregroundColor(.accent)
                Text("in Kazakhstan 🇰🇿")
                    .foregroundColor(.primary)
            }
            .font(.system(size: Globals.bodyFontSize, weight: .bold, design: .rounded))
            .multilineTextAlignment(.center)
            .lineSpacing(Globals.lineHeight)

            Spacer()
                .frame(height: 25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemGray6))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "arrow.backward")
                    .font(.system(size: Globals.smallTitleSize, weight: .bold, design: .rounded))
                    .foregroundColor(.accent)
                    // .padding(.leading, GlobalConstants.iconPadding)
                    .padding(.top, 10)
                    .onTapGesture {
                        viewModel.navigationPath.removeAll()
                    }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Text("About the app")
                    .font(.system(size: Globals.smallTitleSize, weight: .bold, design: .rounded))
                    .foregroundColor(.accent)
                    .padding(.trailing, Globals.iconPadding)
                    .padding(.top, 10)
            }
        }
    }
}
