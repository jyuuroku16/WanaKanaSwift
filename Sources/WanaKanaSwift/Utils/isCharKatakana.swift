import Foundation

/**
 * Tests a character. Returns true if the character is Katakana.
 * - Parameter char: Character string to test
 * - Returns: Boolean indicating if the character is Katakana
 */
func isCharKatakana(_ char: String = "") -> Bool {
    return isCharInRange(char, start: KATAKANA_START, end: KATAKANA_END)
}
