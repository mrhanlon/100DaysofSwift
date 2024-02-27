//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Matthew Hanlon on 2/25/24.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
