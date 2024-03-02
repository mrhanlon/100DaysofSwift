//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Matthew Hanlon on 2/10/24.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
