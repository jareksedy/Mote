//
//  MoteButton.swift
//  Mote
//
//  Created by Ярослав on 09.03.2024.
//

import SwiftUI

struct MoteButton: View {
    @EnvironmentObject var viewModel: MoteViewModel
    @State private var tapped: Bool = false
    
    var type: MoteButtonType
    
    var body: some View {
        Circle()
            .frame(width: GlobalConstants.buttonSize, height: GlobalConstants.buttonSize)
            .foregroundColor(tapped ? .accent : type.plain ? .darkerGrayMote : Color(uiColor: .systemGray6))
            .overlay {
                if let text = type.text {
                    Text(text)
                        .foregroundColor(getForegroundColor(type: type, tapped: tapped))
                        .font(.system(size: GlobalConstants.buttonFontSize, weight: .bold, design: .rounded))
                        .monospacedDigit()
                } else {
                    Image(systemName: type.systemName)
                        .foregroundColor(getForegroundColor(type: type, tapped: tapped))
                        .font(.system(size: GlobalConstants.buttonFontSize, weight: .bold, design: .rounded))
                }
            }
            .scaleEffect(tapped ? 0.95 : 1.0)
            ._onButtonGesture(pressing: { pressing in
                guard viewModel.isConnected || type == .powerOff else {
                    return
                }
                
                withAnimation(.easeInOut(duration: 0.25)) {
                    tapped = pressing
                }
                
                if tapped && type.hapticTypePressed != nil && viewModel.preferencesHapticFeedback {
                    UIImpactFeedbackGenerator(style: type.hapticTypePressed!).impactOccurred()
                }
                
            }, perform: {
                guard viewModel.isConnected || type == .powerOff else {
                    return
                }
                
                if type.hapticTypeReleased != nil && viewModel.preferencesHapticFeedback {
                    UIImpactFeedbackGenerator(style: type.hapticTypeReleased!).impactOccurred()
                }
                
                if let keyTarget = type.keyTarget {
                    viewModel.sendKey(keyTarget)
                }
                
                if let commonTarget = type.commonTarget {
                    viewModel.send(commonTarget)
                }
            })

    }
    
    init(_ type: MoteButtonType) {
        self.type = type
    }
}

private extension MoteButton {
    func getForegroundColor(type: MoteButtonType, tapped: Bool) -> Color {
        guard viewModel.isConnected else {
            if type == .powerOff && tapped {
                return .white
            } else if type == .powerOff && !tapped {
                return .accentColor
            }
            return Color(uiColor: .systemGray5)
        }
        
        return tapped ? .white : type.highlighted ? .accent : Color(uiColor: .systemGray)
    }
}
