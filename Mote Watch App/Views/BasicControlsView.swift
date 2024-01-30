//
//  BasicControlsView.swift
//  Mote Watch App
//
//  Created by Ярослав on 28.01.2024.
//

import SwiftUI
import WebOSClient

enum Constants {
    static let size: CGFloat = 55
    static let spacing: CGFloat = 4
    static let fontSize: CGFloat = 20
}

struct BasicControlsView: View {
    var body: some View {
        NavigationStack {
            ButtonGroup {
                ButtonRow {
                    ButtonView(.channelUp)
                    ButtonView(.up)
                    ButtonView(.volumeUp)
                }
                ButtonRow {
                    ButtonView(.left)
                    ButtonView(.ok)
                    ButtonView(.right)
                }
                ButtonRow {
                    ButtonView(.channelDown)
                    ButtonView(.down)
                    ButtonView(.volumeDown)
                }
            }
            .navigationTitle("Basic")
        }
        .background(
            LinearGradient(
            stops: [.init(color: .black, location: 0), .init(color: .moteDarkerGray, location: 0.25)],
            startPoint: .top, endPoint: .bottom
            )
        )
    }
}

struct ButtonGroup<Content: View>: View {
    let content: () -> Content
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    var body: some View {
        VStack(spacing: -60) {
            content()
            Spacer().padding(.bottom, 35)
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
        .background(.black)
        .cornerRadius(.greatestFiniteMagnitude)
        .frame(height: ((Constants.size * 2) + (Constants.spacing * 2)) + 2)
    }
}

struct ButtonView: View {
    @EnvironmentObject var viewModel: MoteViewModel
    @State private var tapped: Bool = false
    var type: MoteButton
    var body: some View {
        Circle()
            .frame(width: Constants.size, height: Constants.size)
            .foregroundColor(tapped ? .accent : type.plain ? .black : .moteDarkerGray)
            .overlay {
                Image(systemName: type.systemName)
                    .foregroundColor(tapped ? .white : type.highlighted ? .accent : .gray)
                    .font(.system(size: Constants.fontSize, weight: .bold, design: .rounded))
            }
            ._onButtonGesture(pressing: { pressing in
                tapped = pressing
            }, perform: {
                if let hapticType = type.hapticType {
                    WKInterfaceDevice.current().play(hapticType)
                }
                if let keyTarget = type.keyTarget {
                    viewModel.sendKey(keyTarget)
                }
                if let commonTarget = type.commonTarget {
                    viewModel.send(commonTarget)
                }
            })
    }
    init(_ type: MoteButton) {
        self.type = type
    }
}

extension Color {
    static var moteDarkGray: Color { Color("DarkGrayMote") }
    static var moteDarkerGray: Color { Color("DarkerGrayMote") }
}
