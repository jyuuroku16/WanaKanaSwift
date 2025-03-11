import Testing
@testable import WanaKanaSwift

@Suite("IsCharHiraganaTests")
final class IsCharHiraganaTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(isCharHiragana() == false)
        #expect(isCharHiragana("") == false)
    }

    @Test("passes parameter tests") func parameterTests() async throws {
        #expect(isCharHiragana("な") == true)
        #expect(isCharHiragana("ナ") == false)
        #expect(isCharHiragana("n") == false)
        #expect(isCharHiragana("!") == false)
    }
}
