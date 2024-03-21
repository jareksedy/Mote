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
    @State private var enterIpAlertShown: Bool = false
    @State private var tvIP: String = ""
    
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
                    Button(action: { enterIpAlertShown.toggle() }, label: { Text("Manually enter your TV's IP") })
                    Button(action: {}, label: { Text("Clear all stored connection data") })
                }
                
                Section("Haptics") {
                    Toggle("Haptic feedback", isOn: $autoConnect)
                        .tint(.accent)
                }
            }
            .background(Color(uiColor: .systemGray6))
            .scrollContentBackground(.hidden)
            .navigationTitle("Preferences")
            .alert("Enter IP", isPresented: $enterIpAlertShown) {
                TextField("192.168....", text: $tvIP)
                Button("Cancel", role: .cancel, action: {})
                Button("Enter", action: submitHostIP)
                
            }
        }
    }
    
    private func submitHostIP() {
        guard isValidIP(ip: tvIP) else {
            return
        }
        AppSettings.shared.host = tvIP
        viewModel.disconnect()
        viewModel.connectAndRegister()
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
    
    private func isValidIP(ip: String) -> Bool {
        let ipAddressRegex = #"^(25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)\.((25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)\.){2}(25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)$"#
        
        return NSPredicate(format: "SELF MATCHES %@", ipAddressRegex).evaluate(with: ip)
    }
}
