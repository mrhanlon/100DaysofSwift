//
//  AddView.swift
//  HabitChallengeDay47
//
//  Created by Matthew Hanlon on 2/21/24.
//

import SwiftUI

struct AddView: View {
    var habits: Habits

    @State private var name = ""
    @State private var description = ""

    @Environment(\.dismiss) var dismiss

    var body: some View {
        Form {
            Section("Name") {
                TextField("Name", text: $name)
            }

            Section("Description") {
                TextField("Description", text: $description, axis: .vertical)
                    .lineLimit(5...10)
            }

            Button("Save", action: addHabit)
                .frame(maxWidth: .infinity)
        }
        .navigationTitle("New Habit")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
        }
    }

    func addHabit() {
        habits.items.append(Habit(name: name, description: description))
        dismiss()
    }
}

#Preview {
    NavigationStack {
        AddView(habits: Habits())
    }
}
