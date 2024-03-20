//
//  Card.swift
//  Flashzilla
//
//  Created by Matthew Hanlon on 3/18/24.
//

import Foundation

struct Card: Codable, Identifiable, Equatable {
    var id: UUID = UUID()
    var prompt: String
    var answer: String

    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")

    static func ==(lhs: Card, rhs: Card) -> Bool {
        lhs.id == rhs.id
    }
}
