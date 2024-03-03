//
//  User.swift
//  FriendFace
//
//  Created by Matthew Hanlon on 3/2/24.
//

import Foundation
import SwiftData

@Model
class User: Codable, Identifiable, Hashable {
    enum CodingKeys: CodingKey {
        case id
        case isActive
        case name
        case age
        case company
        case email
        case address
        case about
        case registered
        case tags
        case friends
    }

    var id: UUID = UUID()
    var isActive: Bool = true
    var name: String = ""
    var age: Int = 0
    var company: String = ""
    var email: String = ""
    var address: String = ""
    var about: String = ""
    var registered: Date = Date.now
    var tags: [String] = [String]()
    var friends: [Friend]?

    var registeredFormatted: String {
        self.registered.formatted(date: .long, time: .omitted)
    }

    var unwrappedFriends: [Friend] {
        friends ?? []
    }

    init(id: UUID, isActive: Bool, name: String, age: Int, company: String, email: String, address: String, about: String, registered: Date, tags: [String], friends: [Friend]) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.tags = tags
        self.friends = friends
    }


    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.registered = try container.decode(Date.self, forKey: .registered)
        self.tags = try container.decode([String].self, forKey: .tags)
        self.friends = try container.decodeIfPresent([Friend].self, forKey: .friends)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.isActive, forKey: .isActive)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.age, forKey: .age)
        try container.encode(self.company, forKey: .company)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.address, forKey: .address)
        try container.encode(self.about, forKey: .about)
        try container.encode(self.registered, forKey: .registered)
        try container.encode(self.tags, forKey: .tags)
        try container.encodeIfPresent(self.friends, forKey: .friends)
    }
}

extension User {
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

extension User {
    struct UserAttrs {
        var id: UUID?
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

    static func sample(_ attrs: UserAttrs = UserAttrs()) -> User {
        User(
            id: attrs.id ?? UUID(),
            isActive: attrs.isActive ?? true,
            name: attrs.name ?? "Toby Z.",
            age: attrs.age ?? 27,
            company: attrs.company ?? "White House",
            email: attrs.email ?? "toby.z@example.com",
            address: attrs.address ?? "123 Main St., Washington, DC, USA",
            about: attrs.about ?? "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
            registered: attrs.registered ?? .now.addingTimeInterval(-8765432),
            tags: attrs.tags ?? [],
            friends: attrs.friends ?? []
        )
    }
}
