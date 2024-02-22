//
//  Question.swift
//  MultiplicationGame
//
//  Created by Matthew Hanlon on 2/10/24.
//

import Foundation

struct Question: Hashable, Identifiable {
    let id: Int
    let x: Int
    let y: Int

    var question: String {
        "\(x) x \(y) = ?"
    }

    var questionWithAnswer: String {
        "\(x) x \(y) = \(answer)"
    }

    var answer: Int {
        x * y
    }
}
