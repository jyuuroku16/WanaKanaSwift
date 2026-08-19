import Foundation

func isCharKanji(_ char: Character) -> Bool {
    isCharInRange(char, start: KANJI_START, end: KANJI_END) || isCharIterationMark(char)
}

/**
 * Tests a character. Returns true if the character is a CJK ideograph (kanji).
 */
func isCharKanji(_ char: String = "") -> Bool {
    guard !char.isEmpty, let first = char.first else { return false }
    return isCharKanji(first)
}
