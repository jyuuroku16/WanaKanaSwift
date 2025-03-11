import Foundation

// Token type definitions
enum TokenType: String {
    case en = "en"
    case ja = "ja"
    case enNum = "englishNumeral"
    case jaNum = "japaneseNumeral"
    case enPunc = "englishPunctuation"
    case jaPunc = "japanesePunctuation"
    case kanji = "kanji"
    case hiragana = "hiragana"
    case katakana = "katakana"
    case space = "space"
    case other = "other"
}

// Helper functions for character type checking
func isCharEnSpace(_ char: String) -> Bool {
    return char == " "
}

func isCharJaSpace(_ char: String) -> Bool {
    return char == "　"
}

func isCharJaNum(_ char: String) -> Bool {
    return char.range(of: "[０-９]", options: .regularExpression) != nil
}

func isCharEnNum(_ char: String) -> Bool {
    return char.range(of: "[0-9]", options: .regularExpression) != nil
}

/**
 * Get the type of a character
 * - Parameters:
 *   - input: Character to check
 *   - compact: Whether to use compact type checking
 * - Returns: Token type
 */
func getType(_ input: String, compact: Bool = false) -> TokenType {
    if compact {
        switch true {
        case isCharJaNum(input): return .other
        case isCharEnNum(input): return .other
        case isCharEnSpace(input): return .en
        case isCharEnglishPunctuation(input): return .other
        case isCharJaSpace(input): return .ja
        case isCharJapanesePunctuation(input): return .other
        case isCharJapanese(input): return .ja
        case isCharRomaji(input): return .en
        default: return .other
        }
    } else {
        switch true {
        case isCharJaSpace(input): return .space
        case isCharEnSpace(input): return .space
        case isCharJaNum(input): return .jaNum
        case isCharEnNum(input): return .enNum
        case isCharEnglishPunctuation(input): return .enPunc
        case isCharJapanesePunctuation(input): return .jaPunc
        case isCharKanji(input): return .kanji
        case isCharHiragana(input): return .hiragana
        case isCharKatakana(input): return .katakana
        case isCharJapanese(input): return .ja
        case isCharRomaji(input): return .en
        default: return .other
        }
    }
}

// Token structure for detailed output
struct Token {
    let type: TokenType
    let value: String
}

/**
 * Splits input into array of strings separated by token types
 * - Parameters:
 *   - input: Text to tokenize
 *   - options: Configuration options
 * - Returns: Array of tokens or detailed token objects
 *
 * Example:
 * ```
 * tokenize("ふふフフ")
 * // ["ふふ", "フフ"]
 *
 * tokenize("感じ")
 * // ["感", "じ"]
 *
 * tokenize("人々")
 * // ["人々"]
 *
 * tokenize("truly 私は悲しい")
 * // ["truly", " ", "私", "は", "悲", "しい"]
 *
 * tokenize("truly 私は悲しい", options: ["compact": true])
 * // ["truly ", "私は悲しい"]
 * ```
 */
func tokenize(_ input: String = "", options: [String: Bool] = [:]) -> Any {
    let compact = options["compact"] ?? false
    let detailed = options["detailed"] ?? false
    
    if input.isEmpty { return [] }
    
    let chars = Array(input).map { String($0) }
    guard let firstChar = chars.first else { return [] }
    var prevType = getType(firstChar, compact: compact)
    
    let initial: Any = detailed ? Token(type: prevType, value: firstChar) : firstChar
    var result: [Any] = [initial]
    
    for char in chars.dropFirst() {
        let currType = getType(char, compact: compact)
        let sameType = currType == prevType
        prevType = currType
        var newValue = char
        
        if sameType {
            if detailed {
                if let lastToken = result.popLast() as? Token {
                    newValue = lastToken.value + newValue
                }
            } else {
                if let lastValue = result.popLast() as? String {
                    newValue = lastValue + newValue
                }
            }
        }
        
        if detailed {
            result.append(Token(type: currType, value: newValue))
        } else {
            result.append(newValue)
        }
    }
    
    return result
}
