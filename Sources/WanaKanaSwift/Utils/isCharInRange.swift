import Foundation

func isCharInRange(_ char: Character, start: Int, end: Int) -> Bool {
    guard let code = unicodeCodePoint(char) else { return false }
    return isCode(code, inRange: start, end)
}

/**
 * Takes a character and a unicode range. Returns true if the char is in the range.
 */
func isCharInRange(_ char: String = "", start: Int, end: Int) -> Bool {
    guard let first = char.first else { return false }
    return isCharInRange(first, start: start, end: end)
}
