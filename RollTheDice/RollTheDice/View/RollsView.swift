//
//  DieView.swift
//  RollTheDice
//
//  Created by Matthew Hanlon on 3/22/24.
//

import SwiftData
import SwiftUI

struct RollsView: View {
    @Query(sort: [SortDescriptor(\DiceRoll.date, order: .reverse)]) var rolls: [DiceRoll]

    var body: some View {
        List {
            ForEach(rolls) { rolls in
                VStack(alignment: .leading) {
                    Text("Total: \(rolls.total)")
                    Text(rolls.dateFormatted)
                        .font(.caption)
                }
            }
        }
        .overlay {
            if rolls.isEmpty {
                ContentUnavailableView("No dice rolls", systemImage: "dice", description: Text("Let's roll some dice!"))
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: DiceRoll.self, configurations: config)

        container.mainContext.insert(DiceRoll.example)

        return RollsView()
            .modelContainer(container)
    } catch {
        return Text(error.localizedDescription)
    }
}
