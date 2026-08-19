import Foundation

func isCharKatakana(_ char: Character) -> Bool {
    isCharInRange(char, start: KATAKANA_START, end: KATAKANA_END)
}

/**
 * Tests a character. Returns true if the character is Katakana.
 */
func isCharKatakana(_ char: String = "") -> Bool {
    guard !char.isEmpty, let first = char.first else { return false }
    return isCharKatakana(first)
}
