import Foundation

struct Day05: Day {
    static let day = 05
    var data: String

    init(data: String) {
        self.data = Self.loadData(Self.day)
    }

    func part1() -> Any {
        let (rules, pages) = parse(data)
        let validPages = pages.filter { checkValid($0, rules) }
        return validPages.map { $0[$0.count / 2] }.reduce(0, +)
    }

    func part2() -> Any {
        let (rules, pages) = parse(data)
        let invalidPages = pages.filter { !checkValid($0, rules) }
        let correctedPages = invalidPages.map { invalidToValid($0, rules) }
        return correctedPages.map { $0[$0.count / 2] }.reduce(0, +)
    }

    func checkValid(_ row: [Int], _ rules: [Rule]) -> Bool {
        return invalidAtOrNil(row, rules) == nil
    }

    func invalidAtOrNil(_ row: [Int], _ rules: [Rule]) -> Rule? {
        var dict = [Int: [Int]]()
        for rule in rules {
            dict[rule.left, default: []].append(rule.right)
        }
        for (i, num) in row.enumerated() {
            if let mustBeAfter = dict[num] {
                for afterNum in mustBeAfter {
                    if let afterIdx = row.firstIndex(of: afterNum), afterIdx < i {
                        return Rule(left: i, right: afterIdx)
                    }
                }
            }
        }
        return nil
    }

    func invalidToValid(_ row: [Int], _ rules: [Rule]) -> [Int] {
        var orderedRow = row
        guard let invalid = invalidAtOrNil(orderedRow, rules) else {
            return orderedRow
        }
        orderedRow.swapAt(invalid.left, invalid.right)
        return invalidToValid(orderedRow, rules)
    }

    func parse(_ input: String) -> ([Rule], [[Int]]) {
        let split = data.replacingOccurrences(of: "\r\n", with: "\n").components(
            separatedBy: "\n\n")

        let rules = split[0].lines.map {
            let intPairs = $0.split(separator: "|").map(String.init).toIntArray()
            return Rule(left: intPairs[0], right: intPairs[1])
        }
        let pages = split[1].lines.map {
            $0.split(separator: ",").map(String.init).toIntArray()
        }
        return (rules, pages)
    }
}
struct Rule {
    let left: Int
    let right: Int
}
