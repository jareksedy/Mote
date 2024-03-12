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
            if type.hapticTypeReleased != nil && viewModel.preferencesHapticFeedback {
                UIImpactFeedbackGenerator(style: type.hapticTypeReleased!).impactOccurred()
            }
            
            if type == .powerOff {
                Task { @MainActor in
                    viewModel.isConnected = false
                    viewModel.isPopupPresentedTVGoingOff = true
                }
            }
            
            if let keyTarget = type.keyTarget {
                viewModel.sendKey(keyTarget)
            }
            
            if let commonTarget = type.commonTarget {
                viewModel.send(commonTarget)
            }
        }, label: {})
            .buttonStyle(MoteButtonStyle(type))
            .buttonRepeatBehavior(type.repeatBehavior)
            .disabled(!viewModel.isConnected)
    }
    
    init(_ type: MoteButtonType) {
        self.type = type
    }
}

struct MoteButtonStyle: ButtonStyle {
    @EnvironmentObject var viewModel: MoteViewModel
    @State private var isPaused = false
    
    var type: MoteButtonType
    
    func makeBody(configuration: Configuration) -> some View {
        Circle()
            .frame(width: GlobalConstants.buttonSize, height: GlobalConstants.buttonSize)
            .foregroundColor(configuration.isPressed ? .accent : type.plain ? .darkerGrayMote : Color(uiColor: .systemGray6))
            .overlay {
                if let text = type.text {
                    Text(text)
                        .foregroundColor(getForegroundColor(type: type, pressed: configuration.isPressed))
                        .font(.system(size: GlobalConstants.buttonFontSize, weight: .bold, design: .rounded))
                        .monospacedDigit()
                } else {
                    Image(systemName: type.systemName)
                        .foregroundColor(getForegroundColor(type: type, pressed: configuration.isPressed))
                        .font(.system(size: GlobalConstants.buttonFontSize, weight: .bold, design: .rounded))
                }
            }
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .onChange(of: configuration.isPressed) {
                if configuration.isPressed && type.hapticTypePressed != nil && viewModel.preferencesHapticFeedback {
                    UIImpactFeedbackGenerator(style: type.hapticTypePressed!).impactOccurred()
                }
            }
    }
    
    init(_ type: MoteButtonType) {
        self.type = type
    }
}

private extension MoteButtonStyle {
    func getForegroundColor(type: MoteButtonType, pressed: Bool) -> Color {
        guard viewModel.isConnected else {
            return Color(uiColor: .systemGray5)
        }
        
        return pressed ? .white : type.highlighted ? .accent : Color(uiColor: .systemGray)
    }
}
