//
//  Order.swift
//  CupcakeCorner
//
//  Created by Matthew Hanlon on 2/23/24.
//

import SwiftUI

@Observable
class Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false

    var name = UserDefaults.standard.string(forKey: "Order.name") ?? "" {
        didSet {
            UserDefaults.standard.setValue(name.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "Order.name")
        }
    }
    var streetAddress = UserDefaults.standard.string(forKey: "Order.streetAddress") ?? "" {
        didSet {
            UserDefaults.standard.setValue(streetAddress.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "Order.streetAddress")
        }
    }
    var city = UserDefaults.standard.string(forKey: "Order.city") ?? "" {
        didSet {
            UserDefaults.standard.setValue(city.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "Order.city")
        }
    }
    var zip = UserDefaults.standard.string(forKey: "Order.zip") ?? "" {
        didSet {
            UserDefaults.standard.setValue(zip.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "Order.zip")
        }
    }

    var hasValidAddress: Bool {
        let invalid = (
            name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        )
        return !invalid
    }

    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }

    func reset() {
        type = 0
        quantity = 3
        specialRequestEnabled = false
    }
}

extension Order {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zip = "zip"
    }
}
