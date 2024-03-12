//
//  PreferencesView.swift
//  Mote
//
//  Created by Ярослав on 04.03.2024.
//

import SwiftUI

struct PreferencesView: View {
    private var viewModel: MoteViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    viewModel.sendKey(.down)
                }, label: {
                    Text("Down")
                })
                .buttonRepeatBehavior(.enabled)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(uiColor: .systemGray6).ignoresSafeArea())
            .ignoresSafeArea(.all)
            .navigationTitle("Preferences")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "xmark.app.fill")
                        .font(.system(size: GlobalConstants.iconSize, weight: .bold, design: .rounded))
                        .foregroundColor(Color(uiColor: .systemGray))
                        .padding(.trailing, GlobalConstants.iconPadding)
                        .onTapGesture {
                            viewModel.preferencesPresented = false
                        }
                }
            }
        }
    }
    
    init(viewModel: MoteViewModel) {
        self.viewModel = viewModel
        
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
