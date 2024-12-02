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
