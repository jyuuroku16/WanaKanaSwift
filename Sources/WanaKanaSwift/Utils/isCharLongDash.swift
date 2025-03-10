import Foundation

/**
 * Returns true if char is 'ー'
 * - Parameter char: Character string to test
 * - Returns: Boolean indicating if the character is a long dash
 */
func isCharLongDash(_ char: String = "") -> Bool {
    if char.isEmpty { return false }
    guard let firstScalar = char.unicodeScalars.first else { return false }
    return Int(firstScalar.value) == PROLONGED_SOUND_MARK
}
