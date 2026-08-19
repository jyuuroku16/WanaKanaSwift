import Foundation

/**
 * Test if `input` is Romaji (allowing Hepburn romanisation)
 */
func _isRomaji(_ input: String = "", allowed: String? = nil) -> Bool {
    guard !input.isEmpty else { return false }

    let allowedRegex: NSRegularExpression?
    if let allowed {
        allowedRegex = try? NSRegularExpression(pattern: allowed)
    } else {
        allowedRegex = nil
    }

    return input.allSatisfy { char in
        if isCharRomaji(char) { return true }
        guard let allowedRegex else { return false }
        let charString = String(char)
        let range = NSRange(charString.startIndex..., in: charString)
        return allowedRegex.firstMatch(in: charString, range: range) != nil
    }
}
