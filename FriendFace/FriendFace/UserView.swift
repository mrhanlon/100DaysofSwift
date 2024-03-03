//
//  UserView.swift
//  FriendFace
//
//  Created by Matthew Hanlon on 3/2/24.
//

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
                    if user.friends.isEmpty {
                        ContentUnavailableView {
                            Label("No friends yet", systemImage: "person.3")
                        } description: {
                            Text("Add some friends and they will appear here!")
                        }
                    } else {
                        ForEach(user.friends) { friend in
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
    NavigationStack {
        UserView(user: User.sample(UserAttrs(friends: [Friend(name: "Jon Doe"), Friend(name: "Jane Doe")])))
    }
}
