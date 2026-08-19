import Foundation

/**
 * Convert Hiragana to Katakana
 * Passes through any non-hiragana chars
 */
func hiraganaToKatakana(_ input: String = "") -> String {
    let katakanaOffset = KATAKANA_START - HIRAGANA_START

    return String(input.map { char in
        if isCharLongDash(char) || isCharSlashDot(char) {
            return char
        }
        guard isCharHiragana(char), let scalar = unicodeScalar(char) else {
            return char
        }
        guard let shifted = UnicodeScalar(Int(scalar.value) + katakanaOffset) else {
            return char
        }
        return Character(shifted)
    })
}
