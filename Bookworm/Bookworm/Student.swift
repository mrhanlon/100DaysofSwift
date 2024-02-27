//
//  Student.swift
//  Bookworm
//
//  Created by Matthew Hanlon on 2/25/24.
//

import Foundation
import SwiftData

@Model
class Student {
    var id: UUID
    var name: String

    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
