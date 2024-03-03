//
//  Friend.swift
//  FriendFace
//
//  Created by Matthew Hanlon on 3/2/24.
//

import Foundation

struct Friend: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String
}
