//
//  User.swift
//  SwiftDataProject
//
//  Created by Matthew Hanlon on 2/28/24.
//

import Foundation
import SwiftData

@Model
class User {
    var name: String = ""
    var city: String = ""
    var joinDate: Date = Date.now
    @Relationship(deleteRule: .cascade) var jobs: [Job]? = [Job]()

    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }

    static func sampleData(modelContext: ModelContext) -> [User] {
        let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
        let second = User(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
        let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
        let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))

        modelContext.insert(first)
        modelContext.insert(second)
        modelContext.insert(third)
        modelContext.insert(fourth)

        return [first, second, third, fourth]
    }
}
