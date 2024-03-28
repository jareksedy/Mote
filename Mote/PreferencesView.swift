//
//  PreferencesView.swift
//  Mote
//
//  Created by Ярослав on 04.03.2024.
//

import SwiftUI

struct PreferencesView: View {
    @ObservedObject var viewModel: MoteViewModel
    @State private var hapticFeedback: Bool = true
    @State private var alternativeLayout: Bool = false
    @State private var enterIpAlertShown: Bool = false
    @State private var isClearAlertShown: Bool = false
    @State private var tvIP: String = ""
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            List {
                Section("App") {
                    NavigationLink(value: NavigationScreens.about) {
                        Label("About Mote", systemImage: "info.circle")
                            .font(.system(size: GlobalConstants.bodyFontSize, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                    }
                    
                    Toggle("Alternative layout", systemImage: "circle.grid.2x2", isOn: $alternativeLayout)
                        .tint(.accent)
                        .font(.system(size: GlobalConstants.bodyFontSize, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)

                    Button(action: { }, label: {
                        Label("Rate us on App store", systemImage: "star.leadinghalf.filled")
                            .font(.system(size: GlobalConstants.bodyFontSize, weight: .medium, design: .rounded))
                            .foregroundColor(.accentColor)
                    })
                }
                
                Section("Connection") {
                    NavigationLink(value: NavigationScreens.discover) {
                        Label("Discover TVs on LAN", systemImage: "cable.coaxial")
                            .font(.system(size: GlobalConstants.bodyFontSize, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                    }
                    
                    Button(action: {}, label: {
                        Label("Manually enter your TV's IP", systemImage: "text.append")
                            .font(.system(size: GlobalConstants.bodyFontSize, weight: .medium, design: .rounded))
                            .foregroundColor(.accentColor)
                    })
                    
                    Button(action: { isClearAlertShown.toggle() }, label: {
                        Label("Reset all connection data", systemImage: "gear.badge.xmark")
                            .font(.system(size: GlobalConstants.bodyFontSize, weight: .medium, design: .rounded))
                            .foregroundColor(.accentColor)
                    })
                }
                
                Section("Haptics") {
                    Toggle("Haptic feedback", systemImage: "hand.tap", isOn: $hapticFeedback)
                        .tint(.accent)
                        .font(.system(size: GlobalConstants.bodyFontSize, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                }
                
                Section {
                    HStack {
                        Spacer()
                        Text("Mote App \(Bundle.main.releaseVersionNumber) (\(Bundle.main.buildVersionNumber))")
                            .font(.system(size: 12, weight: .regular, design: .monospaced))
                            .foregroundStyle(.tertiary)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                }
                .listRowBackground(Color.clear)
            }
            .environment(\.defaultMinListRowHeight, 55)
            .background(Color(uiColor: .systemGray6))
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Preferences")
                        .font(.system(size: GlobalConstants.smallTitleSize, weight: .bold, design: .rounded))
                        .foregroundColor(.accent)
                        .padding(.leading, GlobalConstants.iconPadding)
                        .padding(.top, 10)
                }
            }
            .navigationDestination(for: NavigationScreens.self) { screen in
                switch screen {
                case .about:
                    AboutView(viewModel: viewModel)
                case .discover:
                    DeviceDiscoveryView(viewModel: viewModel)
                case .preferences:
                    PreferencesView(viewModel: viewModel)
                }
            }
            .alert(
                "Would you like to reset all connection data?",
                isPresented: $isClearAlertShown,
                actions: {
                    Button("Reset", role: .destructive) {
                        AppSettings.shared.host = nil
                        AppSettings.shared.clientKey = nil
                        viewModel.disconnect()
                        viewModel.connectAndRegister()
                        viewModel.preferencesPresented = false
                    }
                    Button("Cancel", role: .cancel) {}
                },
                message: {
                    Text("Resetting all stored connection data will require you to add your TV to the app again.")
                }
            )
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
    
    private func isValidIP(ip: String) -> Bool {
        let ipAddressRegex = #"^(25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)\.((25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)\.){2}(25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)$"#
        
        return NSPredicate(format: "SELF MATCHES %@", ipAddressRegex).evaluate(with: ip)
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
