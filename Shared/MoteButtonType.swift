//
//  MoteButton.swift
//  Mote
//
//  Created by Ярослав on 30.01.2024.
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
    
    case home
    case back
    case playPause
    
    case fastForward
    case rewind
    case screenOff
    case powerOff
    case mute
    case settings
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
            return "circlebadge"
        case .volumeUp:
            return "speaker.plus"
        case .volumeDown:
            return "speaker.minus"
        case .channelUp:
            return "plus.rectangle"
        case .channelDown:
            return "minus.rectangle"
        case .home:
            return "house"
        case .back:
            return "arrow.uturn.backward"
        case .playPause:
            return "playpause"
        case .fastForward:
            return "forward"
        case .rewind:
            return "backward"
        case .screenOff:
            return "rectangle.slash"
        case .powerOff:
            return "power"
        case .mute:
            return "speaker.slash"
        case .settings:
            return "gearshape"
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
        case .channelUp:
            return .channelUp
        case .channelDown:
            return .channelDown
        case .home:
            return .home
        case .back:
            return .back
        case .playPause:
            return .play
        case .fastForward:
            return .fastForward
        case .rewind:
            return .rewind
        case .mute:
            return .mute
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
    var plain: Bool {
        switch self {
        case .up, .down, .left, .right, .ok, .playPause, .home, .back, .screenOff, .powerOff, .mute, .settings:
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
    var hapticType: WKHapticType? {
        return .click
    }
}
