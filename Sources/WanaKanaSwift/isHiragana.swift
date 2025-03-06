import Foundation

/**
 * Test if `input` is Hiragana
 * - Parameter input: Text to test
 * - Returns: True if all characters are Hiragana
 *
 * Example:
 * ```
 * isHiragana("げーむ")
 * // => true
 * isHiragana("A")
 * // => false
 * isHiragana("あア")
 * // => false
 * ```
 */
func isHiragana(_ input: String = "") -> Bool {
    if input.isEmpty { return false }
    return Array(input).allSatisfy { isCharHiragana(String($0)) }
}
