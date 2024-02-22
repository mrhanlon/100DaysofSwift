//
//  ExpenseList.swift
//  iExpense
//
//  Created by Matthew Hanlon on 2/14/24.
//

import SwiftUI

struct ExpenseList: View {
    var expenses: Expenses
    let listType: String

    var body: some View {
        List {
            ForEach(expenses.items.filter { $0.type == listType }) {
                ExpenseRow(expense: $0)
                    .expenseHighlight(amount: $0.amount)
            }
            .onDelete(perform: removeItems)
        }
    }

    func removeItems(at offsets: IndexSet) {
        let sublist = expenses.items.filter { $0.type == listType }
        let idsToRemove = offsets.map { sublist[$0].id }
        expenses.items.removeAll { idsToRemove.contains($0.id) }
    }
}

#Preview {
    ExpenseList(expenses: Expenses(), listType: "Business")
}


#Preview {
    ExpenseList(expenses: Expenses(), listType: "Personal")
}
