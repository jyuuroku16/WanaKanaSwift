import Foundation

private func isLeadingWithoutInitialKana(_ input: String, leading: Bool) -> Bool {
    guard leading, let first = input.first else { return leading }
    return !isCharKana(first)
}

private func isTrailingWithoutFinalKana(_ input: String, leading: Bool) -> Bool {
    guard !leading, let last = input.last else { return false }
    return !isCharKana(last)
}

private func isInvalidMatcher(_ input: String, matchKanji: String) -> Bool {
    (!matchKanji.isEmpty && !matchKanji.contains(where: isCharKanji))
        || (matchKanji.isEmpty && _isKana(input))
}

/**
 * Strips Okurigana
 */
func _stripOkurigana(_ input: String = "", options: Options = Options()) -> String {
    if !_isJapanese(input)
        || isLeadingWithoutInitialKana(input, leading: options.leading)
        || isTrailingWithoutFinalKana(input, leading: options.leading)
        || isInvalidMatcher(input, matchKanji: options.matchKanji) {
        return input
    }

    let chars = options.matchKanji.isEmpty ? input : options.matchKanji
    let tokens = _tokenize(chars).compactMap { $0 as? String }
    guard let token = options.leading ? tokens.first : tokens.last, !token.isEmpty else {
        return input
    }

    if options.leading {
        return input.hasPrefix(token) ? String(input.dropFirst(token.count)) : input
    }
    return input.hasSuffix(token) ? String(input.dropLast(token.count)) : input
}

func _stripOkurigana(_ input: String, options: [String: Any]) -> String {
    _stripOkurigana(input, options: Options(dictionary: options))
}
