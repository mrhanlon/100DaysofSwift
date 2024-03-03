//
//  UserView.swift
//  FriendFace
//
//  Created by Matthew Hanlon on 3/2/24.
//

import SwiftData
import SwiftUI

struct UserView: View {
    let user: User

    var body: some View {
        VStack {
            List {
                Section("Email") {
                    Text(user.email)
                        .monospaced()
                }

                Section("Address") {
                    Text(user.address)
                }

                Section("Age") {
                    Text(String(user.age))
                }

                Section("Company") {
                    Text(user.company)
                }

                Section("About") {
                    Text(user.about)
                }

                Section("Registered date") {
                    Text(user.registeredFormatted)
                }

                Section("Tags") {
                    Text(user.tags.joined(separator: ", "))
                }

                Section("Friends") {
                    if user.unwrappedFriends.isEmpty {
                        ContentUnavailableView {
                            Label("No friends yet", systemImage: "person.3")
                        } description: {
                            Text("Add some friends and they will appear here!")
                        }
                    } else {
                        ForEach(user.unwrappedFriends) { friend in
                            NavigationLink(value: friend) {
                                HStack {
                                    Text(friend.name.prefix(1))
                                        .font(.largeTitle.bold())
                                        .frame(width: 48, height: 48)
                                        .overlay {
                                            Circle()
                                                .strokeBorder(.primary, lineWidth: 2)
                                        }
                                    Text(friend.name)
                                }
                            }
                        }
                    }
                }
            }
        }.navigationTitle(user.name)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)

        let user = User.sample()
        container.mainContext.insert(user)

        let friend1 = Friend(id: UUID(), name: "Jon Doe")
        let friend2 = Friend(id: UUID(), name: "Jane Doe")
        container.mainContext.insert(friend1)
        container.mainContext.insert(friend2)
        
        user.friends = [friend1, friend2]

        return NavigationStack {
            UserView(user: user)
        }
        .modelContainer(container)
    } catch {
        return Text(error.localizedDescription)
    }
}
