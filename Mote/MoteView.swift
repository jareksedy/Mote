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
            }
            .ignoresSafeArea(.keyboard)
            .background(Color(uiColor: .systemGray6))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 7) {
                        Image(systemName: viewModel.isConnected ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .font(.system(size: GlobalConstants.iconSize, weight: .bold, design: .rounded))
                            .foregroundColor(viewModel.isConnected ? .accent : .secondary)
                        Text("Mote")
                            .font(.system(size: GlobalConstants.smallTitleSize, weight: .bold, design: .rounded))
                            .foregroundColor(viewModel.isConnected ? .accent : .secondary)
                    }
                    .padding(.leading, GlobalConstants.iconPadding)
                    .padding(.top, 10)
                    .onTapGesture {
                        viewModel.toast(.prompted)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "keyboard.fill")
                        .font(.system(size: GlobalConstants.iconSize, weight: .bold, design: .rounded))
                        .foregroundColor(.secondary)
                        .padding(.trailing, GlobalConstants.iconPadding)
                        .padding(.top, 10)
                        .onTapGesture {
                            viewModel.keyboardPresented = true
                        }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: GlobalConstants.iconSize, weight: .bold, design: .rounded))
                        .foregroundColor(.secondary)
                        .padding(.trailing, GlobalConstants.iconPadding)
                        .padding(.top, 10)
                        .onTapGesture {
                            viewModel.preferencesPresented = true
                        }
                }
            }
            .sheet(
                isPresented: $viewModel.preferencesPresented,
                onDismiss: {
                    viewModel.navigationPath.removeAll()
                }, content: {
                    PreferencesView(viewModel: viewModel)
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(24)
                }
            )
            .sheet(
                isPresented: $viewModel.keyboardPresented,
                onDismiss: {
                    if viewModel.isFocused { viewModel.sendKey(.back) }
                },
                content: {
                    KeyboardView(showModal: $viewModel.keyboardPresented, viewModel: viewModel)
                        .presentationDetents([.height(55)])
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(12)
                }
            )
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
                    .dismissCallback {
                        if viewModel.toastConfiguration == .prompted && viewModel.isConnected {
                            viewModel.toast(.promptAccepted)
                        }
                    }
            }
            .onChange(of: scenePhase) {
                switch scenePhase {
                case .active:
                    viewModel.connectAndRegister()
                case .background:
                    viewModel.disconnect()
                default:
                    break
                }
            }
        }
    }
}
