public func isRomaji(_ input: String = "", allowed: String? = nil) -> Bool {
    _isRomaji(input, allowed: allowed)
}

public func isJapanese(_ input: String = "", allowed: String? = nil) -> Bool {
    _isJapanese(input, allowed: allowed)
}

public func isKana(_ input: String = "") -> Bool {
    _isKana(input)
}

public func isHiragana(_ input: String = "") -> Bool {
    _isHiragana(input)
}

public func isKatakana(_ input: String = "") -> Bool {
    _isKatakana(input)
}

public func isMixed(_ input: String = "", options: Options = Options()) -> Bool {
    _isMixed(input, options: options)
}

public func isMixed(_ input: String, options: [String: Any]) -> Bool {
    _isMixed(input, options: Options(dictionary: options))
}

public func isKanji(_ input: String = "") -> Bool {
    _isKanji(input)
}

public func toRomaji(_ input: String = "", options: Options = Options(), map: [String: Any]? = nil) -> String {
    _toRomaji(input, options: options, map: map)
}

public func toRomaji(_ input: String, options: [String: Any], map: [String: Any]? = nil) -> String {
    _toRomaji(input, options: Options(dictionary: options), map: map)
}

public func toKana(_ input: String = "", options: Options = Options(), map: [String: Any]? = nil) -> String {
    _toKana(input, options: options, map: map)
}

public func toKana(_ input: String, options: [String: Any], map: [String: Any]? = nil) -> String {
    _toKana(input, options: Options(dictionary: options), map: map)
}

public func toHiragana(_ input: String = "", options: Options = Options()) -> String {
    _toHiragana(input, options: options)
}

public func toHiragana(_ input: String, options: [String: Any]) -> String {
    _toHiragana(input, options: Options(dictionary: options))
}

public func toKatakana(_ input: String = "", options: Options = Options()) -> String {
    _toKatakana(input, options: options)
}

public func toKatakana(_ input: String, options: [String: Any]) -> String {
    _toKatakana(input, options: Options(dictionary: options))
}

public func stripOkurigana(_ input: String = "", options: Options = Options()) -> String {
    _stripOkurigana(input, options: options)
}

public func stripOkurigana(_ input: String, options: [String: Any]) -> String {
    _stripOkurigana(input, options: Options(dictionary: options))
}

public func tokenize(_ input: String = "", options: TokenizeOptions = TokenizeOptions()) -> [Any] {
    _tokenize(input, options: options)
}

public func tokenize(_ input: String, options: [String: Bool]) -> [Any] {
    _tokenize(input, options: TokenizeOptions(dictionary: options))
}

/// Typed convenience for compact/default tokenization.
public func tokens(_ input: String, compact: Bool = false) -> [String] {
    tokenizeValues(input, compact: compact)
}

/// Typed convenience for detailed tokenization.
public func detailedTokens(_ input: String, compact: Bool = false) -> [Token] {
    tokenizeDetails(input, compact: compact)
}
