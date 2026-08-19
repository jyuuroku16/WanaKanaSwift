/// Controls incremental conversion while text is being typed.
public enum IMEMode: Equatable, Sendable {
    case off
    case on
    case toHiragana
    case toKatakana

    var isEnabled: Bool { self != .off }

    static func parse(_ value: Any?) -> IMEMode {
        switch value {
        case let enabled as Bool:
            return enabled ? .on : .off
        case let method as String where method == TO_KANA_METHODS.HIRAGANA:
            return .toHiragana
        case let method as String where method == TO_KANA_METHODS.KATAKANA:
            return .toKatakana
        default:
            return .off
        }
    }
}

/// Configuration for conversion and detection helpers.
public struct Options {
    public var useObsoleteKana: Bool
    public var passRomaji: Bool
    public var convertLongVowelMark: Bool
    public var upcaseKatakana: Bool
    public var imeMode: IMEMode
    public var romanization: String
    public var passKanji: Bool
    public var leading: Bool
    public var matchKanji: String
    var isDestinationRomaji: Bool

    /// Accepts `[String: String]` or the result of `createCustomMapping(_:)`.
    public var customKanaMapping: Any?
    /// Accepts `[String: String]` or the result of `createCustomMapping(_:)`.
    public var customRomajiMapping: Any?

    public init(
        useObsoleteKana: Bool = false,
        passRomaji: Bool = false,
        convertLongVowelMark: Bool = true,
        upcaseKatakana: Bool = false,
        imeMode: IMEMode = .off,
        romanization: String = ROMANIZATIONS.HEPBURN,
        customKanaMapping: [String: String]? = nil,
        customRomajiMapping: [String: String]? = nil,
        passKanji: Bool = true,
        leading: Bool = false,
        matchKanji: String = "",
        isDestinationRomaji: Bool = false
    ) {
        self.useObsoleteKana = useObsoleteKana
        self.passRomaji = passRomaji
        self.convertLongVowelMark = convertLongVowelMark
        self.upcaseKatakana = upcaseKatakana
        self.imeMode = imeMode
        self.romanization = romanization
        self.customKanaMapping = customKanaMapping
        self.customRomajiMapping = customRomajiMapping
        self.passKanji = passKanji
        self.leading = leading
        self.matchKanji = matchKanji
        self.isDestinationRomaji = isDestinationRomaji
    }

    init(dictionary: [String: Any]) {
        let merged = mergeWithDefaultOptions(dictionary)
        self.useObsoleteKana = merged["useObsoleteKana"] as? Bool ?? false
        self.passRomaji = merged["passRomaji"] as? Bool ?? false
        self.convertLongVowelMark = merged["convertLongVowelMark"] as? Bool ?? true
        self.upcaseKatakana = merged["upcaseKatakana"] as? Bool ?? false
        self.imeMode = IMEMode.parse(merged["IMEMode"])
        self.romanization = merged["romanization"] as? String ?? ROMANIZATIONS.HEPBURN
        self.customKanaMapping = merged["customKanaMapping"]
        self.customRomajiMapping = merged["customRomajiMapping"]
        self.passKanji = merged["passKanji"] as? Bool ?? true
        self.leading = merged["leading"] as? Bool ?? false
        self.matchKanji = merged["matchKanji"] as? String ?? ""
        self.isDestinationRomaji = merged["isDestinationRomaji"] as? Bool ?? false
    }
}

/// Configuration for `tokenize`.
public struct TokenizeOptions: Equatable, Sendable {
    public var compact: Bool
    public var detailed: Bool

    public init(compact: Bool = false, detailed: Bool = false) {
        self.compact = compact
        self.detailed = detailed
    }

    init(dictionary: [String: Bool]) {
        self.compact = dictionary["compact"] ?? false
        self.detailed = dictionary["detailed"] ?? false
    }
}
