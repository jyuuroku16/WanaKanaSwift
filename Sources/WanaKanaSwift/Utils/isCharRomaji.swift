import Foundation

/**
 * Tests a character. Returns true if the character is Romaji.
 * - Parameter char: Character string to test
 * - Returns: Boolean indicating if the character is Romaji
 */
func isCharRomaji(_ char: String = "") -> Bool {
    if char.isEmpty { return false }
    return ROMAJI_RANGES.contains { range in
        isCharInRange(char, start: range[0], end: range[1])
    }
}
