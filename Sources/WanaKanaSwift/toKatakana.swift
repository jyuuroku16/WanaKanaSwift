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
func _toKatakana(_ input: String = "", options: [String: Any] = [:]) -> String {
    let mergedOptions = mergeWithDefaultOptions(options)

    if mergedOptions["passRomaji"] as? Bool == true {
        return hiraganaToKatakana(input)
    }

    if _isMixed(input) || _isRomaji(input) || isCharEnglishPunctuation(input) {
        let hiragana = _toKana(input.lowercased(), options: mergedOptions)
        return hiraganaToKatakana(hiragana)
    }

    return hiraganaToKatakana(input)
}
