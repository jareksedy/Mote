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
    @StateObject var viewModel = MoteViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView([], showsIndicators: false) {
                VStack {
                    Spacer().frame(height: 25)
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(uiColor: .systemGray6))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("MoteLogo")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 28)
                        .foregroundColor(Color(uiColor: .systemGray5))
                        .padding(.leading, 10)
                        .padding(.top, 10)
                        .onTapGesture {
                            viewModel.toast(.prompted)
                        }
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
        }
        .sheet(isPresented: $viewModel.preferencesPresented) {
            PreferencesView(viewModel: viewModel)
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(24)
        }
        .sheet(
            isPresented: $viewModel.keyboardPresented,
            onDismiss: {
                if viewModel.isFocused { viewModel.sendKey(.back) }
            }
        ) {
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
