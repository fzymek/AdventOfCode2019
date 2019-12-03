//
// Created by Zymek, Filip on 2019-12-01.
// Copyright (c) 2019 Filip Zymek. All rights reserved.
//

import Foundation
import Cocoa


fileprivate struct Input {
    let modules: [Int]
}


fileprivate func readInput(path: String) -> Input {
    let fm = FileManager.default

    let path = fm.currentDirectoryPath + "/" + path

    let inputCotnent = try? String(contentsOfFile: path)

    guard let input = inputCotnent else {
        print("Cannot read input")
        exit(1)
    }

    return Input(modules: input.split(separator: "\n").map { Int($0)!} )

}

fileprivate func calculateTotalFuelForMass(mass: Int) -> Int {

    let tmp = Int(floor(Double(mass) / 3)) - 2
    if tmp <= 0 {
        return 0
    }

    return tmp + calculateTotalFuelForMass(mass: tmp)
}

struct Day1 {
    fileprivate let input = readInput(path: "input.txt")
    func part1() {
        //print(input.modules)

        let fuel = input.modules.reduce(0, {x,y in
            x + Int(floor(Double(y) / 3) - 2)
        })
        print("Q1: \(fuel)")
    }

    func part2() {
        let tmpInput = input
        let totalFuel = tmpInput.modules.reduce(0, {x,y in
            x + calculateTotalFuelForMass(mass: y)
        })
        print("Q2: \(totalFuel)")
    }

}

//Day1().part1()
//Day1().part2()


