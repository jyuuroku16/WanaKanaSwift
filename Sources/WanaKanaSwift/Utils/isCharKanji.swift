import Foundation

// Unicode ranges for Kanji characters
let KANJI_START: Int = 0x4e00
let KANJI_END: Int = 0x9faf

/**
 * Tests a character. Returns true if the character is a CJK ideograph (kanji).
 * - Parameter char: Character string to test
 * - Returns: Boolean indicating if the character is Kanji
 */
func isCharKanji(_ char: String = "") -> Bool {
    return isCharInRange(char, start: KANJI_START, end: KANJI_END) || isCharIterationMark(char)
}
