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
    case channelUpAlt
    case channelDownAlt
    
    case home
    case homeAlt
    case back
    case backAlt
    case playPause
    case play
    case pause
    
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
            return "app"
        case .volumeUp:
            return "speaker.plus"
        case .volumeDown:
            return "speaker.minus"
        case .channelUp, .channelUpAlt:
            return "plus.rectangle"
        case .channelDown, .channelDownAlt:
            return "minus.rectangle"
        case .home, .homeAlt:
            return "house"
        case .back, .backAlt:
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
        case .channelUp, .channelUpAlt:
            return .channelUp
        case .channelDown, .channelDownAlt:
            return .channelDown
        case .home, .homeAlt:
            return .home
        case .back, .backAlt:
            return .back
        case .playPause:
            return .play
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
        case
                .up,
                .down,
                .left,
                .right,
                .ok,
                .playPause,
                .play,
                .pause,
                .channelUpAlt,
                .channelDownAlt,
                .home,
                .back,
                .screenOff,
                .powerOff,
                .mute,
                .settings:
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
