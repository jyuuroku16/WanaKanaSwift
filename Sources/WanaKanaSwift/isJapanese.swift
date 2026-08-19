import Foundation

/**
 * Test if `input` only includes Kanji, Kana, zenkaku numbers, and JA punctuation/symbols.
 */
func _isJapanese(_ input: String = "", allowed: String? = nil) -> Bool {
    guard !input.isEmpty else { return false }

    let allowedChars: Set<Character>?
    if let allowed {
        allowedChars = Set(allowed)
    } else {
        allowedChars = nil
    }

    return input.allSatisfy { char in
        isCharJapanese(char) || (allowedChars?.contains(char) ?? false)
    }
}
