//
//  DeviceDiscoveryView.swift
//  Mote
//
//  Created by Ярослав Седышев on 23.03.2024.
//

import SwiftUI

struct DeviceDiscoveryView: View {
    @ObservedObject var viewModel: MoteViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.deviceDiscoveryFinished {
                    List(viewModel.devices) { device in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(device.name)
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            Text(device.host)
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                                .foregroundColor(.gray)
                        }
                        .padding([.top, .bottom], 5)
                        .onTapGesture {
                            AppSettings.shared.host = device.host
                            AppSettings.shared.clientKey = nil
                            viewModel.disconnect()
                            viewModel.connectAndRegister(host: device.host)
                            viewModel.deviceDiscoveryPresented = false
                        }
                    }
                } else {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.accent)
                }
            }
            .background(Color(uiColor: .systemGray6))
            .scrollContentBackground(.hidden)
            .navigationTitle("Discover TV")
            .onAppear {
                viewModel.discoverDevices()
            }
        }
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
}
