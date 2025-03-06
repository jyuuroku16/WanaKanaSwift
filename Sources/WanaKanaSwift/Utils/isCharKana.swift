import Foundation

/**
 * Tests a character. Returns true if the character is Hiragana or Katakana.
 * - Parameter char: Character string to test
 * - Returns: Boolean indicating if the character is Hiragana or Katakana
 */
func isCharKana(_ char: String = "") -> Bool {
    if char.isEmpty { return false }
    return isCharHiragana(char) || isCharKatakana(char)
}
