//
//  Expense.swift
//  iExpense
//
//  Created by Matthew Hanlon on 3/1/24.
//

import Foundation
import SwiftData

//enum ExpenseType: String, Codable, CaseIterable  {
//    case Personal, Business
//}

@Model
class Expense {
    var name: String = ""
    var type: String = "Personal"
    var amount: Double = 0.0
    var date: Date = Date.now

    init(name: String, type: String, amount: Double, date: Date) {
        self.name = name
        self.type = type
        self.amount = amount
        self.date = date
    }

    var isBusiness: Bool {
        type == "Business"
    }

    var isPersonal: Bool {
        type == "Personal"
    }

    var dateFormatted: String {
        date.formatted(date: .abbreviated, time: .omitted)
    }

    static func sample() -> Expense {
        Expense(name: "Coffee", type: "Personal", amount: 3.72, date: .now)
    }

    static func sampleList() -> [Expense] {
        [
            Expense(name: "Coffee", type: "Personal", amount: 3.72, date: .now),
            Expense(name: "Team lunch", type: "Business", amount: 37.87, date: .now.addingTimeInterval(86400 * -2)),
            Expense(name: "Apple Vision Pro", type: "Business", amount: 3500.00, date: .now.addingTimeInterval(86400 * -12)),
            Expense(name: "Freebirds", type: "Personal", amount: 38.56, date: .now.addingTimeInterval(86400 * -15)),
        ]
    }
}
