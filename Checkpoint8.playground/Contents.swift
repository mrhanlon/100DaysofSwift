protocol Building {
    var type: String { get }
    var rooms: Int { get }
    var cost: Int { get }
    var agentName: String { get set }
    
    func salesSummary() -> Void
}

extension Building {
    func salesSummary() {
        print("\(type), rooms: \(rooms), $\(cost), listed by \(agentName)")
    }
}

struct House: Building {
    let type = "House"
    let rooms: Int
    var cost: Int
    var agentName: String
}

struct Office: Building {
    let type = "Office"
    let rooms: Int
    var cost: Int
    var agentName: String
}

let house = House(rooms: 5, cost: 300_000, agentName: "Vince Martinez")
house.salesSummary()

let office = Office(rooms: 100, cost: 1_000_000, agentName: "Barack Obama")
office.salesSummary()
