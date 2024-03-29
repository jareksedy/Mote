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
                    Label("\(device.host)", systemImage: "tv")
                        .font(.system(size: GlobalConstants.bodyFontSize, weight: .bold, design: .rounded))
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            AppSettings.shared.host = device.host
                            AppSettings.shared.clientKey = nil
                            viewModel.disconnect()
                            viewModel.connectAndRegister()
                            viewModel.deviceDiscoveryPresented = false
                            viewModel.preferencesPresented = false
                        }
                }
            } else {
                Spacer()

                ActivityIndicatorView(
                    isVisible: $viewModel.isDiscoverDevicesActivityIndicatorShown,
                    type: .growingArc(.accent, lineWidth: 4)
                )
                     .frame(width: 100.0, height: 100.0)
                     .foregroundColor(.accentColor)

                Spacer()

                VStack(alignment: .leading) {
                    HStack(spacing: 20) {
                        Image(systemName: "exclamationmark.circle.fill")
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundStyle(.white, .accent)
                            .shadow(color: .accent, radius: 16)
                            .symbolEffect(.bounce.up.byLayer, value: animateSymbol)
                            .onAppear {
                                animateSymbol.toggle()
                            }
                        Text("You must be connected to the same Wi-Fi network")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                            .lineSpacing(3)
                        Spacer()
                    }
                    .padding(.top, 1)
                    .padding(.leading, 25)
                    .padding(.trailing, 5)
                    .frame(height: 100)
                }
                .padding([.leading, .trailing], 10)
                .padding(.bottom, 25)
            }
        }
        .environment(\.defaultMinListRowHeight, 55)
        .background(Color(uiColor: .systemGray6))
        .scrollContentBackground(.hidden)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "arrow.backward")
                    .font(.system(size: GlobalConstants.smallTitleSize, weight: .bold, design: .rounded))
                    .foregroundColor(.accent)
                    .padding(.top, 10)
                    .onTapGesture {
                        viewModel.navigationPath.removeAll()
                    }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Text("Discover TVs on LAN")
                    .font(.system(size: GlobalConstants.smallTitleSize, weight: .bold, design: .rounded))
                    .foregroundColor(.accent)
                    .padding(.trailing, GlobalConstants.iconPadding)
                    .padding(.top, 10)
            }
        }
        .onAppear {
            viewModel.discoverDevices()
        }
    }
}
