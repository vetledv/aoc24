// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "aoc24",
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms.git", from: "1.2.0")
    ],
    targets: [
        .executableTarget(
            name: "aoc24",
            dependencies: [.product(name: "Algorithms", package: "swift-algorithms")],
            path: "src",
            resources: [.copy("data")]
        )
    ]
)
