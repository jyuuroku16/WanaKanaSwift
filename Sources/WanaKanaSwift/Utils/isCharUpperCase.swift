import Foundation

func isCharUpperCase(_ char: Character) -> Bool {
    isCharInRange(char, start: LATIN_UPPERCASE_START, end: LATIN_UPPERCASE_END)
}

/**
 * Tests if char is in English unicode uppercase range
 */
func isCharUpperCase(_ char: String = "") -> Bool {
    guard !char.isEmpty, let first = char.first else { return false }
    return isCharUpperCase(first)
}
