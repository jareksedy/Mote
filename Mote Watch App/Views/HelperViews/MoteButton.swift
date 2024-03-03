//
//  MoteButton.swift
//  Mote Watch App
//
//  Created by Ярослав on 31.01.2024.
//

import SwiftUI

struct MoteButton: View {
    @EnvironmentObject var viewModel: MoteViewModel
    @State private var tapped: Bool = false
    
    var type: MoteButtonType
    
    var body: some View {
        Circle()
            .frame(width: GlobalConstants.buttonSize, height: GlobalConstants.buttonSize)
            .foregroundColor(tapped ? .accent : type.plain ? .black : .darkGrayMote)
            .overlay {
                Image(systemName: type.systemName)
                    .foregroundColor(tapped ? .white : type.highlighted ? .accent : .gray)
                    .font(.system(size: GlobalConstants.buttonFontSize, weight: .bold, design: .rounded))
            }
            ._onButtonGesture(pressing: { pressing in
                tapped = pressing
            }, perform: {
                if type.hapticType != nil && viewModel.preferencesHapticFeedback {
                    WKInterfaceDevice.current().play(type.hapticType!)
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
