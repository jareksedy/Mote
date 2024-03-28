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
                            viewModel.connectAndRegister(host: device.host)
                            viewModel.deviceDiscoveryPresented = false
                            viewModel.preferencesPresented = false
                        }
                }
            } else {
                ActivityIndicatorView(isVisible: $viewModel.isDiscoverDevicesActivityIndicatorShown, type: .growingArc(.accent, lineWidth: 4))
                     .frame(width: 100.0, height: 100.0)
                     .foregroundColor(.accentColor)
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
