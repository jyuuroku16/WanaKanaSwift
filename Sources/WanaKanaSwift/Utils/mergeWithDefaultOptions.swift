import Foundation

// Default options
let DEFAULT_OPTIONS: [String: Any] = [
    "useObsoleteKana": false,
    "passRomaji": false,
    "convertLongVowelMark": true,
    "upcaseKatakana": false,
    "IMEMode": false,
    "romanization": "hepburn"
]

/**
 * Easy re-use of merging with default options
 * - Parameter options: User options
 * - Returns: User options merged over default options
 */
func mergeWithDefaultOptions(_ options: [String: Any] = [:]) -> [String: Any] {
    var result = DEFAULT_OPTIONS
    for (key, value) in options {
        result[key] = value
    }
    return result
}
