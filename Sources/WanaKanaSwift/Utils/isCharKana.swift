import Foundation

func isCharKana(_ char: Character) -> Bool {
    isCharHiragana(char) || isCharKatakana(char)
}

/**
 * Tests a character. Returns true if the character is Hiragana or Katakana.
 */
func isCharKana(_ char: String = "") -> Bool {
    guard !char.isEmpty, let first = char.first else { return false }
    return isCharKana(first)
}
