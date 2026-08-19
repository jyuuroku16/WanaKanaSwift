import Foundation

func isCharSlashDot(_ char: Character) -> Bool {
    unicodeCodePoint(char) == KANA_SLASH_DOT
}

/**
 * Tests if char is '・'
 */
func isCharSlashDot(_ char: String = "") -> Bool {
    guard !char.isEmpty, let first = char.first else { return false }
    return isCharSlashDot(first)
}
