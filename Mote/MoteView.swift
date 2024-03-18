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
                    HStack(spacing: -5) {
                        Image(systemName: "m.square.fill")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.accentColor)
                            .onTapGesture {}
                    }
                    .padding(.leading, GlobalConstants.iconPadding)
                    .padding(.top, 10)

                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "keyboard.fill")
                        .font(.system(size: GlobalConstants.iconSize, weight: .bold, design: .rounded))
                        .foregroundColor(viewModel.isConnected ? Color(uiColor: .systemGray) : Color(uiColor: .systemGray3))
                        .padding(.trailing, GlobalConstants.iconPadding)
                        .padding(.top, 10)
                        .onTapGesture {
                            guard viewModel.isConnected else { return }
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
        .popup(isPresented: $viewModel.isPopupPresentedPrompted) {
            PopupView(type: .prompted)
        } customize: { popup in
            popup
                .type(.toast)
                .position(.bottom)
                .animation(.bouncy(duration: 0.45))
                .backgroundColor(Color(uiColor: .systemBackground).opacity(0.30))
        }
        .popup(isPresented: $viewModel.isPopupPresentedTVGoingOff) {
            PopupView(type: .tvGoingOff)
        } customize: { popup in
            popup
                .type(.toast)
                .position(.bottom)
                .animation(.bouncy(duration: 0.45))
                .backgroundColor(Color(uiColor: .systemBackground).opacity(0.30))
                .autohideIn(4)
                .closeOnTap(true)
                .closeOnTapOutside(true)
        }
        .popup(isPresented: $viewModel.isPopupPresentedDisconnected) {
            PopupView(type: .disconnected)
        } customize: { popup in
            popup
                .type(.toast)
                .position(.bottom)
                .animation(.bouncy(duration: 0.45))
                .backgroundColor(Color(uiColor: .systemBackground).opacity(0.30))
                .autohideIn(4)
                .closeOnTap(true)
                .closeOnTapOutside(true)
        }
        .popup(isPresented: $viewModel.isPopupPresentedConnected) {
            PopupView(type: .connected)
        } customize: { popup in
            popup
                .type(.toast)
                .position(.bottom)
                .animation(.bouncy(duration: 0.45))
                .backgroundColor(Color(uiColor: .systemBackground).opacity(0.30))
                .autohideIn(4)
                .closeOnTap(true)
                .closeOnTapOutside(true)
        }
        .onChange(of: scenePhase) {
            switch scenePhase {
            case .active:
                viewModel.connectAndRegister()
            case .background:
                viewModel.disconnect()
            case .inactive:
                break
            @unknown default:
                break
            }
        }
    }
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: GlobalConstants.smallTitleSize,
                                                           weight: .bold).rounded(),
            NSAttributedString.Key.foregroundColor: UIColor.accent
        ]
        
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: GlobalConstants.largetTitleSize,
                                                           weight: .bold).rounded(),
            NSAttributedString.Key.foregroundColor: UIColor.accent
        ]
    }
}
