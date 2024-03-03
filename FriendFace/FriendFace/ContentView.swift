//
//  ContentView.swift
//  FriendFace
//
//  Created by Matthew Hanlon on 3/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var users: [User] = [User]()

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
                print("Fetch users")
                users = await User.fetchUsers()
            }
        }
    }
}

#Preview {
    ContentView()
}
