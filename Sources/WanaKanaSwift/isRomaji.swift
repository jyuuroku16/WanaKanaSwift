import Foundation

/**
 * Test if `input` is Romaji (allowing Hepburn romanisation)
 * - Parameters:
 *   - input: Text to test
 *   - allowed: Additional regex pattern for allowed characters
 * - Returns: True if all characters are Romaji
 *
 * Example:
 * ```
 * isRomaji("Tōkyō and Ōsaka")
 * // => true
 * isRomaji("12a*b&c-d")
 * // => true
 * isRomaji("あアA")
 * // => false
 * isRomaji("お願い")
 * // => false
 * isRomaji("a！b&cーd") // Zenkaku punctuation fails
 * // => false
 * isRomaji("a！b&cーd", allowed: "^[！ー]$")
 * // => true
 * ```
 */
func _isRomaji(_ input: String = "", allowed: String? = nil) -> Bool {
    if input.isEmpty { return false }

    let regex: NSRegularExpression?
    if let pattern = allowed {
        regex = try? NSRegularExpression(pattern: pattern, options: [])
    } else {
        regex = nil
    }

    return Array(input).allSatisfy { char in
        let charString = String(char)
        let isRoma = isCharRomaji(charString)

        if let regex = regex {
            let range = NSRange(charString.startIndex..., in: charString)
            return isRoma || regex.firstMatch(in: charString, options: [], range: range) != nil
        }

        return isRoma
    }
}
