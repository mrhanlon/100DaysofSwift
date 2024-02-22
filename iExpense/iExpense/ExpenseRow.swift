//
//  ExpenseRow.swift
//  iExpense
//
//  Created by Matthew Hanlon on 2/14/24.
//

import SwiftUI

struct ExpenseRow: View {
    var expense: ExpenseItem

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(expense.name)
                    .font(.headline)
                Text(expense.type)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        }
    }
}

#Preview {
    List {
        ExpenseRow(expense: ExpenseItem(name: "Coffee", type: "Personal", amount: 4.37))
    }
}
