import Foundation

func isCharHiragana(_ char: Character) -> Bool {
    isCharLongDash(char) || isCharInRange(char, start: HIRAGANA_START, end: HIRAGANA_END)
}

/**
 * Tests a character. Returns true if the character is Hiragana.
 */
func isCharHiragana(_ char: String = "") -> Bool {
    guard let first = char.first, !char.isEmpty else { return false }
    return isCharHiragana(first)
}
