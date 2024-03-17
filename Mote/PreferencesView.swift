//
//  PreferencesView.swift
//  Mote
//
//  Created by Ярослав on 04.03.2024.
//

import SwiftUI

struct PreferencesView: View {
    private var viewModel: MoteViewModel
    @State private var autoConnect: Bool = true
    
    var body: some View {
        NavigationStack {
            List {
                Section("App") {
                    NavigationLink("About the App", value: 0)
                    Button(action: {}, label: { Text("Rate this App") })
                }
                
                Section("Connection") {
                    Toggle("Autoconnect on start", isOn: $autoConnect)
                        .tint(.accent)
                    Button(action: {}, label: { Text("Clear all stored connection data") })
                }
                
                Section("Haptics") {
                    Toggle("Haptic feedback", isOn: $autoConnect)
                        .tint(.accent)
                }
            }
            .background(Color(uiColor: .systemGray6))
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 10) {
                        Text("Preferences")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.accentColor)
                    }
                    .padding(.leading, GlobalConstants.iconPadding)
                    .padding(.top, 15)
                    .padding(.bottom, 12.5)
                }
            }
        }
    }
    
    init(viewModel: MoteViewModel) {
        self.viewModel = viewModel
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: GlobalConstants.smallTitleSize, weight: .bold).rounded(),
            NSAttributedString.Key.foregroundColor: UIColor.accent
        ]
        
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: GlobalConstants.largetTitleSize, weight: .bold).rounded(),
            NSAttributedString.Key.foregroundColor: UIColor.accent
        ]
    }
}
