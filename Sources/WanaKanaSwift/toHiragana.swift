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
@MainActor func toHiragana(_ input: String = "", options: [String: Any] = [:]) -> String {
    let config = mergeWithDefaultOptions(options)
    
    if config["passRomaji"] as? Bool == true {
        let wrappedToRomaji: (String) -> String = { input in
            toRomaji(input, options: config, map: nil)
        }
        return katakanaToHiragana(input, toRomaji: wrappedToRomaji, config: config)
    }
    
    if isMixed(input, options: ["passKanji": true]) {
        let wrappedToRomaji: (String) -> String = { input in
            toRomaji(input, options: config, map: nil)
        }
        let convertedKatakana = katakanaToHiragana(input, toRomaji: wrappedToRomaji, config: config)
        return toKana(convertedKatakana.lowercased(), options: config)
    }
    
    if isRomaji(input) || isCharEnglishPunctuation(input) {
        return toKana(input.lowercased(), options: config)
    }
    
    let wrappedToRomaji: (String) -> String = { input in
        toRomaji(input, options: config, map: nil)
    }
    return katakanaToHiragana(input, toRomaji: wrappedToRomaji, config: config)
}
