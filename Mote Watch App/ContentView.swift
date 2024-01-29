//
//  ContentView.swift
//  Mote Watch App
//
//  Created by Ярослав on 28.01.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MoteViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}
