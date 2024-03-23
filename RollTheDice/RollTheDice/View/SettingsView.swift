//
//  SettingsView.swift
//  RollTheDice
//
//  Created by Matthew Hanlon on 3/22/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss

    @State var dice: [Die]
    var onSave: (DiceConfig) -> Void

    var body: some View {
        NavigationStack {
            Form {
                ForEach($dice) { $die in
                    Picker("\(die.type.rawValue)-sided die", selection: $die.type) {
                        ForEach(DieType.allCases, id: \.self) {
                            Text("\($0.rawValue)")
                        }
                    }
                }
                .onDelete(perform: removeDie)
                .onMove(perform: moveDice)

                Button("Add die") {
                    dice.append(.standard)
                }
            }
            .navigationTitle("Dice settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        onSave(DiceConfig(dice: dice.map { $0.type }))
                        dismiss()
                    }
                }
            }
        }
    }

    func removeDie(at offsets: IndexSet) {
        dice.remove(atOffsets: offsets)
    }

    func moveDice(from: IndexSet, to: Int) {
        dice.move(fromOffsets: from, toOffset: to)
    }
}

#Preview {
    SettingsView(dice: [.standard, .standard]) { _ in }
}
