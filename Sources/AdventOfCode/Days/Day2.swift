extension Solvers {
    static var day2: PuzzleSolver {
        PuzzleSolver(
            solvePart1: solvePart1,
            solvePart2: solvePart2
        )
    }
}

private func isDataSafe(_ levels: [Int]) -> Bool {
    var isIncreasing: Bool?
    for i in 0..<levels.count-1 {
        let diff = levels[i + 1] - levels[i]
        defer {
            if isIncreasing == nil {
                isIncreasing = diff > 0
            }
        }

        let isConsistent = isIncreasing.map { $0 == (diff > 0) } ?? true
        let diffInBounds = (1...3) ~= abs(diff)

        if !isConsistent || !diffInBounds {
            return false
        }
    }
    return true
}

private func solvePart1(_ inputData: String) -> String? {
    let lines = inputData.components(separatedBy: .newlines)
    let safeLines = lines.reduce(into: 0) { result, line in
        let levels = line.components(separatedBy: .whitespaces).compactMap { Int($0) }
        let isSafe = isDataSafe(levels)

        if isSafe {
            result += 1
        }
    }
    return String(safeLines)
}

private func solvePart2(_ inputData: String) -> String? {
    let lines = inputData.components(separatedBy: .newlines)

    let safeLines = lines.reduce(into: 0) { result, line in
        let levels = line.components(separatedBy: .whitespaces).compactMap { Int($0) }

        for skip in 0..<levels.count {
            var modifiedLevels = levels
            modifiedLevels.remove(at: skip)

            let isSafe = isDataSafe(modifiedLevels)
            if isSafe {
                result += 1
                break
            }
        }
    }
    return String(safeLines)
}