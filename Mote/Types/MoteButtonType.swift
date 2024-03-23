//
//  MoteButtonType.swift
//  Mote
//
//  Created by Ярослав on 09.03.2024.
//

import SwiftUI
import WebOSClient

enum MoteButtonType {
    case up
    case down
    case left
    case right
    
    case ok
    
    case volumeUp
    case volumeDown
    case channelUp
    case channelDown
    case channelUpAlternative
    case channelDownAlternative
    
    case home
    case homeAlternative
    case back
    case backAlternative
    case playPause
    case play
    case pause
    
    case fastForward
    case rewind
    case screenOff
    case powerOff
    case mute
    case settings
    case search
    case exit
    
    case num0
    case num1
    case num2
    case num3
    case num4
    case num5
    case num6
    case num7
    case num8
    case num9
    
    case keyboard
    case grid
    
    case red
    case green
    case yellow
    case blue
    
    case none
}

extension MoteButtonType {
    var systemName: String {
        switch self {
        case .up:
            return "chevron.compact.up"
        case .down:
            return "chevron.compact.down"
        case .left:
            return "chevron.compact.left"
        case .right:
            return "chevron.compact.right"
        case .ok:
            return "app"
        case .volumeUp:
            return "speaker.plus"
        case .volumeDown:
            return "speaker.minus"
        case .channelUp, .channelUpAlternative:
            return "plus.rectangle"
        case .channelDown, .channelDownAlternative:
            return "minus.rectangle"
        case .home, .homeAlternative:
            return "house"
        case .back, .backAlternative:
            return "arrow.uturn.backward"
        case .playPause:
            return "playpause"
        case .play:
            return "play"
        case .pause:
            return "pause"
        case .fastForward:
            return "forward"
        case .rewind:
            return "backward"
        case .screenOff:
            return "eye.slash"
        case .powerOff:
            return "power"
        case .mute:
            return "speaker.slash"
        case .settings:
            return "gearshape"
        case .search:
            return "magnifyingglass"
        case .keyboard:
            return "keyboard"
        case .exit:
            return "xmark.app"
        case .grid:
            return "circle.grid.2x2"
        case .red, .green, .yellow, .blue:
            return "circlebadge"
        default:
            return ""
        }
    }
    
    var keyTarget: WebOSKeyTarget? {
        switch self {
        case .up:
            return .up
        case .down:
            return .down
        case .left:
            return .left
        case .right:
            return .right
        case .ok:
            return .enter
        case .volumeUp:
            return .volumeUp
        case .volumeDown:
            return .volumeDown
        case .channelUp, .channelUpAlternative:
            return .channelUp
        case .channelDown, .channelDownAlternative:
            return .channelDown
        case .home, .homeAlternative:
            return .home
        case .back, .backAlternative:
            return .back
        case .playPause:
            return .enter
        case .play:
            return .play
        case .pause:
            return .pause
        case .fastForward:
            return .fastForward
        case .rewind:
            return .rewind
        case .mute:
            return .mute
        case .settings:
            return .menu
        case .exit:
            return .exit
        case .num0:
            return .num0
        case .num1:
            return .num1
        case .num2:
            return .num2
        case .num3:
            return .num3
        case .num4:
            return .num4
        case .num5:
            return .num5
        case .num6:
            return .num6
        case .num7:
            return .num7
        case .num8:
            return .num8
        case .num9:
            return .num9
        case .red:
            return .red
        case .green:
            return .green
        case .yellow:
            return .yellow
        case .blue:
            return .blue
        default:
            return nil
        }
    }
    
    var commonTarget: WebOSTarget? {
        switch self {
        case .screenOff:
            return .screenOff
        case .powerOff:
            return .turnOff
        default:
            return nil
        }
    }
    
    var text: String? {
        switch self {
        case .num0:
            return "0"
        case .num1:
            return "1"
        case .num2:
            return "2"
        case .num3:
            return "3"
        case .num4:
            return "4"
        case .num5:
            return "5"
        case .num6:
            return "6"
        case .num7:
            return "7"
        case .num8:
            return "8"
        case .num9:
            return "9"
        default:
            return nil
        }
    }
    
    var plain: Bool {
        switch self {
        case
                .up,
                .down,
                .left,
                .right,
                .ok,
                .channelUpAlternative,
                .channelDownAlternative,
                .home,
                .playPause,
                .back,
                .powerOff,
                .rewind,
                .fastForward,
                .settings,
                .play,
                .pause,
                .search,
                .exit,
                .none,
                .grid,
                .keyboard:
            return true
        default:
            return false
        }
    }
    
    var highlighted: Bool {
        switch self {
        case .up, .down, .left, .right, .ok, .powerOff:
            return true
        default:
            return false
        }
    }
    
    var hapticTypePressed: UIImpactFeedbackGenerator.FeedbackStyle? {
        switch self {
        case .grid:
            return .rigid
        default:
            return .soft
        }
    }
    
    var hapticTypeReleased: UIImpactFeedbackGenerator.FeedbackStyle? {
        switch self {
        case .powerOff, .home, .ok, .keyboard:
            return .soft
        default:
            return nil
        }
    }
    
    var repeatBehavior: ButtonRepeatBehavior {
        switch self {
        case .up, .down, .left, .right, .volumeUp, .volumeDown, .channelUp, .channelDown:
            return .enabled
        default:
            return .disabled
        }
    }
}
