//
//  MoteView.swift
//  Mote
//
//  Created by Ярослав on 04.03.2024.
//

import SwiftUI
import VolumeButtonHandler

struct MoteView: View {
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var viewModel: MoteViewModel
    @State private var volumeHandler = VolumeButtonHandler()

    var body: some View {
        NavigationStack {
            ScrollView([], showsIndicators: false) {
                VStack {
                    Spacer().frame(height: 25)

                    if viewModel.preferencesAlternativeView {
                        if viewModel.colorButtonsPresented {
                            MoteButtonGroupColorAlternativeView()
                                .environmentObject(viewModel)
                        } else {
                            MoteButtonGroupDefaultAlternativeView()
                                .environmentObject(viewModel)
                        }
                    } else {
                        if viewModel.colorButtonsPresented {
                            MoteButtonGroupColorView()
                                .environmentObject(viewModel)
                        } else {
                            MoteButtonGroupDefaultView()
                                .environmentObject(viewModel)
                        }
                    }

                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .ignoresSafeArea(.keyboard)
            .background(Color(uiColor: .systemGray6))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 5) {
                        Text("Mote")
                            .font(.system(size: Globals.smallTitleSize, weight: .bold, design: .rounded))
                            .foregroundColor(.accent)
                        
                        Image(
                            systemName: viewModel.isConnected ?
                            "checkmark.circle.fill" : "exclamationmark.circle"
                        )
                        .font(.system(size: Globals.iconSize, weight: .bold, design: .rounded))
                        .foregroundColor(.accent)
                        .contentTransition(.symbolEffect(.replace.byLayer))
                    }
                    .padding(.leading, Globals.iconPadding)
                    .padding(.top, 10)
                    .onTapGesture {
                        viewModel.showConnectionStatus()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "keyboard.fill")
                        .font(.system(size: Globals.iconSize, weight: .bold, design: .rounded))
                        .foregroundColor(.secondary)
                        .padding(.trailing, Globals.iconPadding)
                        .padding(.top, 10)
                        .onTapGesture {
                            viewModel.keyboardPresented = true
                        }
                }
//                ToolbarItem(placement: .topBarTrailing) {
//                    Image(
//                        systemName: viewModel.isConnected ?
//                        "checkmark.circle.fill" : "exclamationmark.triangle.fill"
//                    )
//                    .font(.system(size: Globals.iconSize, weight: .bold, design: .rounded))
//                    .foregroundColor(.secondary)
//                    .padding(.trailing, Globals.iconPadding)
//                    .padding(.top, 10)
//                    .contentTransition(.symbolEffect(.replace.byLayer))
//                    .onTapGesture {
//                        viewModel.showConnectionStatus()
//                    }
//                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: Globals.iconSize, weight: .bold, design: .rounded))
                        .foregroundColor(.secondary)
                        .padding(.trailing, Globals.iconPadding)
                        .padding(.top, 10)
                        .onTapGesture {
                            viewModel.preferencesPresented = true
                            
                            if viewModel.preferencesHapticFeedback {
                                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                            }
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
            .sheet(
                isPresented: $viewModel.isToastPresented,
                onDismiss: {
                    if viewModel.toastConfiguration == .prompted && viewModel.isConnected {
                        viewModel.toast(.promptAccepted)
                    }
                },
                content: {
                    ToastSheetView(configuration: viewModel.toastConfiguration!, viewModel: viewModel)
                        .presentationDetents([.height(175)])
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(24)
                        .onTapGesture {
                            guard viewModel.toastConfiguration?.closeOnTap == true else {
                                return
                            }
                            viewModel.isToastPresented = false
                        }
                }
            )
            .onChange(of: scenePhase) {
                viewModel.handleScenePhase(scenePhase)
            }
            .onAppear {
                if AppSettings.shared.host == nil {
                    viewModel.preferencesPresented = true
                }

                volumeHandler.startHandler(disableSystemVolumeHandler: false)

                volumeHandler.upBlock = {
                    let volumeLevel = Int(volumeHandler.currentVolume * 100)
                    viewModel.tv?.send(.setVolume(volumeLevel))
                }
                volumeHandler.downBlock = {
                    let volumeLevel = Int(volumeHandler.currentVolume * 100)
                    viewModel.tv?.send(.setVolume(volumeLevel))
                }
            }
            .onDisappear {
                volumeHandler.stopHandler()
            }
        }
    }
}
