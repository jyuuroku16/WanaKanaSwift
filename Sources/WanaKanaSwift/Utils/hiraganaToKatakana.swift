import Foundation

/**
 * Convert Hiragana to Katakana
 * Passes through any non-hiragana chars
 * - Parameter input: Text input
 * - Returns: Converted text
 *
 * Example:
 * ```
 * hiraganaToKatakana("ひらがな")
 * // => "ヒラガナ"
 * hiraganaToKatakana("ひらがな is a type of kana")
 * // => "ヒラガナ is a type of kana"
 * ```
 */
func hiraganaToKatakana(_ input: String = "") -> String {
    let katakanaOffset = KATAKANA_START - HIRAGANA_START

    return String(input.map { char in
        let charString = String(char)
        // Short circuit to avoid incorrect codeshift for 'ー' and '・'
        if isCharLongDash(charString) || isCharSlashDot(charString) {
            return char
        } else if isCharHiragana(charString) {
            // Shift charcode
            guard let scalar = char.unicodeScalars.first else { return char }
            let code = Int(scalar.value) + katakanaOffset
            guard let unicode = UnicodeScalar(code) else { return char }
            return Character(unicode)
        } else {
            // Pass non-hiragana chars through
            return char
        }
    })
}
