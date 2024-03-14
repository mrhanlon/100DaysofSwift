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
    var latitude: Double?
    var longitude: Double?
    @Attribute(.externalStorage) var imageData: Data

    init(name: String, imageData: Data) {
        self.name = name
        self.imageData = imageData
        self.latitude = latitude
        self.longitude = longitude
    }


    init(name: String, imageData: Data, latitude: Double?, longitude: Double?) {
        self.name = name
        self.imageData = imageData
        self.latitude = latitude
        self.longitude = longitude
    }

    var coordinate: CLLocationCoordinate2D? {
        get {
            if let lat = latitude, let lon = longitude {
                return CLLocationCoordinate2D(latitude: lat, longitude: lon)
            }
            return nil
        }

        set(newValue) {
            latitude = newValue?.latitude ?? nil
            longitude = newValue?.longitude ?? nil
        }
    }

    static let example = Person(
        name: "Christian Buehner",
        imageData: UIImage(resource: .example).pngData()!,
        latitude: 51.507222,
        longitude: -0.1275
    )
}
