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
                    VStack {
                        Label("\(device.name) (\(device.host))", systemImage: "tv")
                            .font(.system(size: Globals.bodyFontSize, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                    }
                    .onTapGesture {
                        AppSettings.shared.host = device.host
                        AppSettings.shared.clientKey = nil
                        viewModel.disconnect()
                        viewModel.connectAndRegister()
                        viewModel.preferencesPresented = false
                    }
                }
            } else {
                Spacer()

                ActivityIndicatorView(
                    isVisible: $viewModel.isDiscoverDevicesActivityIndicatorShown,
                    type: .gradient([Color(uiColor: .systemGray6), .accent], .round, lineWidth: 6)
                )
                     .frame(width: 150, height: 150)
                     .foregroundColor(.accentColor)
                     .padding(.top, 50)

                Spacer()

                VStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundStyle(.white, .accent)
                        // .padding(.top, 25)
                        .symbolEffect(.bounce.up.byLayer, value: animateSymbol)
                        .onAppear {
                            animateSymbol.toggle()
                        }

                    Spacer().frame(height: 20)

                    Text("TV must be on and connected\nto the same network")
                        .font(.system(size: Globals.bodyFontSize, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(Globals.lineHeight)
                        .padding([.leading, .trailing], 50)
                }

                Spacer().frame(height: 25)
            }
        }
        .environment(\.defaultMinListRowHeight, 55)
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
                Text("Discover TV on LAN")
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
