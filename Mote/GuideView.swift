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
        VStack {
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
                Text("Frequently Asked Questions")
                    .font(.system(size: Globals.smallTitleSize, weight: .bold, design: .rounded))
                    .foregroundColor(.accent)
                    .padding(.trailing, Globals.iconPadding)
                    .padding(.top, 10)
            }
        }
    }
}
