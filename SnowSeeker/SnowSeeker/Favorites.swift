//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Matthew Hanlon on 3/25/24.
//

import SwiftUI

@Observable
class Favorites {
    var resorts: Set<String> {
        didSet {
            save()
        }
    }

    // the key we're using to read/write in UserDefaults
    private static let saveKey = "Favorites"

    init() {
        resorts = Favorites.load()
    }

    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    func add(_ resort: Resort) {
        resorts.insert(resort.id)
    }

    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
    }

    static func load() -> Set<String> {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                return decoded
            }
        }
        return []
    }

    func save() {
        if let data = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(data, forKey: Favorites.saveKey)
        } else {
            print("Failed to persist favorites")
        }
    }
}
