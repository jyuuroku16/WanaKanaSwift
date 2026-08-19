import Foundation

/**
 * Test if `input` contains a mix of Romaji and Kana, defaults to pass through Kanji
 */
func _isMixed(_ input: String = "", options: Options = Options()) -> Bool {
    var hasKanji = false
    var hasHiragana = false
    var hasKatakana = false
    var hasRomaji = false

    for char in input {
        if !options.passKanji && isCharKanji(char) {
            hasKanji = true
        }
        if isCharHiragana(char) { hasHiragana = true }
        if isCharKatakana(char) { hasKatakana = true }
        if isCharRomaji(char) { hasRomaji = true }
        if (hasHiragana || hasKatakana) && hasRomaji && !hasKanji {
            return true
        }
    }

    return (hasHiragana || hasKatakana) && hasRomaji && !hasKanji
}

func _isMixed(_ input: String, options: [String: Any]) -> Bool {
    _isMixed(input, options: Options(dictionary: options))
}
