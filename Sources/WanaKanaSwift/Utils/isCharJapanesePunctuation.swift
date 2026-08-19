import Foundation

func isCharJapanesePunctuation(_ char: Character) -> Bool {
    if isCharIterationMark(char) { return false }
    guard let code = unicodeCodePoint(char) else { return false }
    return isCode(code, inRanges: JA_PUNCTUATION_RANGES)
}

/**
 * Tests a character. Returns true if the character is considered Japanese punctuation.
 */
func isCharJapanesePunctuation(_ char: String = "") -> Bool {
    guard !char.isEmpty, let first = char.first else { return false }
    return isCharJapanesePunctuation(first)
}
