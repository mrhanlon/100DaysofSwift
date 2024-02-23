//
//  HabitView.swift
//  HabitChallengeDay47
//
//  Created by Matthew Hanlon on 2/21/24.
//

import SwiftUI

struct HabitView: View {
    var habits: Habits
    var habit: Habit

    var body: some View {
        VStack(alignment: .leading) {
            Text(habit.name)
            Text(habit.description)
            Text("Completed \(habit.events.count) times")
            Button("Mark done") {
                if let index = habits.items.firstIndex(of: habit) {
                    habits.items[index] = Habit(id: habit.id, name: habit.name, description: habit.description, events: [HabitEvent()] + habit.events)
                }
            }

            List {
                ForEach(habit.events) {
                    Text("Completed on \($0.date)")
                }
            }
            .listStyle(.grouped)
        }
        .padding()
    }
}

#Preview {
    HabitView(habits: Habits(), habit: Habit(name: "Daily push-ups", description: "Lorem ipsum"))
}
