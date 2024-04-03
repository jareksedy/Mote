//
//  MoteButton.swift
//  Mote
//
//  Created by Ярослав on 09.03.2024.
//

import SwiftUI

struct MoteButton: View {
    @EnvironmentObject var viewModel: MoteViewModel
    var type: MoteButtonType
    var body: some View {
        Button(action: {
            if type.repeatBehavior == .enabled {
                performAction(type: type, viewModel: viewModel)
            }
        }, label: {})
            .buttonStyle(MoteButtonStyle(type))
            .buttonRepeatBehavior(type.repeatBehavior)
    }

    init(_ type: MoteButtonType) {
        self.type = type
    }
}

struct MoteButtonStyle: ButtonStyle {
    @EnvironmentObject var viewModel: MoteViewModel
    @State private var isBeingPressed: Bool = false
    @State private var isColorChanged: Bool = false
    var type: MoteButtonType

    func makeBody(configuration: Configuration) -> some View {
        Circle()
            .frame(width: Globals.buttonSize, height: Globals.buttonSize)
            .foregroundColor(getBackgroundColor(type: type, isColorChanged))
            .overlay {
                if let text = type.text {
                    Text(text)
                        .foregroundColor(getForegroundColor(type: type, isColorChanged))
                        .font(.system(size: Globals.buttonFontSize, weight: .bold, design: .rounded))
                        .monospacedDigit()
                } else {
                    Image(systemName: type.systemName)
                        .foregroundColor(getForegroundColor(type: type, isColorChanged))
                        .font(.system(size: Globals.buttonFontSize, weight: .bold, design: .rounded))
                }
            }
            .scaleEffect(getScale(type: type, isBeingPressed))
            ._onButtonGesture(pressing: { pressing in
                withAnimation(.bouncy(duration: pressing ? 0.25 : 0.35)) {
                    isBeingPressed = pressing
                }

                withAnimation(.smooth(duration: pressing ? 0 : 0.75)) {
                    isColorChanged = pressing
                }

                if isBeingPressed && type.hapticTypePressed != nil && viewModel.preferencesHapticFeedback {
                    UIImpactFeedbackGenerator(style: type.hapticTypePressed!).impactOccurred()
                }

                if isBeingPressed {
                    performAction(type: type, viewModel: viewModel)
                }
            }, perform: {
                if !viewModel.isConnected {
                    viewModel.connectAndRegister()
                }

                if type.hapticTypeReleased != nil && viewModel.preferencesHapticFeedback {
                    UIImpactFeedbackGenerator(style: type.hapticTypeReleased!).impactOccurred()
                }

                if type == .keyboard {
                    viewModel.keyboardPresented = true
                }

                if type == .powerOff {
                    if viewModel.isConnected {
                        viewModel.send(.turnOff)
                        Task { @MainActor in
                            viewModel.isConnected = false
                            viewModel.toast(.goingOff)
                        }
                    } else {
                        viewModel.connectAndRegister()
                    }
                }
            })
    }

    init(_ type: MoteButtonType) {
        self.type = type
    }
}

private extension MoteButtonStyle {
    func getScale(type: MoteButtonType, _ pressed: Bool) -> CGFloat {
        if type == .grid {
            return 1
        }

        return pressed ? 0.9 : 1.0
    }

    func getBackgroundColor(type: MoteButtonType, _ pressed: Bool) -> Color {
        switch type {
        case .red:
            return .red
        case .green:
            return .green
        case .yellow:
            return .yellow
        case .blue:
            return .blue
        default:
            break
        }

        if type == .grid && viewModel.colorButtonsPresented {
            return .accent
        }

        return pressed ? .accent : type.plain ? .darkerGrayMote : Color(uiColor: .systemGray6)
    }

    func getForegroundColor(type: MoteButtonType, _ pressed: Bool) -> Color {
        guard type != .powerOff else {
            return pressed ? .white : type.highlighted ? .accent : .secondary
        }

        if type == .grid && viewModel.colorButtonsPresented {
            return .white
        }

        if type == .red || type == .green || type == .yellow || type == .blue {
            return .white
        }

        return pressed ? .white : type.highlighted ? .accent : .secondary
    }
}

private func performAction(type: MoteButtonType, viewModel: MoteViewModel) {
    if type == .playPause {
        guard let playState = viewModel.playState else {
            return
        }
        switch playState {
        case "playing":
            viewModel.sendKey(.pause)
        case "paused":
            viewModel.sendKey(.play)
        default:
            break
        }

        return
    }

    if type == .grid {
        viewModel.colorButtonsPresented.toggle()
    }

    if type == .powerOff {
        return
    }

    if let keyTarget = type.keyTarget {
        viewModel.sendKey(keyTarget)
    }

    if let commonTarget = type.commonTarget {
        viewModel.send(commonTarget)
    }
}
