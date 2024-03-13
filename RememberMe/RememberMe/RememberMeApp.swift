//
//  RememberMeApp.swift
//  RememberMe
//
//  Created by Matthew Hanlon on 3/12/24.
//

import SwiftData
import SwiftUI

@main
struct RememberMeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Person.self)
    }
}
