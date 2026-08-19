import Foundation

func isCharEnglishPunctuation(_ char: Character) -> Bool {
    guard let code = unicodeCodePoint(char) else { return false }
    return isCode(code, inRanges: EN_PUNCTUATION_RANGES)
}

/**
 * Tests a character. Returns true if the character is considered English punctuation.
 */
func isCharEnglishPunctuation(_ char: String = "") -> Bool {
    guard !char.isEmpty, let first = char.first else { return false }
    return isCharEnglishPunctuation(first)
}
