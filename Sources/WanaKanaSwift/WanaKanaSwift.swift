public struct WanaKana {

    // Writing system checks
    public static func isRomaji(_ input: String = "", allowed: String? = nil) -> Bool {
        return _isRomaji(input, allowed: allowed)
    }

    public static func isJapanese(_ input: String = "", allowed: String? = nil) -> Bool {
        return _isJapanese(input, allowed: allowed)
    }

    public static func isKana(_ input: String = "") -> Bool {
        return _isKana(input)
    }

    public static func isHiragana(_ input: String = "") -> Bool {
        return _isHiragana(input)
    }

    public static func isKatakana(_ input: String = "") -> Bool {
        return _isKatakana(input)
    }

    public static func isMixed(_ input: String = "", options: [String: Any] = ["passKanji": true]) -> Bool {
        return _isMixed(input, options: options)
    }

    public static func isKanji(_ input: String = "") -> Bool {
        return _isKanji(input)
    }

    // Conversion functions
    @MainActor public static func toRomaji(_ input: String = "", options: [String: Any] = [:], map: [String: String]? = nil) -> String {
        return _toRomaji(input, options: options, map: map)
    }

    @MainActor public static func toKana(_ input: String = "", options: [String: Any] = [:], map: [String: String]? = nil) -> String {
        return _toKana(input, options: options, map: map)
    }

    @MainActor public static func toHiragana(_ input: String = "", options: [String: Any] = [:]) -> String {
        return _toHiragana(input, options: options)
    }

    @MainActor public static func toKatakana(_ input: String = "", options: [String: Any] = [:]) -> String {
        return _toKatakana(input, options: options)
    }

    // Other utils
    public static func stripOkurigana(_ input: String = "", options: [String: Any] = [:]) -> String {
        return _stripOkurigana(input, options: options)
    }

    @MainActor public static func tokenize(_ input: String = "", options: [String: Bool] = [:]) -> Any {
        return _tokenize(input, options: options)
    }
}
