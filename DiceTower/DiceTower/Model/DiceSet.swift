//
//  DiceConfig.swift
//  DiceTower
//
//  Created by Matthew Hanlon on 3/22/24.
//

import Foundation
import SwiftUI

enum DieType: Int, CaseIterable, Codable {
    case four = 4
    case six = 6
    case eight = 8
    case ten = 10
    case twelve = 12
    case twenty = 20
    case onehundred = 100
}

struct DiceConfig: Codable {
    var dice: [DieType]

    static var example: DiceConfig {
        DiceConfig(dice: [.six, .six])
    }

    static func load() -> DiceConfig {
        if let data = UserDefaults.standard.data(forKey: "DiceConfig") {
            if let decoded = try? JSONDecoder().decode(DiceConfig.self, from: data) {
                return decoded
            }
        }
        return DiceConfig(dice: [.six, .six])
    }

    func save() {
        if let data = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(data, forKey: "DiceConfig")
        } else {
            print("Failed to persist dice configuration")
        }
    }
}

@Observable
class DiceSet {
    var config: DiceConfig {
        didSet {
            dice = config.dice.map { Die(type: $0) }
            config.save()
        }
    }

    var dice: [Die]

    var hasRolled: Bool {
        dice[0].currentValue > 0
    }

    var currentRollTotal: Int {
        dice.reduce(0, { $0 + $1.currentValue })
    }

    init(config: DiceConfig = .example) {
        self.config = config
        self.dice = config.dice.map { Die(type: $0) }
    }

    func roll() {
        for i in 0..<dice.count {
            dice[i].roll()
        }
    }
}

struct Die: Identifiable, Codable {
    enum codingKeys: CodingKey {
        case type
    }

    var id = UUID()
    var type: DieType
    var currentValue = 0

    mutating func roll() {
        currentValue = Int.random(in: 1...type.rawValue)
    }

    static var standard: Die {
        Die(type: .six)
    }
}
