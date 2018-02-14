//: Playground - noun: a place where people can play

import UIKit

protocol Bird: CustomStringConvertible {
    var name: String { get }
    var canFly: Bool { get }
}

extension CustomStringConvertible where Self: Bird {
    var description: String {
        return canFly ? "I can fly" : "Guess I'll just sit here. :("
    }
}

extension Bird {
    var canFly: Bool { return self is Flyable }
}

protocol Flyable {
    var airSpeedVelocity: Double { get }
}

struct FlappyBird: Bird {
    let name: String
    let flappyAmplitude: Double
    let flappyFrequency: Double
    
    var airSpeedVelocity: Double {
        return 3 * flappyFrequency * flappyAmplitude
    }
}

struct Penguin: Bird {
    let name: String
}

struct SwiftBird: Bird, Flyable {
    var name: String { return "Swift \(version)"}
    let version: Double
    
    var airSpeedVelocity: Double { return version * 1000.00}
}

enum UnladenSwallow: Bird, Flyable {
    case african
    case european
    case unknown
    
    var name: String {
        switch self{
        case .african:
            return "African"
        case .european:
            return "European"
        case .unknown:
            return "What do you mean? African or European?"
        }
    }
    
    var airSpeedVelocity: Double {
        switch self {
        case .african:
            return 10.0
        case .european:
            return 9.9
        case .unknown:
            fatalError("You are thrown from the bridge of death.")
        }
    }
}

extension UnladenSwallow {
    var canFly: Bool {
        return self != .unknown
    }
}

UnladenSwallow.unknown.canFly
UnladenSwallow.african.canFly
Penguin(name: "King Penguin").canFly
UnladenSwallow.african

let numbers = [10, 20, 30, 40, 50, 60]
let slice = numbers[1...3]
let reversedSlice = slice.reversed()

let answer = reversedSlice.map { $0 * 10 }
print(answer)

class Motorcycle {
    init(name: String) {
        self.name = name
        speed = 200
    }

    var name: String
    var speed: Double
}

protocol Racer {
    var speed: Double { get }
}

extension FlappyBird: Racer {
    var speed: Double { return airSpeedVelocity }
}

extension SwiftBird: Racer {
    var speed: Double { return airSpeedVelocity }
}

extension Penguin: Racer {
    var speed: Double { return 42 }
}

extension UnladenSwallow: Racer {
    var speed: Double {
        return canFly ? airSpeedVelocity : 0
    }
}

extension Motorcycle: Racer {}

let racers: [Racer] =
[
    UnladenSwallow.african,
    UnladenSwallow.european,
    UnladenSwallow.unknown,
    Penguin(name: "King Penguin"),
    SwiftBird(version: 3.0),
    FlappyBird(name: "Felipe", flappyAmplitude: 3.0, flappyFrequency: 20.0),
    Motorcycle(name: "Giacomo")
]

func topSpeed<RacerType: Sequence>(of racers: RacerType) -> Double
    where RacerType.Iterator.Element == Racer {
        return racers.max(by: { $0.speed < $1.speed })?.speed ?? 0
    }
//    return racers.max(by: { $0.speed < $1.speed })?.speed ?? 0

topSpeed(of: racers)
topSpeed(of: racers[1...3])

extension Sequence where Iterator.Element == Racer {
    func topSpeed() -> Double {
        return self.max(by: { $0.speed < $1.speed })?.speed ?? 0
    }
}
racers.topSpeed()
racers[1...3].topSpeed()

protocol Score: Equatable, Comparable {
    var value: Int { get }
}

struct RacingScore: Score {
    let value: Int
    
    static func ==(lhs: RacingScore, rhs: RacingScore) -> Bool {
        return lhs.value == rhs.value
    }
    
    static func <(lhs: RacingScore, rhs: RacingScore) -> Bool {
        return lhs.value < rhs.value
    }
}

RacingScore(value: 150) >= RacingScore(value: 130)







