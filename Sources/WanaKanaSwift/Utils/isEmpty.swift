import Foundation

/**
 * Checks if input string is empty
 * - Parameter input: Text input
 * - Returns: True if no input
 */
func isEmpty(_ input: Any?) -> Bool {
    guard let str = input as? String else {
        return true
    }
    return str.isEmpty
}
