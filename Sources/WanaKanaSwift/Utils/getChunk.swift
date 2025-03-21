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
    guard !text.isEmpty else { return "" }
    
    let safeStart = max(0, min(start, text.count))
    let safeEnd = min(end ?? text.count, text.count)
    
    guard safeStart < safeEnd else { return "" }
    
    let startIndex = text.index(text.startIndex, offsetBy: safeStart)
    let endIndex = text.index(text.startIndex, offsetBy: safeEnd)
    
    return String(text[startIndex..<endIndex])
}
