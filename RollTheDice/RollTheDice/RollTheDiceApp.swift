//
//  RollTheDiceApp.swift
//  RollTheDice
//
//  Created by Matthew Hanlon on 3/22/24.
//

import SwiftData
import SwiftUI

@main
struct RollTheDiceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: DiceRoll.self)
    }
}
