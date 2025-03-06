import Foundation

// Romaji Unicode ranges
let ROMAJI_RANGES: [(Int, Int)] = [
    // Modern English
    (0x0000, 0x007f),
    // Hepburn macron ranges
    (0x0100, 0x0101), // Ā ā
    (0x0112, 0x0113), // Ē ē
    (0x012a, 0x012b), // Ī ī
    (0x014c, 0x014d), // Ō ō
    (0x016a, 0x016b)  // Ū ū
]

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
