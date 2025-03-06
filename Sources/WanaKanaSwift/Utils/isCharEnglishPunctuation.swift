import Foundation

/**
 * Tests a character. Returns true if the character is considered English punctuation.
 * - Parameter char: Character string to test
 * - Returns: Boolean indicating if the character is English punctuation
 */
func isCharEnglishPunctuation(_ char: String = "") -> Bool {
    if char.isEmpty { return false }
    return EN_PUNCTUATION_RANGES.contains { range in
        isCharInRange(char, start: range[0], end: range[1])
    }
}
