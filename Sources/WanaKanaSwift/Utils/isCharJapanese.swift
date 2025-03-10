import Foundation

/**
 * Tests a character. Returns true if the character is Japanese.
 * - Parameter char: Character string to test
 * - Returns: Boolean indicating if the character is Japanese
 */
func isCharJapanese(_ char: String = "") -> Bool {
    if char.isEmpty { return false }
    return JAPANESE_RANGES.contains { range in
        isCharInRange(char, start: range[0], end: range[1])
    }
}
