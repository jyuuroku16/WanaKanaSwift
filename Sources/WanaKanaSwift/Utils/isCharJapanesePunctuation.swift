import Foundation

/**
 * Tests a character. Returns true if the character is considered Japanese punctuation.
 * - Parameter char: Character string to test
 * - Returns: Boolean indicating if the character is Japanese punctuation
 */
func isCharJapanesePunctuation(_ char: String = "") -> Bool {
    if char.isEmpty || isCharIterationMark(char) { return false }
    return JA_PUNCTUATION_RANGES.contains { range in
        isCharInRange(char, start: range[0], end: range[1])
    }
}
