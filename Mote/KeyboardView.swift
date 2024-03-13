//
//  KeyboardView.swift
//  Mote
//
//  Created by Ярослав on 11.03.2024.
//

import SwiftUI
import UIKit

struct KeyboardView: View {
    private var viewModel: MoteViewModel
    @FocusState private var focused: Bool
    @State private var inputString = ""
    @Binding var showModal: Bool
    
    var body: some View {
        ScrollView([], showsIndicators: false) {
            TextField("Your text here...", text: $inputString)
                .focused($focused)
                .disableAutocorrection(true)
                .onSubmit {
                    guard inputString != "" else { return }
                    viewModel.send(.sendEnterKey)
                }
                .onAppear {
                    focused = true
                }
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .onChange(of: focused) {
                    showModal = focused
                }
                .onChange(of: inputString) {
                    viewModel.send(.deleteCharacters(count: 99))
                    viewModel.send(.insertText(text: inputString))
                }
                .padding(.top, 31)
        }
        .padding([.leading, .trailing])
        .ignoresSafeArea(.keyboard)
        .background(Color(uiColor: .systemGray6))
    }
    
    init(showModal: Binding<Bool>, viewModel: MoteViewModel) {
        UITextField.appearance().clearButtonMode = .whileEditing
        self._showModal = showModal
        self.viewModel = viewModel
    }
}
