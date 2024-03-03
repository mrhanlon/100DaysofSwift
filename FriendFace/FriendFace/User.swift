//
//  User.swift
//  FriendFace
//
//  Created by Matthew Hanlon on 3/2/24.
//

import Foundation

struct UserAttrs {
    var isActive: Bool?
    var name: String?
    var age: Int?
    var company: String?
    var email: String?
    var address: String?
    var about: String?
    var registered: Date?
    var tags: [String]?
    var friends: [Friend]?
}

struct User: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]

    var registeredFormatted: String {
        self.registered.formatted(date: .long, time: .omitted)
    }

    static func sample(_ attrs: UserAttrs = UserAttrs()) -> User {
        User(
            isActive: attrs.isActive ?? true,
            name: attrs.name ?? "Test User",
            age: attrs.age ?? 27,
            company: attrs.company ?? "Apple",
            email: attrs.email ?? "test.user@example.com",
            address: attrs.address ?? "123 Main St., Anytown, USA",
            about: attrs.about ?? "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
            registered: attrs.registered ?? .now.addingTimeInterval(-8765432),
            tags: attrs.tags ?? [],
            friends: attrs.friends ?? []
        )
    }

    static func fetchUsers() async -> [User] {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let response = try? decoder.decode([User].self, from: data) {
                return response
            } else {
                print("Failed to decode users")
            }
        } catch {
            print("Failed to fetch users: \(error.localizedDescription)")
        }

        return []
    }
}
