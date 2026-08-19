import Foundation

/**
 * Test if `input` is Hiragana
 */
func _isHiragana(_ input: String = "") -> Bool {
    !input.isEmpty && input.allSatisfy(isCharHiragana)
}
