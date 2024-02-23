//
//  Habit.swift
//  HabitChallengeDay47
//
//  Created by Matthew Hanlon on 2/21/24.
//

import Foundation
import Observation

@Observable
class Habits {
    var items = [Habit]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedItems = try? JSONDecoder().decode([Habit].self, from: savedItems) {
                items = decodedItems
                print("Decoded \(items.count) habits")
                return
            }
        }

        items = []
    }
}

struct Habit: Codable, Equatable, Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var events = [HabitEvent]()

    var completedToday: Bool {
        let today = Calendar.current.dateComponents([.day, .month, .year], from: Date.now)

        return events.contains { event in
            let components = Calendar.current.dateComponents([.day, .month, .year], from: event.date)
            return components.year == today.year && components.month == today.month && components.day == today.day
        }
    }
}

struct HabitEvent: Codable, Equatable, Identifiable {
    var id = UUID()
    var date = Date.now
}
