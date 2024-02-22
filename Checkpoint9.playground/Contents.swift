//func getRandomEven() -> Int? {
//    let num = Int.random(in: 1...10)
//    if num % 2 == 0 {
//        return num
//    }
//    return nil
//}
//
//func printSummary(_ num: Int?) {
//    guard let num else {
//        print("Value is nil")
//        return
//    }
//
//    print("Value is \(num)")
//}
//
//printSummary(getRandomEven())


func getRandom(from: [Int]? = nil) -> Int {
    from?.randomElement() ?? Int.random(in: 1...100)
}

print(getRandom())
print(getRandom(from: [1,2,3]))
print(getRandom(from: [-1,-2,-3]))
