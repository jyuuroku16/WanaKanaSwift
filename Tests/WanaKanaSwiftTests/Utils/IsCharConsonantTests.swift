import Testing
@testable import WanaKanaSwift

@Suite("IsCharConsonantTests")
final class IsCharConsonantTests {
    @Test("sane default") func saneDefault() async throws {
        #expect(isCharConsonant() == false)
    }

    @Test("passes parameter tests") func parameterTests() async throws {
        let consonants = ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z"]
        for consonant in consonants {
            #expect(isCharConsonant(consonant) == true)
        }

        #expect(isCharConsonant("y", includeY: false) == false)
        #expect(isCharConsonant("a") == false)
        #expect(isCharConsonant("!") == false)
        #expect(isCharConsonant("") == false)
    }
}
