import ArgumentParser
import Foundation

struct PuzzleSolver {
    var solvePart1:  (_ inputData: String) -> String? = { _ in nil }
    var solvePart2: (_ inputData: String) -> String? = { _ in nil }

    func solve(_ inputData: String, part: PuzzlePart) -> String? {
        switch part {
        case .one:
            return solvePart1(inputData)
        case .two:
            return solvePart2(inputData)
        }
    }
}

enum PuzzlePart: String, Codable, CaseIterable {
    case one
    case two
}

enum Solvers {
    static var empty: PuzzleSolver { .init() }
    static func make(for day: Int) -> PuzzleSolver {
        switch day {
        case 1:
            return Solvers.day1
        case 2:
            return Solvers.day2
        default:
            return empty
        }
    }
}

// MARK: - Solver Command

@main
struct PuzzleSolverCommand: AsyncParsableCommand {
    @Option(name: .long, help: "Day number for a puzzle.")
    var day: Int = 1

    @Option(help: "Part one or two", completion: .list(PuzzlePart.allCases.map(\.rawValue)), transform: Self.transformPartArgument)
    var part: PuzzlePart = .one

    @Argument(help: "File path for puzzle input.", completion: .file(), transform: URL.init(fileURLWithPath:))
    var input: URL

    static func transformPartArgument(_ value: String) throws -> PuzzlePart {
        guard let part = PuzzlePart(rawValue: value) else { throw ValidationError("Invalid puzzle part") }
        return part
    }

    mutating func run() async throws {
        guard let inputData = try? String(contentsOf: input, encoding: .utf8) else {
            print("Failed to read input file")
            return
        }

        print("Loaded input!")
        print("Input lines count: \(inputData.count)")

        let solver = Solvers.make(for: day)
        print()

        if let solution = solver.solve(inputData, part: part) {
            print("The answer is...")
            print(solution)
        } else {
            print("No solution for day \(day), part \'\(part.rawValue)\'")
        }
    }
}
