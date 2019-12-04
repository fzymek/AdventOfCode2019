//
// Created by Zymek, Filip on 2019-12-03.
// Copyright (c) 2019 Filip Zymek. All rights reserved.
//

import Foundation
import Cocoa


fileprivate enum ProgramError: Error {
    case cannotLoadInput
    case cannotParseInput
    case cannotCalculateSegments
}

fileprivate enum Direction: String {
    case up = "U"
    case down = "D"
    case left = "L"
    case right = "R"
}

fileprivate struct Path {
    let direction: Direction
    let distance: Int
}

fileprivate struct Input {
    let redWire: [Path]
    let blueWire: [Path]
}

fileprivate func load(path: String) throws -> String {
    let fm = FileManager.default
    let file = fm.currentDirectoryPath + "/" + path
    return try String(contentsOfFile: file)
}

fileprivate func readInput(path: String) throws -> Input {
    guard let data = try? load(path: path) else {
        print("Cannot load data!")
        throw ProgramError.cannotLoadInput
    }

    guard let input = parse(input: data) else {
        print("Cannot parse input")
        throw ProgramError.cannotParseInput
    }

    return input
}

fileprivate func parse(input: String) -> Input? {
    let wires = input.split(separator: "\n")

    guard let redWire = parseWire(wire: String(wires[0])), let blueWire = parseWire(wire: String(wires[1])) else {
        return nil
    }

    return Input(redWire: redWire, blueWire: blueWire)
}

fileprivate func parseWire(wire: String) -> [Path]? {
    let instructions = wire.split(separator: ",")

    var path: [Path] = []
    for i in instructions {
        guard let direction = Direction.init(rawValue: String(i[i.startIndex])),
              let distance = Int(String(i[i.index(i.startIndex, offsetBy: 1)...]))
                else {
            return nil
        }
        path.append(Path(direction: direction, distance: distance))
    }
    return path
}

fileprivate struct Point: Equatable, Hashable {
    let x: Int
    let y: Int

    func manhattanDistance(to point: Point) -> Int {
            return abs(x + point.x) + abs(y + point.y)
    }

    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }


}

struct Day3 {



    func part1() {
        guard let input = try? readInput(path: "input.txt") else {
            print("error")
            exit(1)
        }

        let redWirePoints = buildPoints(wire: input.redWire)
        let blueWirePoints = buildPoints(wire: input.blueWire)

        let reds = Set(redWirePoints)
        let blues = Set(blueWirePoints)
        let commonPoints = reds.intersection(blues)


        let distances = commonPoints.map { point in
            abs(0 + point.x) + abs(0 + point.y)
        }

        let sorted = distances.sorted(by: <)
        print(sorted[0])
    }


    func part2() {
        guard let input = try? readInput(path: "input.txt") else {
            print("error")
            exit(1)
        }

        let redWirePoints = buildPoints(wire: input.redWire)
        let blueWirePoints = buildPoints(wire: input.blueWire)

        let reds = Set(redWirePoints)
        let blues = Set(blueWirePoints)
        let commonPoints = reds.intersection(blues)


        var segmentsCount: [Int] = []
        for p in commonPoints {
            guard let redWireSegments = try? countSegments(of: redWirePoints, to: p),
                  let blueWireSegments = try? countSegments(of: blueWirePoints, to: p) else {
                print("error calculating segments")
                exit(1)
            }

            segmentsCount.append(redWireSegments + blueWireSegments)
        }

        print(segmentsCount.sorted(by: <)[0])

    }

    private func buildPoints(wire: [Path]) -> [Point] {
        var points: [Point] = []
        var x = 0
        var y = 0
        for path in wire {
            for _ in 0..<path.distance {
                switch path.direction {
                case .up:
                    y += 1
                case .down:
                    y -= 1
                case .left:
                    x -= 1
                case .right:
                    x += 1
                }
                points.append(Point(x: x, y: y))
            }
        }
        return points

    }

    private func countSegments(of wire: [Point], to point: Point) throws -> Int {
        var steps = 1
        for step in wire {
            if step == point {
                return steps
            }
            steps += 1
        }
        throw ProgramError.cannotCalculateSegments
    }

}

//Day3().part1()
//Day3().part2()


