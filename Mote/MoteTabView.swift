//
//  MoteTabView.swift
//  Mote
//
//  Created by Ярослав Седышев on 27.03.2024.
//

import SwiftUI

struct MoteTabView: View {
    @Environment(\.scenePhase) var scenePhase
    @State private var selection: TabSelection
    @ObservedObject var viewModel: MoteViewModel
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                MoteView(viewModel: viewModel)
                    .tag(TabSelection.buttons)
            }
            .tabViewStyle(.page(indexDisplayMode: .automatic))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
    }
    
    init(selection: TabSelection = .buttons, viewModel: MoteViewModel) {
        self.viewModel = viewModel
        self.selection = selection
    }
    
    enum TabSelection {
        case buttons
        case pointer
    }
}
