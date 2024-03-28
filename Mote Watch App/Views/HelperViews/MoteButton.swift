//
//  MoteButton.swift
//  Mote Watch App
//
//  Created by Ярослав on 31.01.2024.
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
            .disabled(getDisabled(type))
    }
    
    init(_ type: MoteButtonType) {
        self.type = type
    }
}

private extension MoteButton {
    func getDisabled(_ type: MoteButtonType) -> Bool {
        return false
    }
}

struct MoteButtonStyle: ButtonStyle {
    @EnvironmentObject var viewModel: MoteViewModel
    @State private var isBeingPressed: Bool = false
    @State private var isColorChanged: Bool = false
    var type: MoteButtonType
    
    func makeBody(configuration: Configuration) -> some View {
        Circle()
            .frame(width: GlobalConstants.buttonSize, height: GlobalConstants.buttonSize)
            .foregroundColor(getBackgroundColor(type: type, isColorChanged))
            .overlay {
                Image(systemName: type.systemName)
                    .foregroundColor(getForegroundColor(type: type, isColorChanged))
                    .font(.system(size: GlobalConstants.buttonFontSize, weight: .bold, design: .rounded))
            }
            .scaleEffect(getScale(type: type, isBeingPressed))
            ._onButtonGesture(pressing: { pressing in
                withAnimation(.bouncy(duration: pressing ? 0.25 : 0.35)) {
                    isBeingPressed = pressing
                }
                
                withAnimation(.smooth(duration: pressing ? 0.05 : 0.75)) {
                    isColorChanged = pressing
                }
                
                if isBeingPressed && type.hapticTypePressed != nil && viewModel.preferencesHapticFeedback {
                    WKInterfaceDevice.current().play(type.hapticTypePressed!)
                }
                
                if isBeingPressed {
                    performAction(type: type, viewModel: viewModel)
                }
            }, perform: {
                if type.hapticTypeReleased != nil && viewModel.preferencesHapticFeedback {
                    WKInterfaceDevice.current().play(type.hapticTypeReleased!)
                }
                
                if type == .powerOff {
                    if viewModel.isConnected {
                        viewModel.send(.turnOff)
                        Task { @MainActor in
                            viewModel.isConnected = false
                        }
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
        return pressed ? 0.9 : 1.0
    }
    
    func getBackgroundColor(type: MoteButtonType, _ pressed: Bool) -> Color {
        return pressed ? .accent : type.plain ? .black : .darkGrayMote
    }
    
    func getForegroundColor(type: MoteButtonType, _ pressed: Bool) -> Color {
        guard type != .powerOff else {
            return pressed ? .white : type.highlighted ? .accent : Color(uiColor: .gray)
        }
        
        return pressed ? .white : type.highlighted ? .accent : Color(uiColor: .gray)
    }
}

fileprivate func performAction(type: MoteButtonType, viewModel: MoteViewModel) {
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
