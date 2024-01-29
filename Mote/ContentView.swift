//
//  ContentView.swift
//  Mote
//
//  Created by Ярослав on 28.01.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MoteViewModel()
    
    var body: some View {
        VStack {
            Image(uiImage: Bundle.main.icon ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .cornerRadius(12)
            
            Text("\(AppVersionProvider.appVersion())")
                .font(.system(size: 10, weight: .bold, design: .rounded))
        }
    }
}

extension Bundle {
    public var icon: UIImage? {
        if let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
            let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
            let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
            let lastIcon = iconFiles.last {
            return UIImage(named: lastIcon)
        }
        return nil
    }
}
