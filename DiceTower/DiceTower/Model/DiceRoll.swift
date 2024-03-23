//
//  DiceRoll.swift
//  RollTheDice
//
//  Created by Matthew Hanlon on 3/22/24.
//

import Foundation
import SwiftData

@Model
class DiceRoll {
    var dice: [DieType] = [DieType]()
    var result: [Int] = [Int]()
    var date: Date = Date.now

    var diceCount: Int {
        dice.count
    }

    var total: Int {
        result.reduce(0, +)
    }

    var dateFormatted: String {
        date.formatted(date: .abbreviated, time: .shortened)
    }

    init(dice: [DieType], result: [Int], date: Date = .now) {
        self.dice = dice
        self.result = result
        self.date = date
    }

    static var example: DiceRoll {
        .init(dice: [.six, .six], result: [5, 4])
    }
}
