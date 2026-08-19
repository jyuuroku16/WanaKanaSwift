import Foundation

/**
 * Convert input to Hiragana
 */
func _toHiragana(_ input: String = "", options: Options = Options()) -> String {
    if options.passRomaji {
        return katakanaToHiragana(input, config: options)
    }

    if _isMixed(input, options: Options(passKanji: true)) {
        let convertedKatakana = katakanaToHiragana(input, config: options)
        return _toKana(convertedKatakana.lowercased(), options: options)
    }

    if _isRomaji(input) || isCharEnglishPunctuation(input) {
        return _toKana(input.lowercased(), options: options)
    }

    return katakanaToHiragana(input, config: options)
}

func _toHiragana(_ input: String, options: [String: Any]) -> String {
    _toHiragana(input, options: Options(dictionary: options))
}
