import Foundation

@main
@MainActor
struct Main {
    static func main() async {
        let arguments = CommandLine.arguments
        if arguments.count > 1, let dayNumber = Int(arguments[1]) {
            let dayToRun = days.first(where: { $0.day == dayNumber })
            try? await dayToRun?.init().run()
        } else if arguments.count == 1 {
            for dayType in days {
                print("Day \(dayType.day)")
                try? await dayType.init().run()
            }
        } else {
            print("Please provide a valid day number as an argument.")
        }
    }

    private static let days: [Day.Type] = [
        Day01.self, Day02.self, Day03.self, Day04.self,
    ]
}

protocol Day {
    static var day: Int { get }

    func part1() async throws -> Any
    func part2() async throws -> Any

    var data: String { get set }

    init(data: String)

    func run() async throws
}

extension Day {
    init() {
        self.init(data: Self.loadData(Self.day))
    }

    static func loadData(_ dd: Int) -> String {
        let day = String(format: "%02d", dd)
        let file = "day\(day)"
        let url = Bundle.module.url(
            forResource: file,
            withExtension: "txt",
            subdirectory: "data"
        )
        guard let url = url, let data = try? String(contentsOf: url, encoding: .utf8) else {
            fatalError()
        }
        return data
    }

    func run() async throws {
        do {
            let p1 = try await part1()
            print("Part 1: \(p1)")
            let p2 = try await part2()
            print("Part 2: \(p2)")
        } catch { print("Error running parts: \(error)") }
    }
}
