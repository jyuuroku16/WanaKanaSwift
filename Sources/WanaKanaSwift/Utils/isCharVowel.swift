import Foundation

/**
 * Tests a character and an english vowel. Returns true if the char is a vowel.
 * - Parameters:
 *   - char: Character to test
 *   - includeY: Optional parameter to include y as a vowel in test
 * - Returns: True if character is a vowel
 */
func isCharVowel(_ char: String = "", includeY: Bool = true) -> Bool {
    if char.isEmpty { return false }
    let pattern = includeY ? "^[aeiouy]$" : "^[aeiou]$"
    let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
    let range = NSRange(char.startIndex..., in: char)
    return regex?.firstMatch(in: char, options: [], range: range) != nil
}
