import Foundation

func createKanaToRomajiMap(
    romanization: String,
    customRomajiMapping: Any? = nil
) -> [String: Any]? {
    var map = getKanaToRomajiTree(romanization: romanization)

    if let customMapping = customRomajiMapping {
        map = mergeCustomMapping(map, customMapping)
    }

    return map
}

/**
 * Convert kana to romaji
 */
func _toRomaji(
    _ input: String = "",
    options: Options = Options(),
    map: [String: Any]? = nil
) -> String {
    let romajiMap = map ?? createKanaToRomajiMap(
        romanization: options.romanization,
        customRomajiMapping: options.customRomajiMapping
    ) ?? [:]

    return splitIntoRomaji(input, options: options, map: romajiMap)
        .map { start, end, romaji in
            let sliceStart = input.index(input.startIndex, offsetBy: start)
            let sliceEnd = input.index(input.startIndex, offsetBy: end)
            let slice = String(input[sliceStart..<sliceEnd])
            let makeUpperCase = options.upcaseKatakana && _isKatakana(slice)
            return makeUpperCase ? romaji.uppercased() : romaji
        }
        .joined()
}

func _toRomaji(
    _ input: String,
    options: [String: Any],
    map: [String: Any]? = nil
) -> String {
    _toRomaji(input, options: Options(dictionary: options), map: map)
}

private func splitIntoRomaji(
    _ input: String,
    options: Options,
    map: [String: Any]
) -> [(Int, Int, String)] {
    var config = options
    config.isDestinationRomaji = true
    let hiragana = katakanaToHiragana(input, config: config)
    return applyMapping(
        hiragana,
        map: map,
        optimize: !options.imeMode.isEnabled
    ).compactMap { start, end, value in
        guard let value else { return nil }
        return (start, end, value)
    }
}
