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

            Image(systemName: "av.remote")
                .font(.system(size: 100, weight: .light, design: .rounded))
                .foregroundColor(.accent)

            Text("Mote \(Bundle.main.releaseVersionNumber) (\(Bundle.main.buildVersionNumber))")
                .font(.system(size: GlobalConstants.bodyFontSize, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .padding(.top, 25)

            Text("LG Smart TV Remote Control App")
                .font(.system(size: GlobalConstants.bodyFontSize, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.top, 5)

            Text("by Yaroslav Sedyshev")
                .font(.system(size: GlobalConstants.bodyFontSize, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)

            Spacer()

            HStack(spacing: 5) {
                Text("Made with")
                    .foregroundColor(.secondary)
                Text("♥")
                    .foregroundColor(.accent)
                Text("in Kazakhstan 🇰🇿")
                    .foregroundColor(.secondary)
            }
            .font(.system(size: GlobalConstants.bodyFontSize, weight: .bold, design: .rounded))
            .multilineTextAlignment(.center)
            .padding(.top, 25)

            Spacer()
                .frame(height: 25)
        }
        .padding([.leading, .trailing], 50)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "arrow.backward")
                    .font(.system(size: GlobalConstants.smallTitleSize, weight: .bold, design: .rounded))
                    .foregroundColor(.accent)
                    // .padding(.leading, GlobalConstants.iconPadding)
                    .padding(.top, 10)
                    .onTapGesture {
                        viewModel.navigationPath.removeAll()
                    }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Text("About Mote")
                    .font(.system(size: GlobalConstants.smallTitleSize, weight: .bold, design: .rounded))
                    .foregroundColor(.accent)
                    .padding(.trailing, GlobalConstants.iconPadding)
                    .padding(.top, 10)
            }
        }
    }
}
