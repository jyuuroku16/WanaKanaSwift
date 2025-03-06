import Foundation

/**
 * Returns a substring based on start/end values
 * - Parameters:
 *   - text: The input string
 *   - start: Starting index
 *   - end: Ending index (optional)
 * - Returns: A new substring
 */
func getChunk(_ text: String = "", start: Int = 0, end: Int? = nil) -> String {
    let startIndex = text.index(text.startIndex, offsetBy: max(0, start))
    let endIndex = end.map { text.index(text.startIndex, offsetBy: min($0, text.count)) } ?? text.endIndex
    return String(text[startIndex..<endIndex])
}
