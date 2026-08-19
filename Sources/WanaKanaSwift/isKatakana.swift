import Foundation

/**
 * Test if `input` is Katakana
 */
func _isKatakana(_ input: String = "") -> Bool {
    !input.isEmpty && input.allSatisfy(isCharKatakana)
}
