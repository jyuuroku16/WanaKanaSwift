import Foundation

// Unicode ranges for Katakana characters
let KATAKANA_START: Int = 0x30a1
let KATAKANA_END: Int = 0x30fc

/**
 * Tests a character. Returns true if the character is Katakana.
 * - Parameter char: Character string to test
 * - Returns: Boolean indicating if the character is Katakana
 */
func isCharKatakana(_ char: String = "") -> Bool {
    return isCharInRange(char, start: KATAKANA_START, end: KATAKANA_END)
}
