//
//  ContentView.swift
//  Mote Watch App
//
//  Created by Ярослав on 28.01.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MoteViewModel()
    @State private var message: String = ""
    var body: some View {
        VStack {
            ScrollView {
                Text("Received message: \(viewModel.message)")
                    .fixedSize(horizontal: false, vertical: true)
                Divider()
                TextField("Message to paired iPhone", text: $message)
                Button("Send", action: {
                    let data = ["message": message]
                    message = ""
                    viewModel.session.sendMessage(data, replyHandler: nil)
                })
            }
        }
        .padding()
    }
}
