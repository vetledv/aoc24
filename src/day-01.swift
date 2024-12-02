struct Day01: Day {
    static var day = 01
    var data: String

    func part1() -> Any {
        let (left, right) = parse(data)
        return left.sorted(by: <).enumerated().map { i, el in
            abs(el - right.sorted(by: <)[i])
        }.reduce(0, +)
    }

    func part2() -> Any {
        let (left, right) = parse(data)
        let rightFreq = Dictionary(right.map { ($0, 1) }, uniquingKeysWith: +)
        return left.map { num in
            let freq = rightFreq[num, default: 0]
            return num * freq
        }.reduce(0, +)
    }

    private func parse(_ data: String) -> ([Int], [Int]) {
        let ints: [(Int, Int)] = data.lines.compactMap { line in
            let comps = line.split(whereSeparator: \.isWhitespace)
            guard let first = Int(comps[0]), let second = Int(comps[1])
            else { return nil }
            return (first, second)
        }
        return (ints.map { $0.0 }, ints.map { $0.1 })
    }
}
