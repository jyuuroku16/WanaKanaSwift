import Foundation

func isCharJapanese(_ char: Character) -> Bool {
    guard let code = unicodeCodePoint(char) else { return false }
    return isCode(code, inRanges: JAPANESE_RANGES)
}

/**
 * Tests a character. Returns true if the character is Japanese.
 */
func isCharJapanese(_ char: String = "") -> Bool {
    guard !char.isEmpty, let first = char.first else { return false }
    return isCharJapanese(first)
}
