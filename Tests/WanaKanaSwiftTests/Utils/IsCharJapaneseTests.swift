import Testing
@testable import WanaKanaSwift

@Suite("IsCharJapaneseTests")
final class IsCharJapaneseTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(isCharJapanese(nil) == false)
        #expect(isCharJapanese("") == false)
    }

    @Test("passes parameter tests") func parameterTests() async throws {
        #expect(isCharJapanese("１") == true)
        #expect(isCharJapanese("ナ") == true)
        #expect(isCharJapanese("は") == true)
        #expect(isCharJapanese("缶") == true)
        #expect(isCharJapanese("〜") == true)
        #expect(isCharJapanese("ｎ") == true)
        #expect(isCharJapanese("Ｋ") == true)
        #expect(isCharJapanese("1") == false)
        #expect(isCharJapanese("n") == false)
        #expect(isCharJapanese("K") == false)
        #expect(isCharJapanese("!") == false)
    }
}
