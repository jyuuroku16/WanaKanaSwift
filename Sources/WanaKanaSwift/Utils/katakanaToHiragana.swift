import Foundation

// Long vowel mapping
let LONG_VOWELS: [String: String] = [
    "a": "あ",
    "i": "い",
    "u": "う",
    "e": "え",
    "o": "う"
]

// Helper functions
func isCharInitialLongDash(_ char: String, index: Int) -> Bool {
    return isCharLongDash(char) && index < 1
}

func isCharInnerLongDash(_ char: String, index: Int) -> Bool {
    return isCharLongDash(char) && index > 0
}

func isKanaAsSymbol(_ char: String) -> Bool {
    return ["ヶ", "ヵ"].contains(char)
}

/**
 * Convert Katakana to Hiragana
 * - Parameters:
 *   - input: Text to convert
 *   - toRomaji: Function to convert to romaji
 *   - options: Configuration options
 * - Returns: Converted text
 */
func katakanaToHiragana(
    _ input: String = "",
    toRomaji: (String) -> String,
    config: [String: Any] = [:]
) -> String {
    let isDestinationRomaji = config["isDestinationRomaji"] as? Bool ?? false
    let convertLongVowelMark = config["convertLongVowelMark"] as? Bool ?? true

    var previousKana = ""
    var result: [String] = []

    let characters = Array(input)
    for (index, char) in characters.enumerated() {
        let charString = String(char)

        // Short circuit to avoid incorrect codeshift for 'ー' and '・'
        if isCharSlashDot(charString) ||
           isCharInitialLongDash(charString, index: index) ||
           isKanaAsSymbol(charString) {
            result.append(charString)
            continue
        }

        // Transform long vowels: 'オー' to 'おう'
        if convertLongVowelMark &&
           !previousKana.isEmpty &&
           isCharInnerLongDash(charString, index: index) {
            // Transform previousKana back to romaji, and slice off the vowel
            let romaji = String(toRomaji(previousKana).suffix(1))
            // However, ensure 'オー' => 'おお' => 'oo' if this is a transform on the way to romaji
            if index > 0 &&
               isCharKatakana(String(characters[index - 1])) &&
               romaji == "o" &&
               isDestinationRomaji {
                result.append("お")
            } else if let longVowel = LONG_VOWELS[romaji] {
                result.append(longVowel)
            }
            continue
        }

        // Transform all other chars
        if !isCharLongDash(charString) && isCharKatakana(charString) {
            guard let scalar = char.unicodeScalars.first else {
                result.append(charString)
                continue
            }
            let code = Int(scalar.value) + (HIRAGANA_START - KATAKANA_START)
            guard let unicode = UnicodeScalar(code) else {
                result.append(charString)
                continue
            }
            let hiraChar = String(Character(unicode))
            previousKana = hiraChar
            result.append(hiraChar)
            continue
        }

        // Pass non katakana chars through
        previousKana = ""
        result.append(charString)
    }

    return result.joined()
}
