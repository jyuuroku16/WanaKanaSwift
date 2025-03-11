import Foundation

/**
 * Test if `input` only includes Kanji, Kana, zenkaku numbers, and JA punctuation/symbols.
 * - Parameters:
 *   - input: Text to test
 *   - allowed: Additional regex pattern for allowed characters
 * - Returns: True if all characters are Japanese
 *
 * Example:
 * ```
 * isJapanese("泣き虫")
 * // => true
 * isJapanese("あア")
 * // => true
 * isJapanese("２月") // Zenkaku numbers allowed
 * // => true
 * isJapanese("泣き虫。！〜＄") // Zenkaku/JA punctuation
 * // => true
 * isJapanese("泣き虫.!~$") // Latin punctuation fails
 * // => false
 * isJapanese("A泣き虫")
 * // => false
 * isJapanese("≪偽括弧≫", allowed: "^[≪≫]$")
 * // => true
 * ```
 */
func _isJapanese(_ input: String = "", allowed: String? = nil) -> Bool {
    if input.isEmpty { return false }

    let regex: NSRegularExpression?
    if let pattern = allowed {
        regex = try? NSRegularExpression(pattern: pattern, options: [])
    } else {
        regex = nil
    }

    return Array(input).allSatisfy { char in
        let charString = String(char)
        let isJa = isCharJapanese(charString)

        if let regex = regex {
            let range = NSRange(charString.startIndex..., in: charString)
            return isJa || regex.firstMatch(in: charString, options: [], range: range) != nil
        }

        return isJa
    }
}
