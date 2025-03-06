import Foundation

/**
 * Convert input to Katakana
 * - Parameters:
 *   - input: Text to convert
 *   - options: Configuration options
 * - Returns: Converted text
 *
 * Example:
 * ```
 * toKatakana("toukyou, おおさか")
 * // => "トウキョウ、　オオサカ"
 * toKatakana("only かな", options: ["passRomaji": true])
 * // => "only カナ"
 * toKatakana("wi")
 * // => "ウィ"
 * toKatakana("wi", options: ["useObsoleteKana": true])
 * // => "ヰ"
 * ```
 */
func toKatakana(_ input: String = "", options: [String: Any] = [:]) -> String {
    let mergedOptions = mergeWithDefaultOptions(options)

    if mergedOptions["passRomaji"] as? Bool == true {
        return hiraganaToKatakana(input)
    }

    if isMixed(input) || isRomaji(input) || isCharEnglishPunctuation(input) {
        let hiragana = toKana(input.lowercased(), config: mergedOptions)
        return hiraganaToKatakana(hiragana)
    }

    return hiraganaToKatakana(input)
}
