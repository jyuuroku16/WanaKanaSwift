import Foundation

/**
 * Test if `input` is Kana (Katakana and/or Hiragana)
 */
func _isKana(_ input: String = "") -> Bool {
    !input.isEmpty && input.allSatisfy(isCharKana)
}
