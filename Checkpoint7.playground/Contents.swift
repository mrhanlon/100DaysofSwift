import UIKit

class Animal {
    let legs: Int

    init(legs: Int) {
        self.legs = legs
    }
}

class Dog : Animal {
    func speak() {
        print("woof!")
    }
}

class Cat : Animal {
    var isTame: Bool

    init(isTame: Bool, legs: Int) {
        self.isTame = isTame
        super.init(legs: legs)
    }

    func speak() {
        print("meow!")
    }
}

class Corgi : Dog {
    override func speak() {
        print("low woof!")
    }
}

class Poodle : Dog {
    override func speak() {
        print("curly woof!")
    }
}

class Persian: Cat {
    override func speak() {
        print("small meow!")
    }
}

class Lion: Cat {
    override func speak() {
        print("big meow!")
    }

}

let aCat = Cat(isTame: true, legs: 4)
let aDog = Dog(legs: 4)

aCat.speak()
aDog.speak()

let aCorg = Corgi(legs: 4)
let aLion = Lion(isTame: false, legs: 4)

aCorg.speak()
aLion.speak()

aCat.isTame
aLion.isTame
