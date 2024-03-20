//
//  GlobalConstants.swift
//  Mote
//
//  Created by Ярослав on 04.03.2024.
//

import SwiftUI

enum GlobalConstants {
    enum SubscriptionIds {
        static let remoteKeyboardRequestId = "remoteKeyboardSubscription"
        static let mediaPlaybackInfoRequestId = "mediaPlaybackInfoSubscription"
    }
    
    enum AnimationIntervals {
        static let buttonFadeInterval: TimeInterval = 0.75
    }
    
    static let smallTitleSize: CGFloat = 18
    static let largetTitleSize: CGFloat = 24
    
    static let iconSize: CGFloat = 12
    static let iconPadding: CGFloat = 15
    
    static var buttonSize: CGFloat {
        return 70
    }
    
    static var buttonSpacing: CGFloat {
        return 4
    }
    
    static var buttonFontSize: CGFloat {
        return 16
    }
    
    static var bottomPadding: CGFloat {
        return 30
    }
}
