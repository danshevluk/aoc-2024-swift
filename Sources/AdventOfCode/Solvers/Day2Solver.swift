struct Day2Solver: PuzzleSolver {
    func solve(_ inputData: String, part: PuzzlePart) -> String? {
        switch part {
        case .one:
            return solvePart1(inputData)
        case .two:
            return solvePart2(inputData)
        }
    }

    func solvePart1(_ inputData: String) -> String? {
        let lines = inputData.components(separatedBy: .newlines)

        func isDataSafe(_ levels: [Int]) -> Bool {
            var increasing: Bool?
            for i in 0..<levels.count-1 {
                let diff = levels[i + 1] - levels[i]
                defer { increasing = diff > 0 }

                let isConsistent = increasing.map { $0 == (diff > 0) } ?? true
                let diffInBounds = (1...3) ~= abs(diff)

                if !isConsistent || !diffInBounds {
                    return false
                }
            }
            return true
        }

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
        return nil
    }
}