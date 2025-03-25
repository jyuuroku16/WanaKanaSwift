import Foundation

/**
 * Creates a kana to romaji mapping tree
 * - Parameters:
 *   - romanization: Romanization type
 *   - customRomajiMapping: Custom mapping overrides
 * - Returns: Mapping dictionary
 */
func createKanaToRomajiMap(
    romanization: String,
    customRomajiMapping: [String: String]? = nil
) -> [String: Any]? {
    // Create new mapping
    var map = getKanaToRomajiTree(romanization: romanization)
    
    if let customMapping = customRomajiMapping {
        map = mergeCustomMapping(map, customMapping)
    }
    
    return map
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
func _toRomaji(
    _ input: String = "",
    options: [String: Any] = [:],
    map: [String: Any]? = nil
) -> String {
    let config = mergeWithDefaultOptions(options)
    var romajiMap: [String: Any]?

    romajiMap = map
    if romajiMap == nil {
        romajiMap = createKanaToRomajiMap(
            romanization: config["romanization"] as? String ?? "",
            customRomajiMapping: config["customRomajiMapping"] as? [String: String]
        )
    }
    
    return splitIntoRomaji(input, options: config, map: romajiMap ?? [:])
        .map { (start, end, romaji) in
            let slice = String(input[input.index(input.startIndex, offsetBy: start)..<input.index(input.startIndex, offsetBy: end)])
            let makeUpperCase = (config["upcaseKatakana"] as? Bool ?? false) && _isKatakana(slice)
            return makeUpperCase ? romaji.uppercased() : romaji
        }
        .joined()
}

/**
 * Split input into romaji tokens
 */
private func splitIntoRomaji(
    _ input: String,
    options: [String: Any],
    map: [String: Any]
) -> [(Int, Int, String)] {
    var config = options
    config["isDestinationRomaji"] = true
    let wrappedToRomaji: (String) -> String = { input in
        _toRomaji(input, options: [:], map: nil)
    }
    
    let mapping = applyMapping(
        katakanaToHiragana(input, toRomaji: wrappedToRomaji, config: config),
        map: map,
        optimize: !(options["IMEMode"] as? Bool ?? false)
    ) as! [(Int, Int, String)]
    return mapping
}
