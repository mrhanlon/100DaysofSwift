//
//  ContentView.swift
//  iExpense
//
//  Created by Matthew Hanlon on 2/10/24.
//

import SwiftData
import SwiftUI
import Observation

struct ContentView: View {
    @Query var expenses: [Expense]

    @State private var listType = ListType.All
    @State private var sortOrder: [SortDescriptor<Expense>] = [
        SortDescriptor(\Expense.date, order: .reverse)
    ]

    var body: some View {
        NavigationStack {
            ExpenseList(listType: listType, sortOrder: sortOrder)
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu("Filter expenses", systemImage: "line.3.horizontal.decrease.circle\(listType == .All ? "" : ".fill")") {
                        Picker("Expense type", selection: $listType) {
                            ForEach(ListType.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("By date (newest first)")
                                .tag([SortDescriptor(\Expense.date, order: .reverse)])
                            Text("By date (oldest first)")
                                .tag([SortDescriptor(\Expense.date, order: .forward)])
                            Text("By name (A-Z)")
                                .tag([SortDescriptor(\Expense.name, order: .forward)])
                            Text("By name (Z-A)")
                                .tag([SortDescriptor(\Expense.name, order: .reverse)])
                        }
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddView()
                    } label: {
                        Label("Add expense", systemImage: "plus")
                    }
                }
            }
        }
    }
}

struct ExpenseStyle: ViewModifier {
    let amount: Double
    func body(content: Content) -> some View {
        content
            .foregroundColor(
                amount >= 100 ? .red : (
                    amount >= 10 ? .primary : .indigo
                )
            )
    }
}

extension View {
    func expenseHighlight(amount: Double) -> some View {
        modifier(ExpenseStyle(amount: amount))
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

        return ContentView()
            .modelContainer(container)
    } catch {
        return Text("Error: \(error.localizedDescription)")
    }
}
