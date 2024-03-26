//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Matthew Hanlon on 3/25/24.
//

import SwiftUI

@Observable
class Favorites {
    // the actual resorts the user has favorited
    var resorts: Set<String> {
        didSet {
            save()
        }
    }

    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    init() {
        // load our saved data

        // still here? Use an empty array
        resorts = []
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
    }

    func save() {
        // write out our data
    }
}
