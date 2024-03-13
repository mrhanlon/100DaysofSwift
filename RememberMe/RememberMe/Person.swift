//
//  Person.swift
//  RememberMe
//
//  Created by Matthew Hanlon on 3/12/24.
//

import Foundation
import SwiftData
import SwiftUI
import PhotosUI

@Model
class Person {
    var name: String
    @Attribute(.externalStorage) var imageData: Data

    init(name: String, imageData: Data) {
        self.name = name
        self.imageData = imageData
    }

    static let example = Person(name: "Christian Buehner", imageData: UIImage(resource: .example).pngData()!)
}
