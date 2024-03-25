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
                    NavigationLink(destination: Text("")) {
                        Label("About Mote", systemImage: "info.circle")
                            .font(.system(size: GlobalConstants.bodyFontSize, weight: .regular, design: .rounded))
                            .foregroundColor(Color(uiColor: .lightGray))
                    }
                    
                    Button(action: {}, label: {
                        Label("Rate this app", systemImage: "star.leadinghalf.filled")
                            .font(.system(size: GlobalConstants.bodyFontSize, weight: .regular, design: .rounded))
                            .foregroundColor(.accentColor)
                    })
                }
                
                Section("Connection") {
                    NavigationLink(destination: DeviceDiscoveryView(viewModel: viewModel)) {
                        Label("Search devices on LAN", systemImage: "antenna.radiowaves.left.and.right")
                            .font(.system(size: GlobalConstants.bodyFontSize, weight: .regular, design: .rounded))
                            .foregroundColor(Color(uiColor: .lightGray))
                    }
                    
                    Button(action: {}, label: {
                        Label("Reset all connection data", systemImage: "gear.badge.xmark")
                            .font(.system(size: GlobalConstants.bodyFontSize, weight: .regular, design: .rounded))
                            .foregroundColor(.accentColor)
                    })
                }
                
                Section("Haptics") {
                    Toggle("Haptic feedback", systemImage: "hand.tap", isOn: $autoConnect)
                        .tint(.accent)
                        .font(.system(size: GlobalConstants.bodyFontSize, weight: .regular, design: .rounded))
                        .foregroundColor(Color(uiColor: .lightGray))
                }
                
                Section {
                    HStack {
                        Spacer()
                        Text("Mote App \(Bundle.main.releaseVersionNumber) (\(Bundle.main.buildVersionNumber))")
                            .font(.system(size: 12, weight: .regular, design: .monospaced))
                            .foregroundStyle(.gray.opacity(0.5))
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                }
                .listRowBackground(Color.clear)
            }
            .environment(\.defaultMinListRowHeight, 50)
            .background(Color(uiColor: .systemGray6))
            .scrollContentBackground(.hidden)
            .background(Color(uiColor: .systemGray6).edgesIgnoringSafeArea(.all))
            .navigationTitle("Preferences")
            .navigationBarTitleDisplayMode(.inline)
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
            //NSAttributedString.Key.font: UIFont.systemFont(ofSize: GlobalConstants.smallTitleSize, weight: .bold).rounded(),
            NSAttributedString.Key.foregroundColor: UIColor.accent
        ]
        
        UINavigationBar.appearance().largeTitleTextAttributes = [
            //NSAttributedString.Key.font: UIFont.systemFont(ofSize: GlobalConstants.largetTitleSize, weight: .bold).rounded(),
            NSAttributedString.Key.foregroundColor: UIColor.accent
        ]
    }
    
    private func isValidIP(ip: String) -> Bool {
        let ipAddressRegex = #"^(25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)\.((25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)\.){2}(25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)$"#
        
        return NSPredicate(format: "SELF MATCHES %@", ipAddressRegex).evaluate(with: ip)
    }
}
