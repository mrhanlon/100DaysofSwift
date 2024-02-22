//
//  ContentView.swift
//  iExpense
//
//  Created by Matthew Hanlon on 2/10/24.
//

import SwiftUI
import Observation

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationStack {
            TabView {
                ExpenseList(expenses: expenses, listType: "Business")
                .tabItem {
                    Label("Business expenses", systemImage: "building.2")
                }

                ExpenseList(expenses: expenses, listType: "Personal")
                .tabItem {
                    Label("Personal expenses", systemImage: "person")
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddView(expenses: expenses)
                } label: {
                    Label("Add expense", systemImage: "plus")
                }
//                Button("Add expense", systemImage: "plus") {
//                    showingAddExpense.toggle()
//                }
            }
        }
//        .sheet(isPresented: $showingAddExpense) {
//            // show an AddView here
//            AddView(expenses: expenses)
//        }
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

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double

    var isBusiness: Bool {
        type == "Business"
    }

    var isPersonal: Bool {
        type == "Personal"
    }
}

#Preview {
    ContentView()
}
