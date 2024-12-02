struct Day02: Day {

    static var day = 02
    var data: String

    private let reports: [Report]

    init(data: String) {
        self.data = Self.loadData(Self.day)
        reports = data.lines.compactMap { Report(data: $0.lineToInts()) }
    }

    func part1() -> Any {
        return reports.filter { $0.isSafe }.count
    }

    func part2() -> Any {
        return ""
    }
}
struct Report {
    let data: [Int]

    var isSafe: Bool {
        for i in 0..<data.count - 1 {
            let diff = abs(data[i] - data[i + 1])
            if !(1...3).contains(diff) { return false }
        }
        let inc = data[0] < data[1]
        let dec = inc == false
        for i in 1..<data.count {
            if inc && data[i] < data[i - 1] {
                return false
            } else if dec && data[i] > data[i - 1] {
                return false
            }
        }
        return true
    }


}
