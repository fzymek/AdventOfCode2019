//
// Created by Zymek, Filip on 2019-12-02.
// Copyright (c) 2019 Filip Zymek. All rights reserved.
//

import Foundation
import Cocoa


func readInput(path: String) -> [Int] {
    let fm = FileManager.default
    let inputPath = fm.currentDirectoryPath + "/" + path
    let inputData = try? String(contentsOfFile: inputPath);
    guard let input = inputData else {
        print("Cannot read input")
        exit(1)
    }

    let data = input.split(separator: ",")
    return data.map { Int($0)! }
}

//print(readInput(path: "input.txt"))

class IntcodeComputer {
    var input: [Int]

    init(input: [Int]) {
        self.input = input
    }

    func run() -> Int {

        var current = 0
        var operation: Int
        var input1: Int
        var input2: Int
        var resultIndex: Int

        while (input[current] != 99) {
            operation = input[current]
            input1 = input[current + 1]
            input2 = input[current + 2]
            resultIndex = input[current + 3]

            var operationResult: Int
            switch operation {
            case 1:
                operationResult = input[input1] + input[input2]
            case 2:
                operationResult = input[input1] * input[input2]
            default:
                print("invalid opcode: \(operation)")
                exit(1)
            }

            input[resultIndex] = operationResult
            current += 4
        }

        return input[0]

    }

}

//let testData1 = [1,0,0,0,99]
//let testData2 = [2,3,0,3,99]
//let testData3 = [2,4,4,5,99,0]
//let testData4 = [1,1,1,4,99,5,6,0,99]
//
//IntcodeComputer(input: testData1).run()
//IntcodeComputer(input: testData2).run()
//IntcodeComputer(input: testData3).run()
//IntcodeComputer(input: testData4).run()

let data = readInput(path: "input.txt")
//part 1
var input1 = data
input1[1] = 12
input1[2] = 2
let result = IntcodeComputer(input: input1).run()
print("ans 1: \(result)")

//part 2
for noun in 0...99 {
    for verb in 0...99 {
        var input = data
        input[1] = noun
        input[2] = verb
        let result = IntcodeComputer(input: input).run()
        if result == 19690720 {
            print("ans 2: \(100 * noun + verb)")
        }
    }
}
