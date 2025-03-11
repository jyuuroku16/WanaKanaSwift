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
@MainActor func _toHiragana(_ input: String = "", options: [String: Any] = [:]) -> String {
    let config = mergeWithDefaultOptions(options)
    
    if config["passRomaji"] as? Bool == true {
        let wrappedToRomaji: (String) -> String = { input in
            _toRomaji(input, options: config, map: nil)
        }
        return katakanaToHiragana(input, toRomaji: wrappedToRomaji, config: config)
    }
    
    if _isMixed(input, options: ["passKanji": true]) {
        let wrappedToRomaji: (String) -> String = { input in
            _toRomaji(input, options: config, map: nil)
        }
        let convertedKatakana = katakanaToHiragana(input, toRomaji: wrappedToRomaji, config: config)
        return _toKana(convertedKatakana.lowercased(), options: config)
    }
    
    if _isRomaji(input) || isCharEnglishPunctuation(input) {
        return _toKana(input.lowercased(), options: config)
    }
    
    let wrappedToRomaji: (String) -> String = { input in
        _toRomaji(input, options: config, map: nil)
    }
    return katakanaToHiragana(input, toRomaji: wrappedToRomaji, config: config)
}
