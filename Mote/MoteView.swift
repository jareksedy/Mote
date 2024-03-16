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
                    
                    MoteButtonGroup {
                        MoteButtonRow {
                            MoteButton(.powerOff)
                            MoteButton(.grid)
                            MoteButton(.settings)
                        }
                        MoteButtonRow {
                            MoteButton(.num1)
                            MoteButton(.num2)
                            MoteButton(.num3)
                        }
                        MoteButtonRow {
                            MoteButton(.num4)
                            MoteButton(.num5)
                            MoteButton(.num6)
                        }
                        MoteButtonRow {
                            MoteButton(.num7)
                            MoteButton(.num8)
                            MoteButton(.num9)
                        }
                        MoteButtonRow {
                            MoteButton(.screenOff)
                            MoteButton(.num0)
                            MoteButton(.mute)
                        }
                        MoteButtonRow {
                            MoteButton(.channelUp)
                            MoteButton(.up)
                            MoteButton(.volumeUp)
                        }
                        MoteButtonRow {
                            MoteButton(.left)
                            MoteButton(.ok)
                            MoteButton(.right)
                        }
                        MoteButtonRow {
                            MoteButton(.channelDown)
                            MoteButton(.down)
                            MoteButton(.volumeDown)
                        }
                        MoteButtonRow {
                            MoteButton(.home)
                            MoteButton(.keyboard)
                            MoteButton(.back)
                        }
                    }
                    .environmentObject(viewModel)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.keyboard)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(uiColor: .systemGray6))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 7.5) {
                        Text("Mote")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.accentColor)
                        Image(systemName: "chevron.down.circle.fill")
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundColor(.accentColor)
                            .padding(.top, 1)
                    }
                    .padding(.leading, GlobalConstants.iconPadding)
                    .padding(.top, 18)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: GlobalConstants.iconSize, weight: .bold, design: .rounded))
                        .foregroundColor(Color(uiColor: .systemGray))
                        .padding(.trailing, GlobalConstants.iconPadding)
                        .padding(.top, 20)
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
        .sheet(isPresented: $viewModel.keyboardPresented) {
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
                .backgroundColor(Color(uiColor: .systemBackground).opacity(0.50))
        }
        .popup(isPresented: $viewModel.isPopupPresentedTVGoingOff) {
            PopupView(type: .tvGoingOff)
        } customize: { popup in
            popup
                .type(.toast)
                .position(.bottom)
                .animation(.bouncy(duration: 0.45))
                .backgroundColor(Color(uiColor: .systemBackground).opacity(0.50))
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
                .backgroundColor(Color(uiColor: .systemBackground).opacity(0.50))
                .autohideIn(4)
        }
        .popup(isPresented: $viewModel.isPopupPresentedConnected) {
            PopupView(type: .connected)
        } customize: { popup in
            popup
                .type(.toast)
                .position(.bottom)
                .animation(.bouncy(duration: 0.45))
                .backgroundColor(Color(uiColor: .systemBackground).opacity(0.50))
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

struct PopupView: View {
    var type: PopupType
    var body: some View {
        VStack {
            Image(systemName: type.systemName)
                .font(.system(size: 36, weight: .regular, design: .rounded))
                .foregroundColor(type.iconColor)
                .multilineTextAlignment(.center)
                .padding(.top, 35)
            Text(type.message)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(Color(uiColor: .label))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.top, 25)
                .padding(.bottom, 35)
        }
        .frame(maxWidth: .greatestFiniteMagnitude)
        .padding([.leading, .trailing], 25)
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(32)
        .shadow(radius: 64)
        .padding([.leading, .trailing], 10)
        .padding(.bottom, 35)
    }
}
