//
//  ContentView.swift
//  MultiplicationGame
//
//  Created by Matthew Hanlon on 2/8/24.
//

import SwiftUI

enum GameState {
    case Playing, Results
}

struct ContentView: View {
    @State private var gameActive = false
    @State private var tableSize = 6
    @State private var questionCount = 10
    @State private var questions: [Question] = []

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    stops: [
                        .init(color: Color.mint, location: 0.5),
                        .init(color: Color.teal, location: 1),
                    ],
                    startPoint: .topTrailing,
                    endPoint: .bottomLeading
                ).ignoresSafeArea()

                VStack {
                    Spacer()
                    
                    VStack(spacing: 30) {
                        Text("Game setup")
                            .font(.title)
                        
                        Text("Multiple numbers up to")
                            .font(.title2)
                        
                        Stepper("\(tableSize) x \(tableSize)", value: $tableSize, in: 2...12)
                            .font(.title3)
                        
                        Text("Number of questions")
                            .font(.title2)
                        
                        Picker("Number of questions", selection: $questionCount) {
                            Text("5").tag(5)
                            Text("10").tag(10)
                            Text("15").tag(15)
                        }
                        .pickerStyle(.segmented)
                        
                        Button("Let's multiply!") {
                            gameActive.toggle()
                        }
                        .font(.title2)
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                        .tint(.orange)
                        
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 20)
                    .background(.thickMaterial)
                    .clipShape(.rect(cornerRadius: 25))
                    .shadow(radius: 10)

                    Spacer()
                    Spacer()
                }
                .padding(24)
            }
            .navigationTitle("Multiplication game")
            .navigationDestination(isPresented: $gameActive) {
                GameView(questionCount: questionCount, tableSize: tableSize)
            }
        }
    }
}

#Preview {
    ContentView()
        .previewDisplayName("ContentView")
}
