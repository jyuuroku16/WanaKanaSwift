import Testing
@testable import WanaKanaSwift

@Suite("IsCharKanjiTests")
final class IsCharKanjiTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(isCharKanji(nil) == false)
        #expect(isCharKanji("") == false)
    }

    @Test("passes parameter tests") func parameterTests() async throws {
        #expect(isCharKanji("腹") == true)
        #expect(isCharKanji("一") == true) // kanji for '-' (いち・1) not a long hyphen
        #expect(isCharKanji("ー") == false) // long hyphen
        #expect(isCharKanji("々") == true) // kanji for iteration (人々・ひとびと)
        #expect(isCharKanji("は") == false)
        #expect(isCharKanji("ナ") == false)
        #expect(isCharKanji("n") == false)
        #expect(isCharKanji("!") == false)
        #expect(isCharKanji("") == false)
    }
}
