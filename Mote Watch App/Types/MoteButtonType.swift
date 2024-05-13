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
            return "square.slash"
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
                .channelUpAlternative,
                .channelDownAlternative,
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

    var hapticTypePressed: WKHapticType? {
        return .click
    }

    var hapticTypeReleased: WKHapticType? {
        switch self {
        case .powerOff, .home, .ok:
            return .click
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
