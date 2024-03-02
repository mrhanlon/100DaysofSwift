//
//  ExpenseRow.swift
//  iExpense
//
//  Created by Matthew Hanlon on 2/14/24.
//

import SwiftData
import SwiftUI

struct ExpenseRow: View {
    var expense: Expense

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(expense.name)
                    .font(.headline)
                Text(expense.type)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing) {
                Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                Text(expense.dateFormatted)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Expense.self, configurations: config)

        let expense = Expense.sample()
        container.mainContext.insert(expense)

        return List {
            ExpenseRow(expense: expense)
        }
    } catch {
        return Text("Error: \(error.localizedDescription)")
    }
}
