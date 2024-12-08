extension String {
    var lines: [String] {
        return split(whereSeparator: \.isNewline).map { String($0) }
    }

    func lineToInts() -> [Int] {
        return split(whereSeparator: \.isWhitespace).compactMap { num in
            Int(num)
        }
    }
}
extension Array where Element == String {
    func toIntArray() -> [Int] {
        return compactMap { Int($0) }
    }
}
