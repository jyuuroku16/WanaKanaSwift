import Foundation

func isCharLongDash(_ char: Character) -> Bool {
    unicodeCodePoint(char) == PROLONGED_SOUND_MARK
}

/**
 * Returns true if char is 'ー'
 */
func isCharLongDash(_ char: String = "") -> Bool {
    guard !char.isEmpty, let first = char.first else { return false }
    return isCharLongDash(first)
}
