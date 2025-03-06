import Foundation

// Unicode ranges for Hiragana characters
let HIRAGANA_START: Int = 0x3041
let HIRAGANA_END: Int = 0x3096

/**
 * Tests a character. Returns true if the character is Hiragana.
 * - Parameter char: Character string to test
 * - Returns: Boolean indicating if the character is Hiragana
 */
func isCharHiragana(_ char: String = "") -> Bool {
    if char.isEmpty { return false }
    if isCharLongDash(char) { return true }
    return isCharInRange(char, start: HIRAGANA_START, end: HIRAGANA_END)
}
