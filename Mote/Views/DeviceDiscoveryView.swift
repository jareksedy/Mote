//
//  DeviceDiscoveryView.swift
//  Mote
//
//  Created by Ярослав Седышев on 23.03.2024.
//

import SwiftUI
import ActivityIndicatorView

struct DeviceDiscoveryView: View {
    @ObservedObject var viewModel: MoteViewModel
    @State private var animateSymbol: Bool = false
    var body: some View {
        VStack {
            if viewModel.deviceDiscoveryFinished {
                List(viewModel.devices) { device in
                    Section("Discovered devices") {
                        Label("\(device.name) (\(device.host))", systemImage: "tv")
                            .font(.system(size: Globals.bodyFontSize, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                            .onTapGesture {
                                AppSettings.shared.host = device.host
                                AppSettings.shared.clientKey = nil
                                viewModel.disconnect()
                                viewModel.connectAndRegister()
                                viewModel.preferencesPresented = false
                            }
                    }
                }
            } else {
                Spacer()

                ActivityIndicatorView(
                    isVisible: $viewModel.isDiscoverDevicesActivityIndicatorShown,
                    type: .gradient([Color(uiColor: .systemGray6), .accent], .round, lineWidth: 6)
                )
                .frame(width: 175, height: 175)
                .foregroundColor(.accentColor)
                .padding(.top, 50)

                Spacer()

                TipView(
                    systemName: "exclamationmark.circle.fill",
                    color: .accent,
                    message: Strings.ConnectTV.importantNote
                )

                Spacer().frame(height: 25)
            }
        }
        .environment(\.defaultMinListRowHeight, 55)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemGray6))
        .scrollContentBackground(.hidden)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "arrow.backward")
                    .font(.system(size: Globals.smallTitleSize, weight: .bold, design: .rounded))
                    .foregroundColor(.accent)
                    .padding(.top, 10)
                    .onTapGesture {
                        viewModel.navigationPath.removeAll()
                    }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Text(Strings.Titles.connectTV)
                    .font(.system(size: Globals.smallTitleSize, weight: .bold, design: .rounded))
                    .foregroundColor(.accent)
                    .padding(.trailing, Globals.iconPadding)
                    .padding(.top, 10)
            }
        }
        .onAppear {
            viewModel.discoverDevices()
        }
    }
}
