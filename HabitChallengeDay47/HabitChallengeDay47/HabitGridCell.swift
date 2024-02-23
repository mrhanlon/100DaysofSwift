//
//  HabitGridCell.swift
//  HabitChallengeDay47
//
//  Created by Matthew Hanlon on 2/22/24.
//

import SwiftUI

struct HabitGridCell: View {
    let habit: Habit

    var body: some View {
        VStack {
            Text(habit.name)
            Image(systemName: habit.completedToday ? "checkmark.circle.fill" : "circle")
        }
        .padding()
        .frame(width: 165, height: 165)
        .background(.indigo)
        .foregroundStyle(.white)
        .font(.system(size: 28, weight: .semibold))
        .clipShape(
            RoundedRectangle(cornerRadius: 42)
        )
    }
}

struct HabitPlaceholder: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 42)
            .stroke(.indigo, style: .init(lineWidth: 5, dash: [10, 10]))
            .frame(width: 160, height: 160)
    }
}

#Preview {
    HabitGridCell(habit: Habit(name: "Daily push-ups", description: "Do push-ups daily", events: []))
}

#Preview {
    HabitPlaceholder()
}

#Preview {
    ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 165))], spacing:  35.5) {
            HabitGridCell(habit: Habit(name: "Daily push-ups", description: "Do push-ups daily", events: []))
            HabitGridCell(habit: Habit(name: "Daily push-ups", description: "Do push-ups daily", events: []))
            HabitPlaceholder()
        }
    }
}
