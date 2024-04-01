//
//  Strings.swift
//  Mote
//
//  Created by Ярослав Седышев on 01.04.2024.
//

enum Strings {
    enum Titles {
        static let preferences = "Preferences"
        static let aboutMote = "About Mote"
        static let faq = "Frequently aksed questions"
        static let connectTV = "Connect TV"
        static let manuallyEnterIP = "Manually input IP address"
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
    }

    enum General {
        static let appName = "Mote App"
        static let save = "Save"
        static let reset = "Reset"
        static let cancel = "Cancel"
        static let yourTextHere = "Enter text here..."
    }
}
