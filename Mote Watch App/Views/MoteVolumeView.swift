//
//  MoteVolumeView.swift
//  Mote Watch App
//
//  Created by Ярослав on 05.03.2024.
//

import SwiftUI

struct MoteVolumeView: View {
    @EnvironmentObject var viewModel: MoteViewModel
    
    var body: some View {
        NavigationStack {
            Slider(
                value: $viewModel.tvVolumeLevel,
                in: 0...100,
                label: {},
                minimumValueLabel: {
                    Image(systemName: "speaker.minus")
                        .foregroundColor(.gray)
                        .font(.system(
                            size: GlobalConstants.buttonFontSize,
                            weight: .bold,
                            design: .rounded))
                },
                maximumValueLabel: {
                    Image(systemName: "speaker.plus")
                        .foregroundColor(.gray)
                        .font(.system(
                            size: GlobalConstants.buttonFontSize,
                            weight: .bold,
                            design: .rounded))
                })
            .padding()
            .navigationTitle("Volume: \(Int(viewModel.tvVolumeLevel))")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
