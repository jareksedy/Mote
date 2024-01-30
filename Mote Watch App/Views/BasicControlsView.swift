//
//  BasicControlsView.swift
//  Mote Watch App
//
//  Created by Ярослав on 28.01.2024.
//

import SwiftUI
import WebOSClient

fileprivate enum Constants {
    static let size: CGFloat = 55
    static let spacing: CGFloat = 4
    static let fontSize: CGFloat = 20
}

struct BasicControlsView: View {
    @StateObject private var viewModel = MoteViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: -60) {
                ButtonRow {
                    ButtonView(systemName: "speaker.plus", action: { viewModel.send(.volumeUp) })
                    ButtonView(systemName: "chevron.compact.up", action: { viewModel.sendKey(.up) }, plain: true, highlighted: true)
                    ButtonView(systemName: "speaker.minus", action: { viewModel.send(.volumeDown) })
                }
                
                ButtonRow {
                    ButtonView(systemName: "chevron.compact.left", action: { viewModel.sendKey(.left) }, plain: true, highlighted: true)
                    ButtonView(systemName: "circle", action: { viewModel.sendKey(.enter) }, plain: true, highlighted: true)
                    ButtonView(systemName: "chevron.compact.right", action: { viewModel.sendKey(.right) }, plain: true, highlighted: true)
                }
                
                ButtonRow {
                    ButtonView(systemName: "house", action: { viewModel.sendKey(.home) })
                    ButtonView(systemName: "chevron.compact.down", action: { viewModel.sendKey(.down) }, plain: true, highlighted: true)
                    ButtonView(systemName: "arrow.uturn.backward", action: { viewModel.sendKey(.back) })
                }
                    
                Spacer().padding(.bottom, 35)
            }
            .navigationTitle("Basic")
        }
    }
}

struct ButtonRow<Content: View>: View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        HStack(spacing: Constants.spacing) {
            content()
        }
        .padding(Constants.spacing)
        .background(Color.moteDarkerGray)
        .cornerRadius(.greatestFiniteMagnitude)
        .frame(height: ((Constants.size * 2) + (Constants.spacing * 2)) + 2)
    }
}

struct ButtonView: View {
    @State private var tapped: Bool = false
    var systemName: String
    var action: (() -> Void)?
    var plain: Bool = false
    var highlighted: Bool = false
    var body: some View {
        Circle()
            .frame(width: Constants.size, height: Constants.size)
            .foregroundColor(tapped ? .accent : plain ? .moteDarkerGray : .moteDarkGray) //~black
            .overlay {
                Image(systemName: systemName)
                    .foregroundColor(tapped ? .white : highlighted ? .accent : .white)
                    .font(.system(size: Constants.fontSize, weight: .bold, design: .rounded))
            }
            ._onButtonGesture(pressing: { pressing in
                tapped = pressing
            }, perform: {
                WKInterfaceDevice.current().play(.click)
                action?()
            })
    }
}

extension Color {
    static var moteDarkGray: Color { Color("DarkGrayMote") }
    static var moteDarkerGray: Color { Color("DarkerGrayMote") }
}
