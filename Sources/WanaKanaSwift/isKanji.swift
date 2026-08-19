import Foundation

/**
 * Tests if `input` is Kanji (Japanese CJK ideographs)
 */
func _isKanji(_ input: String = "") -> Bool {
    !input.isEmpty && input.allSatisfy(isCharKanji)
}
