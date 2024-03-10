//
//  MoteView.swift
//  Mote
//
//  Created by Ярослав on 04.03.2024.
//

import SwiftUI
import PopupView

struct MoteView: View {
    @StateObject var viewModel = MoteViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                MoteButtonGroup {
                    MoteButtonRow {
                        MoteButton(.powerOff)
                        MoteButton(.settings)
                        MoteButton(.search)
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
                        //MoteButton(.screenOff)
                        MoteButton(.left)
                        MoteButton(.ok)
                        MoteButton(.right)
                        //MoteButton(.mute)
                    }
                    MoteButtonRow {
                        MoteButton(.channelDown)
                        MoteButton(.down)
                        MoteButton(.volumeDown)
                    }
                    MoteButtonRow {
                        MoteButton(.home)
                        MoteButton(.playPause)
                        MoteButton(.back)
                    }
                }
                .environmentObject(viewModel)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(uiColor: .systemGray6))
            .navigationTitle("Mote App")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "keyboard.fill")
                        .font(.system(size: GlobalConstants.iconSize, weight: .bold, design: .rounded))
                        .foregroundColor(Color(uiColor: .systemGray))
                        .padding(.trailing, GlobalConstants.iconPadding)
                        .onTapGesture {
                            viewModel.isPopupPresented.toggle()
                        }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "ellipsis")
                        .font(.system(size: GlobalConstants.iconSize, weight: .bold, design: .rounded))
                        .foregroundColor(Color(uiColor: .systemGray))
                        .padding(.leading, GlobalConstants.iconPadding)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: GlobalConstants.iconSize, weight: .bold, design: .rounded))
                        .foregroundColor(Color(uiColor: .systemGray))
                        .padding(.trailing, GlobalConstants.iconPadding)
                        .onTapGesture {
                            viewModel.presentPreferencesView()
                        }
                }
            }
            .sheet(isPresented: $viewModel.preferencesPresented) {
                PreferencesView(viewModel: viewModel)
                    .presentationCornerRadius(24)
            }
        }
        .popup(isPresented: $viewModel.isPopupPresented) {
            PopupView()
        } customize: {
            $0
                .type(.toast)
                .position(.bottom)
                .animation(.bouncy(duration: 0.35))
                .backgroundColor(Color(uiColor: .systemBackground).opacity(0.50))
                .closeOnTapOutside(true)
        }
    }
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: GlobalConstants.smallTitleSize,
                                                           weight: .bold).rounded(),
            NSAttributedString.Key.foregroundColor: UIColor.systemGray
        ]
        
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: GlobalConstants.largetTitleSize,
                                                           weight: .bold).rounded(),
            NSAttributedString.Key.foregroundColor: UIColor.systemGray
        ]
    }
}

struct PopupView: View {
    var body: some View {
        VStack {
            Image(systemName: "tv.slash")
                .font(.system(size: 36, weight: .regular, design: .rounded))
                .foregroundColor(.accentColor)
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 25)
            Text("Please accept the registration prompt on the TV")
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(Color(uiColor: .label))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
        }
        .frame(maxWidth: .greatestFiniteMagnitude)
        .padding(.top, 45)
        .padding(.bottom, 50)
        .padding([.leading, .trailing], 50)
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(32)
        .shadow(radius: 64)
        .padding([.leading, .trailing], 10)
        .padding(.bottom, 35)
    }
}
