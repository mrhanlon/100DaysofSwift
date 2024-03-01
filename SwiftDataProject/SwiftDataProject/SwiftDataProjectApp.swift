//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Matthew Hanlon on 2/28/24.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
