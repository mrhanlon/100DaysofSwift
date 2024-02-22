//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Matthew Hanlon on 1/22/24.
//

import SwiftUI

struct ContentView: View {
    private let gameRounds = 10
    private let playOptions = ["🪨", "📄", "✂️"]
    private let winOptions = ["📄", "✂️", "🪨"]

    @State private var appChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var round = 1
    @State private var score = 0

    @State private var showEndgame = false
    @State private var endgameMessage = ""

    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                    .init(color: Color.mint, location: 0),
                    .init(color: Color.black, location: 2)
                ],
                center: .top,
                startRadius: 400,
                endRadius: 700
            )
            .ignoresSafeArea()

            VStack {
                Spacer()
                VStack(spacing: 20) {
                    Text("App played: \(playOptions[appChoice])")
                        .font(.largeTitle.bold())

                    Text("Choose the \(shouldWin ? "winning" : "losing") move!")
                    HStack {
                        ForEach(0...2, id: \.self) { option in
                            Button(playOptions[option]) {
                                playerChoice(option)
                            }
                            .font(.largeTitle)
                            .padding()
                        }
                    }
                }
                .padding()
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 25))
                Spacer()
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                Spacer()
            }
        }
        .alert("Game over!", isPresented: $showEndgame) {
            Button("New game", action: newGame)
        } message: {
            Text(endgameMessage)
        }
    }

    func playerChoice(_ choice: Int) {
        let winChoice = (appChoice + 1) % 3
        let loseChoice = (appChoice + 2) % 3
        let correct = choice == (shouldWin ? winChoice : loseChoice)

        if correct {
            score += 1
        } else {
            score -= 1
        }

        reset()
    }

    func reset() {
        if round == 10 {
            return gameOver()
        }

        round += 1
        shouldWin.toggle()
        appChoice = Int.random(in: 0...2)
    }

    func gameOver() {
        endgameMessage = score == gameRounds ? "Perfect score!" : "Good game. Try again?"
        showEndgame = true
    }

    func newGame() {
        round = 1
        score = 0
    }
}

#Preview {
    ContentView()
}
