struct Day04: Day {
    static let day = 04
    var data: String

    private let directions = [
        (1, 0), (-1, 0),
        (0, 1), (0, -1),
        (-1, -1), (1, -1),
        (-1, 1), (1, 1),
    ]
    private let searchWord = "XMAS"
    private let grid: [[Character]]

    init(data: String) {
        self.data = Self.loadData(Self.day)
        grid = data.lines.map { $0.map(Character.init) }
    }

    func part1() -> Any {
        var count = 0
        for y in 0..<grid.count {
            for x in 0..<grid[y].count {
                for (dx, dy) in directions {
                    if findWord(searchWord, in: grid, at: (x, y), dir: (dx, dy)) {
                        count += 1
                    }
                }
            }
        }
        return count
    }

    func part2() -> Any {
        return "world"
    }

    func findWord(
        _ word: String, in grid: [[Character]], at pos: (x: Int, y: Int), dir: (x: Int, y: Int)
    ) -> Bool {
        var result = ""
        for i in 0..<word.count {
            let checkPos = (pos.x + dir.x * i, pos.y + dir.y * i)
            guard let char = tryGetChar(arr: grid, pos: checkPos) else {
                continue
            }
            result += String(char)
        }
        return word == result
    }

    func tryGetChar(arr: [[Character]], pos: (x: Int, y: Int)) -> Character? {
        let xCheck = pos.x >= 0 && pos.x < arr[0].count
        let yCheck = pos.y >= 0 && pos.y < arr.count
        guard xCheck && yCheck else { return nil }
        return arr[pos.y][pos.x]
    }
}
