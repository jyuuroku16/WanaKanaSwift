import Foundation

// Cache for romaji to kana mapping
private let queue = DispatchQueue(label: "com.wanakana.cache")
nonisolated(unsafe) private var romajiToKanaMapCache: [String: [String: String]] = [:]
nonisolated(unsafe) private var lastIMEMode: Bool?
nonisolated(unsafe) private var lastUseObsoleteKana: Bool?
nonisolated(unsafe) private var lastCustomMapping: [String: String]?

/**
 * Creates a romaji to kana mapping tree
 * - Parameters:
 *   - IMEMode: Whether to use IME mode
 *   - useObsoleteKana: Whether to use obsolete kana
 *   - customKanaMapping: Custom mapping overrides
 * - Returns: Mapping dictionary
 */
func createRomajiToKanaMap(
    IMEMode: Bool,
    useObsoleteKana: Bool,
    customKanaMapping: [String: String]? = nil
) -> [String: String] {
    queue.sync {
        // Check cache first
        let cacheKey = "\(IMEMode)_\(useObsoleteKana)"
        if IMEMode == lastIMEMode &&
        useObsoleteKana == lastUseObsoleteKana &&
        customKanaMapping == lastCustomMapping,
        let cached = romajiToKanaMapCache[cacheKey] {
            return cached
        }

        // Create new mapping
        var map = getRomajiToKanaTree()

        if IMEMode {
            map = IME_MODE_MAP(map)
        }
        if useObsoleteKana {
            map = USE_OBSOLETE_KANA_MAP(map)
        }

        if let customMapping = customKanaMapping {
            map = mergeCustomMapping(map, customMapping)
        }

        // Update cache
        lastIMEMode = IMEMode
        lastUseObsoleteKana = useObsoleteKana
        lastCustomMapping = customKanaMapping
        romajiToKanaMapCache[cacheKey] = map as? [String: String]

        return map as! [String: String]
    }
}

/**
 * Convert Romaji to Kana
 * - Parameters:
 *   - input: Text to convert
 *   - options: Configuration options
 *   - map: Optional custom mapping
 * - Returns: Converted text
 *
 * Example:
 * ```
 * toKana("onaji BUTTSUUJI")
 * // => "おなじ ブッツウジ"
 * toKana("ONAJI buttsuuji")
 * // => "オナジ ぶっつうじ"
 * toKana("座禅'zazen'スタイル")
 * // => "座禅「ざぜん」スタイル"
 * toKana("batsuge-mu")
 * // => "ばつげーむ"
 * toKana("!?.:/,~-''""[]()){}")
 * // => "！？。：・、〜ー「」『』［］（）｛｝"
 * toKana("we", options: ["useObsoleteKana": true])
 * // => "ゑ"
 * toKana("wanakana", options: ["customKanaMapping": ["na": "に", "ka": "bana"]])
 * // => "わにbanaに"
 * ```
 */
func _toKana(
    _ input: String = "",
    options: [String: Any] = [:],
    map: [String: String]? = nil
) -> String {
    let config: [String: Any]
    let kanaMap: [String: String]

    if let customMap = map {
        config = options
        kanaMap = customMap
    } else {
        config = mergeWithDefaultOptions(options)
        kanaMap = createRomajiToKanaMap(
            IMEMode: config["IMEMode"] as? Bool ?? false,
            useObsoleteKana: config["useObsoleteKana"] as? Bool ?? false,
            customKanaMapping: config["customKanaMapping"] as? [String: String]
        )
    }

    return splitIntoConvertedKana(input, options: config, map: kanaMap)
        .map { (start, end, kana) in
            if kana == nil {
                // Haven't converted the end of the string, since we are in IME mode
                let startIndex = input.index(input.startIndex, offsetBy: start)
                return String(input[startIndex...])
            }

            let enforceHiragana = config["IMEMode"] as? String == TO_KANA_METHODS.HIRAGANA
            let enforceKatakana = config["IMEMode"] as? String == TO_KANA_METHODS.KATAKANA ||
                Array(input[input.index(input.startIndex, offsetBy: start)..<input.index(input.startIndex, offsetBy: end)])
                    .allSatisfy { isCharUpperCase(String($0)) }

            return enforceHiragana || !enforceKatakana
                ? kana!
                : hiraganaToKatakana(kana!)
        }
        .joined()
}

/**
 * Split input into converted kana tokens
 * - Parameters:
 *   - input: Text to convert
 *   - options: Configuration options
 *   - map: Optional custom mapping
 * - Returns: Array of tokens with start, end, and kana
 */
func splitIntoConvertedKana(
    _ input: String = "",
    options: [String: Any] = [:],
    map: [String: String]? = nil
) -> [(Int, Int, String?)] {
    let IMEMode = options["IMEMode"] as? Bool ?? false
    let useObsoleteKana = options["useObsoleteKana"] as? Bool ?? false
    let customKanaMapping = options["customKanaMapping"] as? [String: String]

    let kanaMap: [String: String]
    if let customMap = map {
        kanaMap = customMap
    } else {
        kanaMap = createRomajiToKanaMap(
            IMEMode: IMEMode,
            useObsoleteKana: useObsoleteKana,
            customKanaMapping: customKanaMapping
        )
    }

    return applyMapping(input.lowercased(), map: kanaMap, optimize: !IMEMode)
}
