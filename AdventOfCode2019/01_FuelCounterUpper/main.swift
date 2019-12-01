//
// Created by Zymek, Filip on 2019-12-01.
// Copyright (c) 2019 Filip Zymek. All rights reserved.
//

import Foundation
import Cocoa


struct Input {
    let modules: [Int]
}


func readInput(path: String) -> Input {
    let fm = FileManager.default

    let path = fm.currentDirectoryPath + "/" + path

    let inputCotnent = try? String(contentsOfFile: path)

    guard let input = inputCotnent else {
        print("Cannot read input")
        exit(1)
    }

    return Input(modules: input.split(separator: "\n").map { Int($0)!} )

}


// part 1
let input = readInput(path: "input.txt")
//print(input.modules)

let fuel = input.modules.reduce(0, {x,y in
    x + Int(floor(Double(y) / 3) - 2)
})
print(fuel)
