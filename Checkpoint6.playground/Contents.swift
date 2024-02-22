import UIKit

enum ShiftError: Error {
    case AlreadyInGear, InvalidGear
}

struct CheckpointCar {
    let model: String
    let seatCount: Int
    let maxGear: Int
    private(set) var currentGear: Int

    init(model: String, seatCount: Int, maxGear: Int) {
        self.model = model
        self.seatCount = seatCount
        self.maxGear = maxGear
        self.currentGear = 0
    }

    public func gearName() -> String {
        currentGear == 0 ? "neutral" : "gear \(currentGear)"
    }

    public mutating func shift(to gear: Int) throws {
        if currentGear == gear {
            throw ShiftError.AlreadyInGear
        } else if gear < 0 || maxGear < gear {
            throw ShiftError.InvalidGear
        }

        self.currentGear = gear

        print("Now in \(gearName())")
    }
}

var car = CheckpointCar(model: "Honda Civic", seatCount: 5, maxGear: 5)

print(car.gearName())

try car.shift(to: 1)
try car.shift(to: 3)
try car.shift(to: 5)
try car.shift(to: 0)

