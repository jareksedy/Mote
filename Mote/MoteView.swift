//
//  MoteView.swift
//  Mote
//
//  Created by Ярослав on 04.03.2024.
//

import SwiftUI

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
                        MoteButton(.rewind)
                        MoteButton(.num0)
                        MoteButton(.fastForward)
                    }
                    MoteButtonRow {
                        MoteButton(.channelUp)
                        MoteButton(.up)
                        MoteButton(.volumeUp)
                    }
                    MoteButtonRow {
                        MoteButton(.screenOff)
                        MoteButton(.left)
                        MoteButton(.ok)
                        MoteButton(.right)
                        MoteButton(.mute)
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
            .background(Color(uiColor: .systemGray6).ignoresSafeArea())
            .ignoresSafeArea(.all)
            .navigationTitle("MOTE APP")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
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
