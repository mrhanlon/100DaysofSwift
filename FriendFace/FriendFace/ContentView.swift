//
//  ContentView.swift
//  FriendFace
//
//  Created by Matthew Hanlon on 3/2/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext

    @Query(sort: [SortDescriptor(\User.isActive, order: .reverse), SortDescriptor(\User.name)]) var users: [User]

    var body: some View {
        NavigationStack {
            VStack {
                if users.isEmpty {
                    ProgressView()
                } else {
                    List(users) { user in
                        NavigationLink(value: user) {
                            UserRow(user: user)
                        }
                    }
                }
            }
            .navigationTitle("Friend Face")
            .navigationDestination(for: User.self) {
                UserView(user: $0)
            }
            .navigationDestination(for: Friend.self) { friend in
                if let friendUser = users.first(where: { $0.id == friend.id}) {
                    UserView(user: friendUser)
                } else {
                    Text("Friend not found")
                }
            }
        }
        .task {
            if users.isEmpty {
                print("Fetching users")
                let remoteUsers = await User.fetchUsers()
                for u in remoteUsers {
                    modelContext.insert(u)
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)

        return ContentView()
            .modelContainer(container)
    } catch {
        return Text(error.localizedDescription)
    }
}
