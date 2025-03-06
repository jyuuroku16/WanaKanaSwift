import Foundation

/**
 * Test if `input` is Katakana
 * - Parameter input: Text to test
 * - Returns: True if all characters are Katakana
 *
 * Example:
 * ```
 * isKatakana("ゲーム")
 * // => true
 * isKatakana("あ")
 * // => false
 * isKatakana("A")
 * // => false
 * isKatakana("あア")
 * // => false
 * ```
 */
func isKatakana(_ input: String = "") -> Bool {
    if input.isEmpty { return false }
    return Array(input).allSatisfy { isCharKatakana(String($0)) }
}
