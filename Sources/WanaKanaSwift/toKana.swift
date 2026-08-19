import Foundation

func createRomajiToKanaMap(
    IMEMode: IMEMode,
    useObsoleteKana: Bool,
    customKanaMapping: Any? = nil
) -> [String: Any] {
    var map = getRomajiToKanaTree(imeMode: IMEMode, useObsoleteKana: useObsoleteKana)

    if let customMapping = customKanaMapping {
        map = mergeCustomMapping(map, customMapping)
    }

    return map
}

func createRomajiToKanaMap(
    IMEMode: Bool,
    useObsoleteKana: Bool,
    customKanaMapping: Any? = nil
) -> [String: Any] {
    createRomajiToKanaMap(
        IMEMode: IMEMode ? .on : .off,
        useObsoleteKana: useObsoleteKana,
        customKanaMapping: customKanaMapping
    )
}

/**
 * Convert Romaji to Kana
 */
func _toKana(
    _ input: String = "",
    options: Options = Options(),
    map: [String: Any]? = nil
) -> String {
    let kanaMap = map ?? createRomajiToKanaMap(
        IMEMode: options.imeMode,
        useObsoleteKana: options.useObsoleteKana,
        customKanaMapping: options.customKanaMapping
    )

    return splitIntoConvertedKana(input, options: options, map: kanaMap)
        .map { start, end, kana in
            guard let kana else {
                let startIndex = input.index(input.startIndex, offsetBy: start)
                return String(input[startIndex...])
            }

            let enforceHiragana = options.imeMode == .toHiragana
            let sliceStart = input.index(input.startIndex, offsetBy: start)
            let sliceEnd = input.index(input.startIndex, offsetBy: end)
            let enforceKatakana = options.imeMode == .toKatakana
                || input[sliceStart..<sliceEnd].allSatisfy(isCharUpperCase)

            return enforceHiragana || !enforceKatakana
                ? kana
                : hiraganaToKatakana(kana)
        }
        .joined()
}

func _toKana(
    _ input: String,
    options: [String: Any],
    map: [String: Any]? = nil
) -> String {
    _toKana(input, options: Options(dictionary: options), map: map)
}

func splitIntoConvertedKana(
    _ input: String = "",
    options: Options = Options(),
    map: [String: Any]? = nil
) -> [(Int, Int, String?)] {
    let kanaMap = map ?? createRomajiToKanaMap(
        IMEMode: options.imeMode,
        useObsoleteKana: options.useObsoleteKana,
        customKanaMapping: options.customKanaMapping
    )
    return applyMapping(input.lowercased(), map: kanaMap, optimize: !options.imeMode.isEnabled)
}

func splitIntoConvertedKana(
    _ input: String,
    options: [String: Any],
    map: [String: Any]? = nil
) -> [(Int, Int, String?)] {
    splitIntoConvertedKana(input, options: Options(dictionary: options), map: map)
}
