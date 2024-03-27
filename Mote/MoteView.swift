//
//  MoteView.swift
//  Mote
//
//  Created by Ярослав on 04.03.2024.
//

import SwiftUI
import PopupView

struct MoteView: View {
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var viewModel: MoteViewModel
    
    var body: some View {
        ScrollView([], showsIndicators: false) {
            VStack {
                Spacer().frame(height: 22.5)
                
                if viewModel.colorButtonsPresented {
                    MoteButtonGroupColorView()
                        .environmentObject(viewModel)
                } else {
                    MoteButtonGroupDefaultView()
                        .environmentObject(viewModel)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.keyboard)
        }
    }
}
