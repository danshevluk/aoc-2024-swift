import Foundation

struct Day1Solver: PuzzleSolver {
    func solve(_ inputData: String, part: PuzzlePart) async -> String? {
        switch part {
        case .one:
            return solvePart1(inputData)
        case .two:
            return solvePart2(inputData)
        }
    }

    private func solvePart1(_ inputData: String) -> String? {
        let lines = inputData.components(separatedBy: .newlines)
        var list1 = [Int]()
        var list2 = [Int]()

        for line in lines {
            let rowNumbers = line.components(separatedBy: .whitespaces)
            if let firstNumber = rowNumbers.first.flatMap({ Int($0) })  {
                list1.append(firstNumber)
            }
            if let lastNumber = rowNumbers.last.flatMap({ Int($0) })  {
                list2.append(lastNumber)
            }
        }
        list1.sort()
        list2.sort()

        var distancesSum = 0
        for i in (0..<list1.count) {
            distancesSum += abs(list1[i] - list2[i])
        }

        return String(distancesSum)
    }

    private func solvePart2(_ inputData: String) -> String? {
        nil
    }
}