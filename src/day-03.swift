import RegexBuilder

struct Day03: Day {
    static let day = 03
    var data: String

    let validMulRegex = /(mul\([0-9]+,[0-9]+\))/
    let numRegex = /[0-9]+/

    func part1() -> Any {
        let validMuls = data.matches(of: validMulRegex).map { String($0.0) }
        return validMuls.map { findNumbers(data: $0).reduce(1, *) }.reduce(0, +)
    }

    func part2() -> Any {
        return ""
    }

    private func findNumbers(data: String) -> [Int] {
        return data.matches(of: numRegex).compactMap { Int($0.0) }
    }
}
