//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Matthew Hanlon on 12/23/23.
//

import SwiftUI

struct ContentView: View {
    private let gameRounds = 8

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var gameComplete = false
    @State private var gameCompleteTitle = ""
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var currentScore = 0
    @State private var round = 1
    @State private var animationAmount = [0.0, 0.0, 0.0]
    @State private var opacityAmount = [1.0, 1.0, 1.0]
    @State private var scaleAmount = [1.0, 1.0, 1.0]
    @State private var wrongAnswer = [false, false, false]


    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))

                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(country: countries[number])
                        }
                        .scaleEffect(scaleAmount[number])
                        .opacity(opacityAmount[number])
                        .rotation3DEffect(.degrees(animationAmount[number]), axis: (x: 0.0, y: 1.0, z: 0.0))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score: \(currentScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Text("Round \(round)/\(gameRounds)")
                    .foregroundStyle(.white)
                    .font(.title2)

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(currentScore)")
        }
        .alert(gameCompleteTitle, isPresented: $gameComplete) {
            Button("New game", action: reset)
        } message: {    
            Text("Final score is \(currentScore)")
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            withAnimation {
                animationAmount[number] += 360
                for n in 0...2 {
                    if n != number {
                        opacityAmount[n] = 0.5
                        scaleAmount[n] = 0.5
                    }
                }
            }
            scoreTitle = "Correct!"
            currentScore += 1
        } else {
            withAnimation {
                wrongAnswer[number] = true
            } completion: {
                wrongAnswer[number] = false
            }
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            currentScore += currentScore > 0 ? -1 : 0
        }

        if round == gameRounds {
            if currentScore == gameRounds {
                gameCompleteTitle = "Perfect game!"
            } else {
                gameCompleteTitle = "Game over!"
            }
            gameComplete = true
        } else {
            showingScore = true
        }
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        round += 1

        withAnimation {
            for n in 0...2 {
                opacityAmount[n] = 1.0
                scaleAmount[n] = 1.0
            }
        }
    }

    func reset() {
        round = 0
        currentScore = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
