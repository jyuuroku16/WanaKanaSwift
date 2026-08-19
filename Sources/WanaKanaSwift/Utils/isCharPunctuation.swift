import Foundation

func isCharPunctuation(_ char: Character) -> Bool {
    isCharEnglishPunctuation(char) || isCharJapanesePunctuation(char)
}

/**
 * Tests a character. Returns true if the character is considered Japanese or English punctuation.
 */
func isCharPunctuation(_ char: String? = "") -> Bool {
    guard let char, !char.isEmpty, let first = char.first else { return false }
    return isCharPunctuation(first)
}
