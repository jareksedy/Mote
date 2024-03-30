//
//  PreferencesView.swift
//  Mote
//
//  Created by Ярослав on 04.03.2024.
//

import SwiftUI
import MaskedTextFieldSwiftUI

struct PreferencesView: View {
    @ObservedObject var viewModel: MoteViewModel

    @State private var alternativeLayout: Bool = false
    @State private var enterIpAlertShown: Bool = false
    @State private var isClearAlertShown: Bool = false

    @State var tvIP = "192.168."

    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            List {
                Section("App") {
                    NavigationLink(value: NavigationScreens.about) {
                        Label("About Mote", systemImage: "info.circle")
                            .font(.system(size: Globals.bodyFontSize, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                    }

                    NavigationLink(value: NavigationScreens.guide) {
                        Label("Frequently Asked Questions", systemImage: "book.pages")
                            .font(.system(size: Globals.bodyFontSize, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                    }

//                    Button(action: { }, label: {
//                        Label("Rate us on App store", systemImage: "hand.thumbsup")
//                            .font(.system(size: Globals.bodyFontSize, weight: .medium, design: .rounded))
//                            .foregroundColor(.accentColor)
//                    })
                }

                Section("Connection") {
                    NavigationLink(value: NavigationScreens.discover) {
                        Label("Discover TV on LAN", systemImage: "network")
                            .font(.system(size: Globals.bodyFontSize, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                    }

                    Button(action: { enterIpAlertShown.toggle() }, label: {
                        Label("Manually input IP address", systemImage: "hand.point.up.left.and.text")
                            .font(.system(size: Globals.bodyFontSize, weight: .medium, design: .rounded))
                            .foregroundColor(.accentColor)
                    })

                    Button(action: { isClearAlertShown.toggle() }, label: {
                        Label("Reset connection data", systemImage: "gear.badge.xmark")
                            .font(.system(size: Globals.bodyFontSize, weight: .medium, design: .rounded))
                            .foregroundColor(.accentColor)
                    })
                }

                Section("Layout and Haptics") {
                    Toggle("Alternative layout", systemImage: "square.grid.3x3.square", isOn: $alternativeLayout)
                        .tint(.accent)
                        .font(.system(size: Globals.bodyFontSize, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            alternativeLayout.toggle()
                        }

                    Toggle("Haptic feedback", systemImage: "hand.tap", isOn: $viewModel.preferencesHapticFeedback)
                        .tint(.accent)
                        .font(.system(size: Globals.bodyFontSize, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.preferencesHapticFeedback.toggle()
                        }
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
                        .font(.system(size: Globals.smallTitleSize, weight: .bold, design: .rounded))
                        .foregroundColor(.accent)
                        .padding(.leading, Globals.iconPadding)
                        .padding(.top, 10)
                }
            }
            .navigationDestination(for: NavigationScreens.self) { screen in
                switch screen {
                case .about:
                    AboutView(viewModel: viewModel)
                case .guide:
                    GuideView(viewModel: viewModel)
                case .discover:
                    DeviceDiscoveryView(viewModel: viewModel)
                }
            }
            .alert(
                "Reset all connection data?",
                isPresented: $isClearAlertShown,
                actions: {
                    Button("Reset", role: .destructive, action: viewModel.resetConnectionData)
                    Button("Cancel", role: .cancel, action: {})
                }, message: {
                    Text("You will need to reconnect your TV.")
                }
            )
            .alert(
                "IP address of your TV",
                isPresented: $enterIpAlertShown
            ) {
                TextField("Enter IP", text: $tvIP, prompt: Text("192.168."))
                    .keyboardType(.numbersAndPunctuation)
                Button("Save", action: { viewModel.setHostManually(host: tvIP) })
                Button("Cancel", role: .cancel, action: {})
            }
            .onAppear {
                tvIP = "192.168."
            }
        }
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
