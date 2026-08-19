import Foundation

/**
 * Convert input to Katakana
 */
func _toKatakana(_ input: String = "", options: Options = Options()) -> String {
    if options.passRomaji {
        return hiraganaToKatakana(input)
    }

    if _isMixed(input) || _isRomaji(input) || isCharEnglishPunctuation(input) {
        let hiragana = _toKana(input.lowercased(), options: options)
        return hiraganaToKatakana(hiragana)
    }

    return hiraganaToKatakana(input)
}

func _toKatakana(_ input: String, options: [String: Any]) -> String {
    _toKatakana(input, options: Options(dictionary: options))
}
