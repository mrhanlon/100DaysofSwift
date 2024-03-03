//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Matthew Hanlon on 3/2/24.
//

import SwiftData
import SwiftUI

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
