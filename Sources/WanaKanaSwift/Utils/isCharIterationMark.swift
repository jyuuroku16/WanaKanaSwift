import Foundation

/**
 * Returns true if char is '々'
 * - Parameter char: Character string to test
 * - Returns: Boolean indicating if the character is an iteration mark
 */
func isCharIterationMark(_ char: String = "") -> Bool {
    if char.isEmpty { return false }
    guard let firstScalar = char.unicodeScalars.first else { return false }
    return Int(firstScalar.value) == KANJI_ITERATION_MARK
}
