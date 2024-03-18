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
            .disabled(!viewModel.isConnected)
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
            .frame(width: GlobalConstants.buttonSize, height: GlobalConstants.buttonSize)
            .foregroundColor(getBackgroundColor(type: type, isColorChanged))
            .overlay {
                if let text = type.text {
                    Text(text)
                        .foregroundColor(getForegroundColor(type: type, isColorChanged))
                        .font(.system(size: GlobalConstants.buttonFontSize, weight: .bold, design: .rounded))
                        .monospacedDigit()
                } else {
                    Image(systemName: type.systemName)
                        .foregroundColor(getForegroundColor(type: type, isColorChanged))
                        .font(.system(size: GlobalConstants.buttonFontSize, weight: .bold, design: .rounded))
                }
            }
            .scaleEffect(getScale(type: type, isBeingPressed))
            ._onButtonGesture(pressing: { pressing in
                withAnimation(.bouncy(duration: pressing ? 0.25 : 0.35)) {
                    isBeingPressed = pressing
                }
                
                withAnimation(.smooth(duration: pressing ? 0.05 : 0.50)) {
                    isColorChanged = pressing
                }
                
                if isBeingPressed && type.hapticTypePressed != nil && viewModel.preferencesHapticFeedback {
                    UIImpactFeedbackGenerator(style: type.hapticTypePressed!).impactOccurred()
                }
                
                if isBeingPressed {
                    performAction(type: type, viewModel: viewModel)
                }
            }, perform: {
                if type.hapticTypeReleased != nil && viewModel.preferencesHapticFeedback {
                    UIImpactFeedbackGenerator(style: type.hapticTypeReleased!).impactOccurred()
                }
                
                if type == .keyboard {
                    viewModel.keyboardPresented = true
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
            return viewModel.isConnected ? .red : Color(uiColor: .systemGray6)
        case .green:
            return viewModel.isConnected ? .green : Color(uiColor: .systemGray6)
        case .yellow:
            return viewModel.isConnected ? .yellow : Color(uiColor: .systemGray6)
        case .blue:
            return viewModel.isConnected ? .blue : Color(uiColor: .systemGray6)
        default:
            break
        }
        
        if type == .grid && viewModel.colorButtonsPresented {
            return viewModel.isConnected ? .accent : Color(uiColor: .systemGray6)
        }
        
        return pressed ? .accent : type.plain ? .darkerGrayMote : Color(uiColor: .systemGray6)
    }
    
    func getForegroundColor(type: MoteButtonType, _ pressed: Bool) -> Color {
        guard viewModel.isConnected else {
            return Color(uiColor: .systemGray5)
        }
        
        if type == .grid && viewModel.colorButtonsPresented {
            return .white
        }
        
        if type == .red || type == .green || type == .yellow || type == .blue {
            return .white
        }
        
        return pressed ? .white : type.highlighted ? .accent : Color(uiColor: .systemGray)
    }
}

fileprivate func performAction(type: MoteButtonType, viewModel: MoteViewModel) {
    if type == .powerOff {
        Task { @MainActor in
            viewModel.isConnected = false
            viewModel.isPopupPresentedTVGoingOff = true
        }
    }
    
    if type == .grid {
        viewModel.colorButtonsPresented.toggle()
    }
    
    if let keyTarget = type.keyTarget {
        viewModel.sendKey(keyTarget)
    }
    
    if let commonTarget = type.commonTarget {
        viewModel.send(commonTarget)
    }
}
