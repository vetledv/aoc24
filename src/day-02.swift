import Algorithms

struct Day02: Day {
    static let day = 02
    var data: String

    private let reports: [Report]

    init(data: String) {
        self.data = Self.loadData(Self.day)
        reports = data.lines.compactMap { Report(levels: $0.lineToInts()) }
    }

    func part1() -> Any {
        return reports.filter { $0.isSafe }.count
    }

    func part2() -> Any {
        return reports.filter { $0.isSafeWithDampener }.count
    }
}
struct Report {
    let levels: [Int]

    var isSafe: Bool {
        let isIncreasing = levels[1] > levels[0]
        for (a, b) in levels.adjacentPairs() {
            let seq = 1...3
            let diff = abs(a - b)
            let diffOutOfRange = !(seq ~= diff)
            let violatesOrder = (isIncreasing && b < a) || (!isIncreasing && b > a)

            if diffOutOfRange || violatesOrder { return false }
        }
        return true
    }

    var isSafeWithDampener: Bool {

        if isSafe { return true }
        for i in 0..<levels.count {
            var dampened = levels
            dampened.remove(at: i)
            if Report(levels: dampened).isSafe { return true }
        }
        return false
    }
}
