//
//  PreferencesView.swift
//  Mote
//
//  Created by Ярослав on 04.03.2024.
//

import SwiftUI

struct PreferencesView: View {
    @ObservedObject var viewModel: MoteViewModel

    @State private var enterIpAlertShown: Bool = false
    @State private var isClearAlertShown: Bool = false

    @State var tvIP = "192.168."

    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            List {
                Section(Strings.SectionHeaders.app) {
                    NavigationLink(value: NavigationScreens.about) {
                        Label(Strings.Titles.aboutMote, systemImage: "info.circle")
                            .font(.system(size: Globals.bodyFontSize, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                    }

                    NavigationLink(value: NavigationScreens.guide) {
                        Label(Strings.Titles.faq, systemImage: "book.pages")
                            .font(.system(size: Globals.bodyFontSize, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                    }
                }

                Section(Strings.SectionHeaders.connection) {
                    NavigationLink(value: NavigationScreens.discover) {
                        Label(Strings.Titles.connectTV, systemImage: "network")
                            .font(.system(size: Globals.bodyFontSize, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                    }

                    Button(action: { enterIpAlertShown.toggle() }, label: {
                        Label(Strings.Titles.manuallyEnterIP, systemImage: "hand.point.up.left.and.text")
                            .font(.system(size: Globals.bodyFontSize, weight: .medium, design: .rounded))
                            .foregroundColor(.accentColor)
                    })

                    Button(action: { isClearAlertShown.toggle() }, label: {
                        Label(Strings.Titles.resetConnectionData, systemImage: "gear.badge.xmark")
                            .font(.system(size: Globals.bodyFontSize, weight: .medium, design: .rounded))
                            .foregroundColor(.accentColor)
                    })
                }

                Section(Strings.SectionHeaders.layoutAndHaptics) {
                    Toggle(
                        Strings.Titles.alternativeLayout,
                        systemImage: "circle.grid.2x2",
                        isOn: $viewModel.preferencesAlternativeView
                    )
                    .tint(.accent)
                    .font(.system(size: Globals.bodyFontSize, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.preferencesAlternativeView.toggle()
                    }

                    Toggle(
                        Strings.Titles.hapticFeedback,
                        systemImage: "hand.tap",
                        isOn: $viewModel.preferencesHapticFeedback
                    )
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
                        Text(
                            "\(Strings.General.appName) " +
                            "\(Bundle.main.releaseVersionNumber) " +
                            "(\(Bundle.main.buildVersionNumber))"
                        )
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
                    Text(Strings.Titles.preferences)
                        .font(.system(size: Globals.smallTitleSize, weight: .bold, design: .rounded))
                        .foregroundColor(.accent)
                        .padding(.leading, Globals.iconPadding)
                        .padding(.top, 10)
                }
            }
            .navigationDestination(for: NavigationScreens.self) { screen in
                switch screen {
                case .about: AboutView(viewModel: viewModel)
                case .guide: GuideView(viewModel: viewModel)
                case .discover: DeviceDiscoveryView(viewModel: viewModel)
                }
            }
            .alert(
                Strings.ResetConnectionData.title,
                isPresented: $isClearAlertShown,
                actions: {
                    Button(Strings.General.reset, role: .destructive, action: viewModel.resetConnectionData)
                    Button(Strings.General.cancel, role: .cancel, action: {})
                }, message: {
                    Text(Strings.ResetConnectionData.message)
                }
            )
            .alert(
                Strings.InputIP.inputIPMessage,
                isPresented: $enterIpAlertShown
            ) {
                TextField(text: $tvIP, prompt: Text(Strings.InputIP.inputIPPrompt), label: {})
                    .keyboardType(.numbersAndPunctuation)
                Button(Strings.General.save, action: { viewModel.setHostManually(host: tvIP) })
                Button(Strings.General.cancel, role: .cancel, action: {})
            }
            .onAppear {
                tvIP = "192.168."
            }
        }
    }
}
