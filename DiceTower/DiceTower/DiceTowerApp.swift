//
//  DiceTowerApp.swift
//  DiceTower
//
//  Created by Matthew Hanlon on 3/22/24.
//

import SwiftData
import SwiftUI

@main
struct DiceTowerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: DiceRoll.self)
    }
}
