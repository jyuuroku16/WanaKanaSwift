import Foundation

// Helper functions
private func isLeadingWithoutInitialKana(_ input: String, leading: Bool) -> Bool {
    return leading && !_isKana(String(input.first ?? Character("")))
}

private func isTrailingWithoutFinalKana(_ input: String, leading: Bool) -> Bool {
    return !leading && !_isKana(String(input.last ?? Character("")))
}

private func isInvalidMatcher(_ input: String, matchKanji: String) -> Bool {
    return (
        (!matchKanji.isEmpty && !Array(matchKanji).contains { _isKanji(String($0)) }) ||
        (matchKanji.isEmpty && _isKana(input))
    )
}

/**
 * Strips Okurigana
 * - Parameters:
 *   - input: Text to process
 *   - options: Configuration options
 * - Returns: Text with okurigana removed
 *
 * Example:
 * ```
 * stripOkurigana("踏み込む")
 * // => "踏み込"
 * stripOkurigana("お祝い")
 * // => "お祝"
 * stripOkurigana("お腹", options: ["leading": true])
 * // => "腹"
 * stripOkurigana("ふみこむ", options: ["matchKanji": "踏み込む"])
 * // => "ふみこ"
 * stripOkurigana("おみまい", options: ["matchKanji": "お祝い", "leading": true])
 * // => "みまい"
 * ```
 */
func _stripOkurigana(_ input: String = "", options: [String: Any] = [:]) -> String {
    let leading = options["leading"] as? Bool ?? false
    let matchKanji = options["matchKanji"] as? String ?? ""

    if !_isJapanese(input) ||
       isLeadingWithoutInitialKana(input, leading: leading) ||
       isTrailingWithoutFinalKana(input, leading: leading) ||
       isInvalidMatcher(input, matchKanji: matchKanji) {
        return input
    }

    let chars = matchKanji.isEmpty ? input : matchKanji
    let tokens = _tokenize(chars) as? [String] ?? []

    let pattern: String
    if leading {
        guard let firstToken = tokens.first else { return input }
        pattern = "^\(firstToken)"
    } else {
        guard let lastToken = tokens.last else { return input }
        pattern = "\(lastToken)$"
    }

    guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
        return input
    }

    let range = NSRange(input.startIndex..., in: input)
    return regex.stringByReplacingMatches(in: input, options: [], range: range, withTemplate: "")
}
