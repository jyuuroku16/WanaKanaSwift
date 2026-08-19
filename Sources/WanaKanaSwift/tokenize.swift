import Foundation

public enum TokenType: String, Equatable, Sendable {
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

func isCharEnSpace(_ char: Character) -> Bool { char == " " }
func isCharJaSpace(_ char: Character) -> Bool { char == "　" }
func isCharJaNum(_ char: Character) -> Bool { ("０"..."９").contains(char) }
func isCharEnNum(_ char: Character) -> Bool { char.isASCII && char.isNumber }

func isCharEnSpace(_ char: String) -> Bool {
    char.count == 1 && char.first.map(isCharEnSpace) == true
}

func isCharJaSpace(_ char: String) -> Bool {
    char.count == 1 && char.first.map(isCharJaSpace) == true
}

func isCharJaNum(_ char: String) -> Bool {
    char.count == 1 && char.first.map(isCharJaNum) == true
}

func isCharEnNum(_ char: String) -> Bool {
    char.count == 1 && char.first.map(isCharEnNum) == true
}

func getType(_ input: Character, compact: Bool = false) -> TokenType {
    if compact {
        if isCharJaNum(input) || isCharEnNum(input) { return .other }
        if isCharEnSpace(input) { return .en }
        if isCharEnglishPunctuation(input) { return .other }
        if isCharJaSpace(input) { return .ja }
        if isCharJapanesePunctuation(input) { return .other }
        if isCharJapanese(input) { return .ja }
        if isCharRomaji(input) { return .en }
        return .other
    }

    if isCharJaSpace(input) || isCharEnSpace(input) { return .space }
    if isCharJaNum(input) { return .jaNum }
    if isCharEnNum(input) { return .enNum }
    if isCharEnglishPunctuation(input) { return .enPunc }
    if isCharJapanesePunctuation(input) { return .jaPunc }
    if isCharKanji(input) { return .kanji }
    if isCharHiragana(input) { return .hiragana }
    if isCharKatakana(input) { return .katakana }
    if isCharJapanese(input) { return .ja }
    if isCharRomaji(input) { return .en }
    return .other
}

func getType(_ input: String = "", compact: Bool = false) -> TokenType {
    guard let first = input.first else { return .other }
    return getType(first, compact: compact)
}

public struct Token: Equatable, Sendable {
    public let type: TokenType
    public let value: String

    public init(type: TokenType, value: String) {
        self.type = type
        self.value = value
    }
}

/**
 * Splits input into array of strings separated by token types
 */
func tokenizeValues(_ input: String, compact: Bool) -> [String] {
    guard !input.isEmpty else { return [] }

    var result: [String] = []
    var currentType: TokenType?
    var currentValue = ""

    for char in input {
        let type = getType(char, compact: compact)
        if type == currentType {
            currentValue.append(char)
            continue
        }
        if currentType != nil {
            result.append(currentValue)
        }
        currentType = type
        currentValue = String(char)
    }

    if currentType != nil {
        result.append(currentValue)
    }
    return result
}

func tokenizeDetails(_ input: String, compact: Bool) -> [Token] {
    guard !input.isEmpty else { return [] }

    var result: [Token] = []
    var currentType: TokenType?
    var currentValue = ""

    for char in input {
        let type = getType(char, compact: compact)
        if type == currentType {
            currentValue.append(char)
            continue
        }
        if let currentType {
            result.append(Token(type: currentType, value: currentValue))
        }
        currentType = type
        currentValue = String(char)
    }

    if let currentType {
        result.append(Token(type: currentType, value: currentValue))
    }
    return result
}

func _tokenize(_ input: String = "", options: TokenizeOptions = TokenizeOptions()) -> [Any] {
    if options.detailed {
        return tokenizeDetails(input, compact: options.compact)
    }
    return tokenizeValues(input, compact: options.compact)
}

func _tokenize(_ input: String, options: [String: Bool]) -> [Any] {
    _tokenize(input, options: TokenizeOptions(dictionary: options))
}
