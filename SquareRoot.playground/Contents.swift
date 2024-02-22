enum RootError: Error {
    case noRoot, outOfBounds
}

func integerSquareRoot(_ number: Int) throws -> Int {
    if (number < 1 || number > 10_000) {
        throw RootError.outOfBounds
    }

    for i in 1...100 {
        if i * i == number {
            return i
        }
    }

    throw RootError.noRoot
}

do {
    let root = try integerSquareRoot(121)
    print("\(root)")
} catch RootError.outOfBounds {
    print("Number must be between 1 and 10,000")
} catch RootError.noRoot {
    print("Number has no integer square root")
} catch {
    print("Some other error")
}
