//
//  GuideView.swift
//  Mote
//
//  Created by Ярослав Седышев on 30.03.2024.
//

import SwiftUI

struct GuideView: View {
    @ObservedObject var viewModel: MoteViewModel
    
    var faqItems: [FAQItem] = [
        FAQItem(question: Strings.FAQ.q1, answer: Strings.FAQ.a1),
        FAQItem(question: Strings.FAQ.q1, answer: Strings.FAQ.a1),
        FAQItem(question: Strings.FAQ.q1, answer: Strings.FAQ.a1),
        FAQItem(question: Strings.FAQ.q1, answer: Strings.FAQ.a1),
        FAQItem(question: Strings.FAQ.q1, answer: Strings.FAQ.a1),
        FAQItem(question: Strings.FAQ.q1, answer: Strings.FAQ.a1),
    ]
    
    var body: some View {
        ScrollView {
            ForEach(faqItems) { faqItem in
                DisclosureGroup(faqItem.question) { Text(faqItem.answer) }
                    .disclosureGroupStyle(MoteFAQDisclosureStyle())
            }

            Spacer()
        }
        .environmentObject(viewModel)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemGray6))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "arrow.backward")
                    .font(.system(size: Globals.smallTitleSize, weight: .bold, design: .rounded))
                    .foregroundColor(.accent)
                    .padding(.top, 10)
                    .onTapGesture {
                        viewModel.navigationPath.removeAll()
                    }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Text(Strings.Titles.faq)
                    .font(.system(size: Globals.smallTitleSize, weight: .bold, design: .rounded))
                    .foregroundColor(.accent)
                    .padding(.trailing, Globals.iconPadding)
                    .padding(.top, 10)
            }
        }
    }
}

struct MoteFAQDisclosureStyle: DisclosureGroupStyle {
    @EnvironmentObject var viewModel: MoteViewModel
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 15) {
                configuration.label
                    .font(.system(size: Globals.smallTitleSize, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(Globals.lineHeight)
                
                Spacer()
                
                Image(systemName: "chevron.compact.right")
                    .font(.system(size: Globals.iconSize, weight: .bold, design: .rounded))
                    .foregroundColor(.accent)
                    .rotationEffect(.degrees(configuration.isExpanded ? 90 : 0))
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.smooth) {
                    configuration.isExpanded.toggle()
                }
                if viewModel.preferencesHapticFeedback {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
            }
            
            if configuration.isExpanded {
                configuration.content
                    .font(.system(size: Globals.bodyFontSize, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                    .opacity(configuration.isExpanded ? 1 : 0)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(Globals.lineHeight)
                    .padding(.top, 5)
                    .padding(.trailing, 15)
            }
        }
        .padding([.leading, .trailing], 25)
        .padding(.top, 25)
    }
}

struct FAQItem: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
    @State var isExpanded: Bool = true
}
