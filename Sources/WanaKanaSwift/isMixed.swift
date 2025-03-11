import Foundation

/**
 * Test if `input` contains a mix of Romaji and Kana, defaults to pass through Kanji
 * - Parameters:
 *   - input: Text to test
 *   - options: Optional config to pass through kanji
 * - Returns: True if mixed
 *
 * Example:
 * ```
 * isMixed("Abあア")
 * // => true
 * isMixed("お腹A") // ignores kanji by default
 * // => true
 * isMixed("お腹A", options: ["passKanji": false])
 * // => false
 * isMixed("ab")
 * // => false
 * isMixed("あア")
 * // => false
 * ```
 */
func _isMixed(_ input: String = "", options: [String: Any] = ["passKanji": true]) -> Bool {
    let chars = Array(input).map { String($0) }
    var hasKanji = false

    if options["passKanji"] as? Bool == false {
        hasKanji = chars.contains { _isKanji($0) }
    }

    let hasHiragana = chars.contains { _isHiragana($0) }
    let hasKatakana = chars.contains { _isKatakana($0) }
    let hasRomaji = chars.contains { _isRomaji($0) }

    return (hasHiragana || hasKatakana) && hasRomaji && !hasKanji
}
