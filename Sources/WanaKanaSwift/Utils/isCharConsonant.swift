import Foundation

/**
 * Tests a character and an english consonant. Returns true if the char is a consonant.
 * - Parameters:
 *   - char: Character to test
 *   - includeY: Optional parameter to include y as a consonant in test
 * - Returns: True if character is a consonant
 */
func isCharConsonant(_ char: String = "", includeY: Bool = true) -> Bool {
    if char.isEmpty { return false }
    let pattern = includeY ? "^[bcdfghjklmnpqrstvwxyz]$" : "^[bcdfghjklmnpqrstvwxz]$"
    let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
    let range = NSRange(char.startIndex..., in: char)
    return regex?.firstMatch(in: char, options: [], range: range) != nil
}
