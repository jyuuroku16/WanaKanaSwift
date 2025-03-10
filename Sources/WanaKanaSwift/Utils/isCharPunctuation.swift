import Foundation

/**
 * Tests a character. Returns true if the character is considered Japanese or English punctuation.
 * - Parameter char: character to test
 * - Returns: Boolean indicating if the character is punctuation
 */
func isCharPunctuation(_ char: String? = "") -> Bool {
    guard let char = char else { return false }
    return isCharEnglishPunctuation(char) || isCharJapanesePunctuation(char)
}
