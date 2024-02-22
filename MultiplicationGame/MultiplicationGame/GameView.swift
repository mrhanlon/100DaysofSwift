//
//  GameView.swift
//  MultiplicationGame
//
//  Created by Matthew Hanlon on 2/10/24.
//

import SwiftUI

struct GameView: View {
    let questionCount: Int
    let tableSize: Int

    @Environment(\.dismiss) private var dismiss

    @State private var questions: [Question] = []
    @State private var questionIndex = 0
    @State private var currentAnswer = ""
    @State private var score = 0
    @State private var answerAlertTitle = ""
    @State private var answerAlertMessage = ""
    @State private var showAnswerAlert = false
    @FocusState private var focused: Bool

    var answerFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.zeroSymbol = ""
        return formatter
    }

    var body: some View {
        ZStack {
            LinearGradient(
                stops: [
                    .init(color: Color.mint, location: 0.5),
                    .init(color: Color.teal, location: 1),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).ignoresSafeArea()

            VStack {
                Spacer()
                VStack(spacing: 25) {
                    if questionIndex < questions.count {
                        Text(questions[questionIndex].question)
                            .font(.title)

                        TextField("Answer", text: $currentAnswer)
                            .padding()
                            .multilineTextAlignment(.center)
                            .font(.largeTitle)
                            .focused($focused)

                        Button("Check answer", action: checkAnswer)
                            .font(.title2)
                            .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.capsule)
                            .tint(.orange)
                    } else {
                        Text("Final score: \(score)/\(questions.count)")
                            .font(.title)

                        Button("Play again?", action: startGame)
                            .font(.title2)
                            .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.capsule)
                            .tint(.orange)

                        Button("Back to game menu") {
                            dismiss()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 50)
                .background(.thickMaterial)
                .clipShape(.rect(cornerRadius: 25))
                .shadow(radius: 10)

                Spacer()
                Spacer()
                Spacer()
            }
            .padding(42)
        }
        .onAppear(perform: startGame)

        .onSubmit(checkAnswer)
        .alert(answerAlertTitle, isPresented: $showAnswerAlert) {
            Button("Next question") {
                questionIndex += 1
                currentAnswer = ""
                focused = true
            }
        } message: {
            Text(answerAlertMessage)
        }
        .navigationTitle(
            questionIndex < questions.count ?
            "Question \(questionIndex + 1) of \(questions.count)" :
                "Final score"
        )
    }

    func startGame() {
        questions.removeAll()
        for n in 0..<questionCount {
            questions.append(
                Question(
                    id: n,
                    x: Int.random(in: 0...tableSize),
                    y: Int.random(in: 0...tableSize)
                )
            )
        }
        questionIndex = 0
        score = 0
        focused = true
    }

    func checkAnswer() {
        let numericAnswer = Int(currentAnswer)
        guard let numericAnswer else {
            currentAnswer = ""
            focused = true
            return
        }

        if numericAnswer == questions[questionIndex].answer {
            score += 1
            answerAlertTitle = "Correct!"
            answerAlertMessage = "That's the correct answer!"
        } else {
            answerAlertTitle = "Wrong"
            answerAlertMessage = "Not quite, \(questions[questionIndex].questionWithAnswer)."
        }
        showAnswerAlert.toggle()
    }
}

#Preview {
    NavigationStack {
        GameView(questionCount: 2, tableSize: 6)
    }

}
