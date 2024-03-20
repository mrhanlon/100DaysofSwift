//
//  CardView.swift
//  Flashzilla
//
//  Created by Matthew Hanlon on 3/18/24.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled

    let card: Card
    var onCorrect: (() -> Void)? = nil
    var onWrong: (() -> Void)? = nil

    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(differentiateWithoutColor ?
                    .white :
                        .white.opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25)
                        .cardSwipeColor(offset: offset)
                )
                .shadow(radius: 10)

            VStack {
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(offset.width / 5.0))
        .offset(x: offset.width * 2)
        .opacity(2 - Double(abs(offset.width / 100)))
        .accessibilityAddTraits(.isButton)
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.bouncy, value: offset)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if offset.width > 100 {
                        onCorrect?()
                    } else if offset.width < -100 {
                        onWrong?()
                        isShowingAnswer = false
                        offset = .zero
                    }
                }
        )
    }
}

extension Shape {
    func cardSwipeColor(offset: CGSize) -> some View {
        var color: Color
        if offset == CGSize.zero {
            color = .white
        } else if offset.width > 0 {
            color = .green
        } else {
            color = .red
        }
        return self.fill(color);
    }
}

#Preview {
    CardView(card: .example)
}
