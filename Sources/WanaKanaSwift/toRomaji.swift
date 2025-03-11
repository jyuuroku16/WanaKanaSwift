import Foundation

// Cache for kana to romaji mapping
@MainActor private var kanaToRomajiMapCache: [String: [String: String]] = [:]
@MainActor private var lastRomanization: String?
@MainActor private var lastCustomMapping: [String: String]?

/**
 * Creates a kana to romaji mapping tree
 * - Parameters:
 *   - romanization: Romanization type
 *   - customRomajiMapping: Custom mapping overrides
 * - Returns: Mapping dictionary
 */
@MainActor func createKanaToRomajiMap(
    romanization: String,
    customRomajiMapping: [String: String]? = nil
) -> [String: String] {
    // Check cache first
    if romanization == lastRomanization &&
        customRomajiMapping == lastCustomMapping,
       let cached = kanaToRomajiMapCache[romanization] {
        return cached
    }
    
    // Create new mapping
    var map = getKanaToRomajiTree(romanization: romanization)
    
    if let customMapping = customRomajiMapping {
        map = mergeCustomMapping(map, customMapping)
    }
    
    // Update cache
    lastRomanization = romanization
    lastCustomMapping = customRomajiMapping
    kanaToRomajiMapCache[romanization] = map as? [String: String]
    
    return map as! [String: String]
}

/**
 * Convert kana to romaji
 * - Parameters:
 *   - input: Text input
 *   - options: Configuration options
 *   - map: Optional custom mapping
 * - Returns: Converted text
 *
 * Example:
 * ```
 * toRomaji("ひらがな　カタカナ")
 * // => "hiragana katakana"
 * toRomaji("げーむ　ゲーム")
 * // => "ge-mu geemu"
 * toRomaji("ひらがな　カタカナ", options: ["upcaseKatakana": true])
 * // => "hiragana KATAKANA"
 * toRomaji("つじぎり", options: ["customRomajiMapping": ["じ": "zi", "つ": "tu", "り": "li"]])
 * // => "tuzigili"
 * ```
 */
@MainActor func toRomaji(
    _ input: String = "",
    options: [String: Any] = [:],
    map: [String: String]? = nil
) -> String {
    let config = mergeWithDefaultOptions(options)
    
    let romajiMap: [String: String]
    if let customMap = map {
        romajiMap = customMap
    } else {
        romajiMap = createKanaToRomajiMap(
            romanization: config["romanization"] as? String ?? ROMANIZATIONS.HEPBURN,
            customRomajiMapping: config["customRomajiMapping"] as? [String: String]
        )
    }
    
    return splitIntoRomaji(input, options: config, map: romajiMap)
        .map { (start, end, romaji) in
            let slice = String(input[input.index(input.startIndex, offsetBy: start)..<input.index(input.startIndex, offsetBy: end)])
            let makeUpperCase = (config["upcaseKatakana"] as? Bool ?? false) && isKatakana(slice)
            return makeUpperCase ? romaji.uppercased() : romaji
        }
        .joined()
}

/**
 * Split input into romaji tokens
 */
@MainActor private func splitIntoRomaji(
    _ input: String,
    options: [String: Any],
    map: [String: String]
) -> [(Int, Int, String)] {
    var config = options
    config["isDestinationRomaji"] = true
    let wrappedToRomaji: (String) -> String = { input in
        toRomaji(input, options: config, map: nil)
    }
    
    return applyMapping(
        katakanaToHiragana(input, toRomaji: wrappedToRomaji, config: config),
        map: map,
        optimize: !(options["IMEMode"] as? Bool ?? false)
    ) as! [(Int, Int, String)]
}
