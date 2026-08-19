func unicodeScalar(_ char: Character) -> Unicode.Scalar? {
    char.unicodeScalars.first
}

func unicodeCodePoint(_ char: Character) -> Int? {
    unicodeScalar(char).map { Int($0.value) }
}

func isCode(_ code: Int, inRange start: Int, _ end: Int) -> Bool {
    start <= code && code <= end
}

func isCode(_ code: Int, inRanges ranges: [[Int]]) -> Bool {
    ranges.contains { range in
        isCode(code, inRange: range[0], range[1])
    }
}
