//
// Created by Zymek, Filip on 2019-12-04.
// Copyright (c) 2019 Filip Zymek. All rights reserved.
//

import Foundation

fileprivate enum ProgramError: Error {
    case cannotLoadInput
    case cannotParseInput
}

fileprivate struct Input {
    let min: Int
    let max: Int
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

    return Input(min: input.0, max: input.1)
}

fileprivate func load(path: String) throws -> String {
    let fm = FileManager.default
    let file = fm.currentDirectoryPath + "/" + path
    return try String(contentsOfFile: file)
}

fileprivate func parse(input: String) -> (Int, Int)? {
    guard let separatorIndex = input.firstIndex(of: "-") else {
        return nil
    }

    let startString = String(input[input.startIndex..<separatorIndex])
    let endString = String(input[input.index(separatorIndex, offsetBy: 1)...])
    guard let start = Int(startString), let end = Int(endString) else {
        return nil
    }

    return (start, end)
}


fileprivate struct Day4 {

    func part1() {
        guard let input = try? readInput(path: "input.txt") else {
            print("error")
            exit(1)
        }

        var numbers: [Int] = []
        for i in input.min...input.max {
            numbers.append(i)
        }

        let possiblePasswords = numbers.filter {
            let hasDoubleDigit = checkDoubleDigits(in: $0)
            let hasIncreasingOrder = checkIncreasingOrder(in: $0)
            return hasDoubleDigit && hasIncreasingOrder
        }
        print(possiblePasswords.count)

    }


    func checkDoubleDigits(in number: Int) -> Bool {
        let num = String(number)
        var hasDuplicate = false

        for i in 0..<num.count-1 {
            let lIdx = num.index(num.startIndex, offsetBy: i)
            let rIdx = num.index(num.startIndex, offsetBy: i+1)
            if String(num[lIdx]) == String(num[rIdx]) {
                hasDuplicate = true
            }
        }

        return hasDuplicate
    }

    func checkIncreasingOrder(in number: Int) -> Bool {

        var num = number
        var prev = 10
        while num > 0 {
            let rest = num % 10
            if (rest <= prev) {
                prev = rest
                num = Int(num/10)
                continue
            }
            return false
        }

        return true
    }

}

Day4().part1()
