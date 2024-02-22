//
//  Astronaut.swift
//  Moonshot
//
//  Created by Matthew Hanlon on 2/15/24.
//

import Foundation

struct Astronaut: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
}
