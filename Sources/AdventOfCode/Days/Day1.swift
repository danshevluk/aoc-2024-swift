extension Solvers {
    static var day1: PuzzleSolver {
        PuzzleSolver(
            solvePart1: solvePart1,
            solvePart2: solvePart2
        )
    }
}

private func solvePart1(_ inputData: String) -> String? {
    var (list1, list2) = getIDsLists(inputData)
    list1.sort()
    list2.sort()

    var distancesSum = 0
    for i in (0..<list1.count) {
        distancesSum += abs(list1[i] - list2[i])
    }

    return String(distancesSum)
}

private func solvePart2(_ inputData: String) -> String? {
    let (list1, list2) = getIDsLists(inputData)

    var list2Frequency = [Int: Int]()
    for id in list2 {
        list2Frequency[id, default: 0] += 1
    }

    var score = 0
    for id in list1 {
        score += id * list2Frequency[id, default: 0]
    }

    return String(score)
}

private func getIDsLists(_ inputData: String) -> ([Int], [Int]) {
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

    return (list1, list2)
}