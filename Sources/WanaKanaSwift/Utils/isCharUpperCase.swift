import Foundation

/**
 * Tests if char is in English unicode uppercase range
 * - Parameter char: Character to test
 * - Returns: True if character is uppercase
 */
func isCharUpperCase(_ char: String = "") -> Bool {
    if char.isEmpty { return false }
    return isCharInRange(char, start: LATIN_UPPERCASE_START, end: LATIN_UPPERCASE_END)
}
