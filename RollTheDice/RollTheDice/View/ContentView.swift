//
//  ContentView.swift
//  RollTheDice
//
//  Created by Matthew Hanlon on 3/22/24.
//

import Combine
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext

    @State var diceSet = DiceSet()
    @State var showSettings = false

    var body: some View {
        NavigationStack {
            VStack {
                DiceView(diceSet: diceSet, onRoll: saveRoll)
                    .padding()
                
                RollsView()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Dice settings", systemImage: "gear") {
                        showSettings = true
                    }
                }
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(dice: diceSet.dice) { newConfig in
                diceSet.config = newConfig
            }
        }
        .onAppear {
            loadDiceConfig()
        }
    }

    func loadDiceConfig() {
        diceSet.config = DiceConfig.load()
    }

    func saveRoll(_ dice: [Die]) {
        withAnimation {
            modelContext.insert(DiceRoll(dice: dice.map { $0.type }, result: dice.map { $0.currentValue }))
        }
    }
}

extension View {
    func diceStyle(color: Color) -> some View {
        self
            .frame(width: 36, height: 36)
            .background(color)
            .clipShape(.rect(cornerSize: .init(width: 5, height: 5)))
    }

    func rollingRotation(_ on: Bool, rollAmount: Double) -> some View {
        self.rotation3DEffect(
            on ? .degrees(-360 * rollAmount) : .zero,
            axis: (x: 1, y: 0.2, z: 0),
            perspective: 0.25
        )
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: DiceRoll.self, configurations: config)

        return ContentView()
            .modelContainer(container)
    } catch {
        return Text(error.localizedDescription)
    }
}
