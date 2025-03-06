import Foundation

// Unicode for the kana middle dot '・'
let KANA_SLASH_DOT: Int = 0x30fb

/**
 * Tests if char is '・'
 * - Parameter char: Character string to test
 * - Returns: Boolean indicating if the character is a slash dot
 */
func isCharSlashDot(_ char: String = "") -> Bool {
    if char.isEmpty { return false }
    guard let firstScalar = char.unicodeScalars.first else { return false }
    return Int(firstScalar.value) == KANA_SLASH_DOT
}
