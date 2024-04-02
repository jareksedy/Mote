//
//  KeyboardView.swift
//  Mote
//
//  Created by Ярослав on 11.03.2024.
//

import SwiftUI
import UIKit
import WebOSClient

struct KeyboardView: View {
    private var viewModel: MoteViewModel
    @FocusState private var focused: Bool
    @State private var inputString = ""
    @Binding var showModal: Bool

    var body: some View {
        ScrollView([], showsIndicators: false) {
            TextField(Strings.General.yourTextHere, text: $inputString)
                .focused($focused)
                .disableAutocorrection(true)
                .onSubmit {
                    guard inputString != "" else { return }
                    viewModel.send(.sendEnterKey)
                }
                .onAppear {
                    focused = true
                    inputString = ""
                    if viewModel.preferencesHapticFeedback {
                        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                    }
                }
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .onChange(of: focused) {
                    showModal = focused
                }
                .onChange(of: inputString) {
                    viewModel.send(.insertText(text: inputString, replace: true))
                }
                .padding([.leading, .trailing])
                .padding(.top, 30)
        }
        .ignoresSafeArea(.keyboard)
        .background(Color(uiColor: .systemGray6))
    }

    init(showModal: Binding<Bool>, viewModel: MoteViewModel) {
        UITextField.appearance().clearButtonMode = .whileEditing
        self._showModal = showModal
        self.viewModel = viewModel
    }
}
