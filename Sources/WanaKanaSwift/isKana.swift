import Foundation

/**
 * Test if `input` is Kana (Katakana and/or Hiragana)
 * - Parameter input: text to test
 * - Returns: true if all Kana
 * Example:
 *   isKana("あ")     // => true
 *   isKana("ア")     // => true
 *   isKana("あーア") // => true
 *   isKana("A")      // => false
 *   isKana("あAア")  // => false
 */
func isKana(_ input: String = "") -> Bool {
    if isEmpty(input) { return false }
    return input.map { String($0) }.allSatisfy { isCharKana($0) }
}
