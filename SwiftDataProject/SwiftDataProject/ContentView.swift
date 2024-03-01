//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Matthew Hanlon on 2/28/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = [User]()

    @State private var showingUpcomingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate),
    ]

    var body: some View {
        NavigationStack(path: $path) {
            UsersView(minimumJoinDate: showingUpcomingOnly ? .now : .distantPast, sortOrder: sortOrder)
                .navigationTitle("Users")
                .navigationDestination(for: User.self) { user in
                    EditUserView(user: user)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort", selection: $sortOrder) {
                                Text("Sort by Name")
                                    .tag([
                                        SortDescriptor(\User.name),
                                        SortDescriptor(\User.joinDate),
                                    ])

                                Text("Sort by Join Date")
                                    .tag([
                                        SortDescriptor(\User.joinDate),
                                        SortDescriptor(\User.name)
                                    ])
                            }
                        }

                    }

                    ToolbarItem(placement: .topBarLeading) {
                        Button(showingUpcomingOnly ? "Show Everyone" : "Show Upcoming") {
                            showingUpcomingOnly.toggle()
                        }
                    }


                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add User", systemImage: "plus") {
                            let user = User(name: "", city: "", joinDate: .now)
                            modelContext.insert(user)
                            path = [user]
                        }
                    }
                }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)

        User.sampleData(modelContext: container.mainContext)

        return ContentView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
