import Foundation

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
