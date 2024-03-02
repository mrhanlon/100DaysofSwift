//
//  ExpenseList.swift
//  iExpense
//
//  Created by Matthew Hanlon on 2/14/24.
//

import SwiftData
import SwiftUI

enum ListType: String, CaseIterable {
    case All, Business, Personal
}

struct ExpenseList: View {
    @Environment(\.modelContext) var modelContext

    @Query var expenses: [Expense]

    init(listType: ListType, sortOrder: [SortDescriptor<Expense>]) {
        if listType == .Business {
            _expenses = Query(filter: #Predicate<Expense> { expense in
                expense.type == "Business"
            }, sort: sortOrder)
        } else if listType == .Personal {
            _expenses = Query(filter: #Predicate<Expense> { expense in
                expense.type == "Personal"
            }, sort: sortOrder)
        } else {
            _expenses = Query(sort: sortOrder)
        }
    }

    var body: some View {
        List {
            ForEach(expenses) {
                ExpenseRow(expense: $0)
                    .expenseHighlight(amount: $0.amount)
            }
            .onDelete(perform: removeItems)
        }
    }

    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let item = expenses[offset]
            modelContext.delete(item)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Expense.self, configurations: config)

        let sampleList = Expense.sampleList()
        sampleList.forEach {
            container.mainContext.insert($0)
        }

        return ExpenseList(listType: .All, sortOrder: [SortDescriptor(\Expense.date, order: .reverse)])
            .modelContainer(container)
    } catch {
        return Text("Error: \(error.localizedDescription)")
    }
}
