public func isRomaji(_ input: String = "", allowed: String? = nil) -> Bool {
    return _isRomaji(input, allowed: allowed)
}

public func isJapanese(_ input: String = "", allowed: String? = nil) -> Bool {
    return _isJapanese(input, allowed: allowed)
}

public func isKana(_ input: String = "") -> Bool {
    return _isKana(input)
}

public func isHiragana(_ input: String = "") -> Bool {
    return _isHiragana(input)
}

public func isKatakana(_ input: String = "") -> Bool {
    return _isKatakana(input)
}

public func isMixed(_ input: String = "", options: [String: Any] = ["passKanji": true]) -> Bool {
    return _isMixed(input, options: options)
}

public func isKanji(_ input: String = "") -> Bool {
    return _isKanji(input)
}

// Conversion functions
public func toRomaji(_ input: String = "", options: [String: Any] = [:], map: [String: String]? = nil) -> String {
    return _toRomaji(input, options: options, map: map)
}

public func toKana(_ input: String = "", options: [String: Any] = [:], map: [String: String]? = nil) -> String {
    return _toKana(input, options: options, map: map)
}

public func toHiragana(_ input: String = "", options: [String: Any] = [:]) -> String {
    return _toHiragana(input, options: options)
}

public func toKatakana(_ input: String = "", options: [String: Any] = [:]) -> String {
    return _toKatakana(input, options: options)
}

public func stripOkurigana(_ input: String = "", options: [String: Any] = [:]) -> String {
    return _stripOkurigana(input, options: options)
}

public func tokenize(_ input: String = "", options: [String: Bool] = [:]) -> [Any] {
    return _tokenize(input, options: options)
}
