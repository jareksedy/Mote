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
            .background(Color(uiColor: .systemGray6))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Mote App")
                        .font(.system(size: GlobalConstants.smallTitleSize, weight: .bold, design: .rounded))
                        .foregroundColor(.accent)
                        .padding(.leading, GlobalConstants.iconPadding)
                        .padding(.top, 10)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "keyboard.fill")
                        .font(.system(size: GlobalConstants.iconSize, weight: .bold, design: .rounded))
                        .foregroundColor(Color(uiColor: .systemGray))
                        .padding(.trailing, GlobalConstants.iconPadding)
                        .padding(.top, 10)
                        .onTapGesture {
                            viewModel.keyboardPresented = true
                        }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: GlobalConstants.iconSize, weight: .bold, design: .rounded))
                        .foregroundColor(Color(uiColor: .systemGray))
                        .padding(.trailing, GlobalConstants.iconPadding)
                        .padding(.top, 10)
                        .onTapGesture {
                            viewModel.preferencesPresented = true
                        }
                }
            }
            .sheet(isPresented: $viewModel.preferencesPresented, onDismiss: {
                viewModel.navigationPath.removeAll()
            }) {
                PreferencesView(viewModel: viewModel)
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(24)
            }
            .sheet(isPresented: $viewModel.deviceDiscoveryPresented) {
                DeviceDiscoveryView(viewModel: viewModel)
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(24)
            }
            .sheet(isPresented: $viewModel.keyboardPresented, onDismiss: {
                    if viewModel.isFocused { viewModel.sendKey(.back) }
                }) {
                KeyboardView(showModal: $viewModel.keyboardPresented, viewModel: viewModel)
                    .presentationDetents([.height(55)])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(12)
            }
            .popup(isPresented: $viewModel.isToastPresented) {
                ToastView(configuration: viewModel.toastConfiguration!)
            } customize: { popup in
                popup
                    .type(.toast)
                    .position(.bottom)
                    .animation(.bouncy(duration: 0.4))
                    .backgroundColor(Color(uiColor: .systemBackground).opacity(0.30))
                    .autohideIn(viewModel.toastConfiguration?.autohideIn)
                    .closeOnTap(viewModel.toastConfiguration?.closeOnTap ?? true)
                    .closeOnTapOutside(viewModel.toastConfiguration?.closeOnTapOutside ?? true)
            }
            .onChange(of: scenePhase) {
                switch scenePhase {
                case .active:
                    viewModel.connectAndRegister()
                default:
                    break
                }
            }
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
