import Foundation

func isCharIterationMark(_ char: Character) -> Bool {
    unicodeCodePoint(char) == KANJI_ITERATION_MARK
}

/**
 * Returns true if char is '々'
 */
func isCharIterationMark(_ char: String = "") -> Bool {
    guard !char.isEmpty, let first = char.first else { return false }
    return isCharIterationMark(first)
}
