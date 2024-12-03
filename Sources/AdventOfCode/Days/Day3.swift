import Foundation

extension Solvers {
    static var day3: PuzzleSolver {
        PuzzleSolver(
            solvePart1: solvePart1,
            solvePart2: solvePart2
        )
    }
}

private func solvePart1(_ inputData: String) -> String? {
    let pattern = /mul\((\d{1,3}),(\d{1,3})\)/

    let recoveredSum = inputData.matches(of: pattern).reduce(0) { sum, match in
        let x = Int(match.output.1) ?? 0
        let y = Int(match.output.2) ?? 0
        return sum + x * y
    }

    return String(recoveredSum)
}

private func solvePart2(_ inputData: String) -> String? {
    let pattern = /(?x) (?<mul>mul\((?<x>\d{1,3}),(?<y>\d{1,3})\)) | (?<do>do\(\)) | (?<dont>don't\(\))/

    var executionEnabled = true
    var recoveredSum = 0
    for match in inputData.matches(of: pattern) {
        if match.output.mul != nil {
            let x = match.output.x.flatMap { Int($0) } ?? 0
            let y = match.output.y.flatMap { Int($0) } ?? 0
            if executionEnabled {
                recoveredSum += x * y
            }
        } else if match.output.do != nil {
            executionEnabled = true
        } else if match.output.dont != nil {
            executionEnabled = false
        }
    }

    return String(recoveredSum)
}