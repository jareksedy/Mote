//
//  MoteView.swift
//  Mote
//
//  Created by Ярослав on 04.03.2024.
//

import SwiftUI

struct MoteView: View {
    @EnvironmentObject var viewModel: MoteViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(uiColor: .systemGray6).ignoresSafeArea())
            .ignoresSafeArea(.all)
            .navigationTitle("LGTV")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "ellipsis")
                        .font(.system(size: GlobalConstants.iconSize, weight: .bold, design: .rounded))
                        .foregroundColor(Color(uiColor: .systemGray))
                        .padding(.leading, GlobalConstants.iconPadding)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: GlobalConstants.iconSize, weight: .bold, design: .rounded))
                        .foregroundColor(Color(uiColor: .systemGray))
                        .padding(.trailing, GlobalConstants.iconPadding)
                        .onTapGesture {
                            viewModel.presentPreferencesView()
                        }
                }
            }
            .sheet(isPresented: $viewModel.preferencesPresented) {
                PreferencesView()
                    .presentationCornerRadius(24)
            }
        }
    }
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: GlobalConstants.smallTitleSize, weight: .bold).rounded(),
            NSAttributedString.Key.foregroundColor: UIColor.systemGray
        ]
        
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: GlobalConstants.largetTitleSize, weight: .bold).rounded(),
            NSAttributedString.Key.foregroundColor: UIColor.systemGray
        ]
    }
}
