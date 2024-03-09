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
                if type == .right && viewModel.tvVolumeChanged {
                    Text("\(viewModel.tvVolumeLevel)")
                        .foregroundColor(Color(uiColor: .systemGray))
                        .font(.system(size: GlobalConstants.buttonFontSize, weight: .bold, design: .rounded))
                        .monospacedDigit()
                } else {
                    if let text = type.text {
                        Text(text)
                            .foregroundColor(tapped ? .white : type.highlighted ? .accent : Color(uiColor: .systemGray))
                            .font(.system(size: GlobalConstants.buttonFontSize, weight: .bold, design: .rounded))
                            .monospacedDigit()
                    } else {
                        Image(systemName: type.systemName)
                            .foregroundColor(tapped ? .white : type.highlighted ? .accent : Color(uiColor: .systemGray))
                            .font(.system(size: GlobalConstants.buttonFontSize, weight: .bold, design: .rounded))
                    }
                }
            }
            .scaleEffect(tapped ? 0.85 : 1.0)
            ._onButtonGesture(pressing: { pressing in
                withAnimation(.smooth(duration: 0.25)) {
                    tapped = pressing
                }
                if tapped && type.hapticTypePressed != nil && viewModel.preferencesHapticFeedback {
                    UIImpactFeedbackGenerator(style: type.hapticTypePressed!).impactOccurred()
                }
                
            }, perform: {
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
