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
            Image(systemName: "av.remote")
                .font(.system(size: 64, weight: .light, design: .rounded))
                .foregroundColor(.accent)
            
            Spacer().frame(height: 25)
            
            Text("Mote")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "arrow.backward")
                    .font(.system(size: GlobalConstants.smallTitleSize, weight: .bold, design: .rounded))
                    .foregroundColor(.accent)
                    //.padding(.leading, GlobalConstants.iconPadding)
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
