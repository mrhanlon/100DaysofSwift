for i in 1...100 {
    let fizz = i % 3 == 0
    let buzz = i % 5 == 0

    if fizz || buzz {
        print("\(fizz ? "Fizz" : "")\(buzz ? "Buzz" : "")")
    } else {
        print("\(i)")
    }
}
