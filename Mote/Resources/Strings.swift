//
//  Strings.swift
//  Mote
//
//  Created by Ярослав Седышев on 01.04.2024.
//

// swiftlint:disable line_length

enum Strings {
    enum Titles {
        static let preferences = "Preferences"
        static let aboutMote = "About Mote"
        static let faq = "Frequently Asked Questions"
        static let connectTV = "Connect TV"
        static let manuallyEnterIP = "Input IP address manually"
        static let resetConnectionData = "Reset connection data"

        static let alternativeLayout = "Alternative layout"
        static let hapticFeedback = "Haptic feedback"
    }

    enum SectionHeaders {
        static let app = "App"
        static let connection = "Connection"
        static let layoutAndHaptics = "Layout and haptics"
    }

    enum About {
        static let appInfo = "LG Smart TV Remote Control App"
        static let authorInfo = "by Yaroslav Sedyshev"
        static let madeWith = "Made with"
        static let madeIn = "in Kazakhstan"
    }

    enum ConnectTV {
        static let importantNote = "TV must be on and connected to the same network"
    }

    enum InputIP {
        static let inputIPMessage = "IP address of your TV"
        static let inputIPPrompt = "IP address"
    }

    enum ResetConnectionData {
        static let title = "Do you want to reset connection data?"
        static let message = "You will need to reconnect and re-register with the TV."
    }

    enum ToastMessages {
        static let prompted = "Please accept the registration prompt on the TV"
        static let connectedAndRegistered = "Successfully connected and registered with the TV"
        static let disconnected = "Disconnected, tap any button to reconnect"
        static let tvGoingOff = "The TV is going off, tap power button to turn it on again"
    }

    enum FAQ {
        static let q1 = "How do I customize the buttons and layout?"
        static let a1 = "Safely unwraps the URL and WebOSClient instance and avoids force unwrapping. Additionally, it provides error handling for potential failures during initialization. Make sure to adjust the error handling based on your application's needs."
    }

    enum General {
        static let appName = "Mote App"
        static let save = "Save"
        static let reset = "Reset"
        static let cancel = "Cancel"
        static let yourTextHere = "Enter text here..."
    }
}

// swiftlint:enable line_length
