import Foundation

/**
 * Limits picking chunk size to be no bigger than the remaining characters.
 * - Parameters:
 *   - max: Index limit
 *   - remaining: Remaining characters
 * - Returns: The minimum of max and remaining
 */
func getChunkSize(max: Int = 0, remaining: Int = 0) -> Int {
    return min(max, remaining)
}
