import Foundation

// Japanese Unicode ranges
let JAPANESE_RANGES: [(Int, Int)] = [
    // Hiragana
    (0x3040, 0x309f),
    // Katakana
    (0x30a0, 0x30ff),
    // Kana punctuation
    (0xff61, 0xff65),
    // Hankaku Katakana
    (0xff66, 0xff9f),
    // CJK Symbols and Punctuation
    (0x3000, 0x303f),
    // Zenkaku punctuation
    (0xff01, 0xff0f),
    (0xff1a, 0xff1f),
    (0xff3b, 0xff3f),
    (0xff5b, 0xff60),
    // Zenkaku symbols and currency
    (0xffe0, 0xffee),
    // Zenkaku Latin
    (0xff21, 0xff3a), // Uppercase
    (0xff41, 0xff5a), // Lowercase
    // Zenkaku numbers
    (0xff10, 0xff19),
    // Common CJK
    (0x4e00, 0x9fff),
    // Rare CJK
    (0x3400, 0x4dbf)
]

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
