//
//  CardView.swift
//  Flashzilla
//
//  Created by Matthew Hanlon on 3/18/24.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var removal: (() -> Void)? = nil

    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .shadow(radius: 10)

            VStack {
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundStyle(.black)

                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(offset.width / 5.0))
        .offset(x: offset.width * 2)
        .opacity(2 - Double(abs(offset.width / 100)))
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        removal?()
                    } else {
                        offset = .zero
                    }
                }
        )
    }
}

#Preview {
    CardView(card: .example)
}
