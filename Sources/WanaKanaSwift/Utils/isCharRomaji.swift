import Foundation

func isCharRomaji(_ char: Character) -> Bool {
    guard let code = unicodeCodePoint(char) else { return false }
    return isCode(code, inRanges: ROMAJI_RANGES)
}

/**
 * Tests a character. Returns true if the character is Romaji.
 */
func isCharRomaji(_ char: String = "") -> Bool {
    guard !char.isEmpty, let first = char.first else { return false }
    return isCharRomaji(first)
}
