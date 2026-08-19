import Foundation

private let vowelsWithY: Set<Character> = Set("aeiouy")
private let vowelsWithoutY: Set<Character> = Set("aeiou")

func isCharVowel(_ char: Character, includeY: Bool = true) -> Bool {
    guard let lowered = char.lowercased().first else { return false }
    return (includeY ? vowelsWithY : vowelsWithoutY).contains(lowered)
}

/**
 * Tests a character and an english vowel. Returns true if the char is a vowel.
 */
func isCharVowel(_ char: String = "", includeY: Bool = true) -> Bool {
    guard char.count == 1, let first = char.first else { return false }
    return isCharVowel(first, includeY: includeY)
}
