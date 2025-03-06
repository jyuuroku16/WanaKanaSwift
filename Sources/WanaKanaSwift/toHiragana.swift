import Foundation

/**
 * Convert input to Hiragana
 * - Parameters:
 *   - input: Text to convert
 *   - options: Configuration options
 * - Returns: Converted text
 *
 * Example:
 * ```
 * toHiragana("toukyou, オオサカ")
 * // => "とうきょう、　おおさか"
 * toHiragana("only カナ", options: ["passRomaji": true])
 * // => "only かな"
 * toHiragana("wi")
 * // => "うぃ"
 * toHiragana("wi", options: ["useObsoleteKana": true])
 * // => "ゐ"
 * ```
 */
func toHiragana(_ input: String = "", options: [String: Any] = [:]) -> String {
    let config = mergeWithDefaultOptions(options)

    if config["passRomaji"] as? Bool == true {
        return katakanaToHiragana(input, toRomaji: toRomaji, config: config)
    }

    if isMixed(input, options: ["passKanji": true]) {
        let convertedKatakana = katakanaToHiragana(input, toRomaji: toRomaji, config: config)
        return toKana(convertedKatakana.lowercased(), config: config)
    }

    if isRomaji(input) || isCharEnglishPunctuation(input) {
        return toKana(input.lowercased(), config: config)
    }

    return katakanaToHiragana(input, toRomaji: toRomaji, config: config)
}
