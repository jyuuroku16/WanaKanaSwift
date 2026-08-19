import Foundation

private let consonantsWithY: Set<Character> = Set("bcdfghjklmnpqrstvwxyz")
private let consonantsWithoutY: Set<Character> = Set("bcdfghjklmnpqrstvwxz")

func isCharConsonant(_ char: Character, includeY: Bool = true) -> Bool {
    guard let lowered = char.lowercased().first else { return false }
    return (includeY ? consonantsWithY : consonantsWithoutY).contains(lowered)
}

/**
 * Tests a character and an english consonant. Returns true if the char is a consonant.
 */
func isCharConsonant(_ char: String = "", includeY: Bool = true) -> Bool {
    guard char.count == 1, let first = char.first else { return false }
    return isCharConsonant(first, includeY: includeY)
}
