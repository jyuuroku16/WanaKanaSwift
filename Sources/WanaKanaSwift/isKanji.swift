import Foundation

/**
 * Tests if `input` is Kanji (Japanese CJK ideographs)
 * - Parameter input: Text to test
 * - Returns: True if all characters are Kanji
 *
 * Example:
 * ```
 * isKanji("刀")
 * // => true
 * isKanji("切腹")
 * // => true
 * isKanji("勢い")
 * // => false
 * isKanji("あAア")
 * // => false
 * isKanji("🐸")
 * // => false
 * ```
 */
func _isKanji(_ input: String = "") -> Bool {
    if input.isEmpty { return false }
    return Array(input).allSatisfy { isCharKanji(String($0)) }
}
