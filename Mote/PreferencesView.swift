//
//  PreferencesView.swift
//  Mote
//
//  Created by Ярослав on 04.03.2024.
//

import SwiftUI

struct PreferencesView: View {
    @ObservedObject var viewModel: MoteViewModel
    @State private var autoConnect: Bool = true
    @State private var enterIpAlertShown: Bool = false
    @State private var tvIP: String = ""
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            List {
                Section("App") {
                    NavigationLink(value: NavigationScreens.about) {
                        Label("About Mote", systemImage: "info.circle")
                            .font(.system(size: GlobalConstants.bodyFontSize, weight: .regular, design: .rounded))
                            .foregroundColor(Color(uiColor: .lightGray))
                    }

                    Button(action: { }, label: {
                        Label("Rate this app", systemImage: "star.leadinghalf.filled")
                            .font(.system(size: GlobalConstants.bodyFontSize, weight: .regular, design: .rounded))
                            .foregroundColor(Color(uiColor: .lightGray))
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
                            .foregroundColor(Color(uiColor: .lightGray))
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
            .environment(\.defaultMinListRowHeight, 55)
            .background(Color(uiColor: .systemGray6))
            .scrollContentBackground(.hidden)
            .background(Color(uiColor: .systemGray6).edgesIgnoringSafeArea(.all))
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
