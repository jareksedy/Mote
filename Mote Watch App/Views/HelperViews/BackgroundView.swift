//
//  BackgroundView..swift
//  Mote Watch App
//
//  Created by Ярослав on 31.01.2024.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(
        stops: [.init(color: .black, location: 0), .init(color: .darkerGrayMote, location: 0.25)],
        startPoint: .top,
        endPoint: .bottom
        )
    }
}
