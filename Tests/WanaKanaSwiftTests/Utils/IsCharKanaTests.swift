import Testing
@testable import WanaKanaSwift

@Suite("IsCharKanaTests")
final class IsCharKanaTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(isCharKana(nil) == false)
        #expect(isCharKana("") == false)
    }

    @Test("passes parameter tests") func parameterTests() async throws {
        #expect(isCharKana("は") == true)
        #expect(isCharKana("ナ") == true)
        #expect(isCharKana("n") == false)
        #expect(isCharKana("!") == false)
        #expect(isCharKana("-") == false)
        #expect(isCharKana("ー") == true)
    }
}
