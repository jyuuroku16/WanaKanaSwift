import Foundation

/**
 * Takes a character and a unicode range. Returns true if the char is in the range.
 * - Parameters:
 *   - char: Unicode character
 *   - start: Unicode start range
 *   - end: Unicode end range
 * - Returns: Boolean indicating if the character is in range
 */
func isCharInRange(_ char: String = "", start: Int, end: Int) -> Bool {
    if char.isEmpty { return false }
    guard let firstScalar = char.unicodeScalars.first else { return false }
    let code = Int(firstScalar.value)
    return start <= code && code <= end
}
