import Foundation

let LONG_VOWELS: [Character: Character] = [
    "a": "あ",
    "i": "い",
    "u": "う",
    "e": "え",
    "o": "う"
]

func isCharInitialLongDash(_ char: Character, index: Int) -> Bool {
    isCharLongDash(char) && index < 1
}

func isCharInnerLongDash(_ char: Character, index: Int) -> Bool {
    isCharLongDash(char) && index > 0
}

func isKanaAsSymbol(_ char: Character) -> Bool {
    char == "ヶ" || char == "ヵ"
}

/**
 * Convert Katakana to Hiragana
 */
func katakanaToHiragana(
    _ input: String = "",
    toRomaji: ((String) -> String)? = nil,
    config: Options = Options()
) -> String {
    let convertToRomaji = toRomaji ?? { _toRomaji($0) }
    var previousKana = ""
    var result = ""
    let characters = Array(input)

    for (index, char) in characters.enumerated() {
        if isCharSlashDot(char) || isCharInitialLongDash(char, index: index) || isKanaAsSymbol(char) {
            result.append(char)
            continue
        }

        if config.convertLongVowelMark && !previousKana.isEmpty && isCharInnerLongDash(char, index: index) {
            let romaji = convertToRomaji(previousKana)
            guard let vowel = romaji.last else { continue }

            if index > 0 && isCharKatakana(characters[index - 1]) && vowel == "o" && config.isDestinationRomaji {
                result.append("お")
            } else if let longVowel = LONG_VOWELS[vowel] {
                result.append(longVowel)
            }
            continue
        }

        if !isCharLongDash(char) && isCharKatakana(char), let scalar = unicodeScalar(char) {
            let code = Int(scalar.value) + (HIRAGANA_START - KATAKANA_START)
            if let unicode = UnicodeScalar(code) {
                let hiraChar = Character(unicode)
                previousKana = String(hiraChar)
                result.append(hiraChar)
                continue
            }
        }

        previousKana = ""
        result.append(char)
    }

    return result
}

func katakanaToHiragana(
    _ input: String = "",
    toRomaji: @escaping (String) -> String,
    config: [String: Any]
) -> String {
    katakanaToHiragana(input, toRomaji: toRomaji, config: Options(dictionary: config))
}
