import Testing
@testable import WanaKanaSwift

@Suite("IsCharKatakanaTests")
final class IsCharKatakanaTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(isCharKatakana(nil) == false)
        #expect(isCharKatakana("") == false)
    }

    @Test("passes parameter tests") func parameterTests() async throws {
        #expect(isCharKatakana("ナ") == true)
        #expect(isCharKatakana("は") == false)
        #expect(isCharKatakana("n") == false)
        #expect(isCharKatakana("!") == false)
    }
}
