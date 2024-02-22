import UIKit

var greeting = "Hello, playground"

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

let result = luckyNumbers.filter { $0 % 2 == 1 }
        .sorted { $0 < $1 }
        .map { "\($0) is a lucky number" }

result.forEach { print($0) }
