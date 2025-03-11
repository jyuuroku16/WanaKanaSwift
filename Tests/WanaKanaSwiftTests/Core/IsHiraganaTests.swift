import Testing
@testable import WanaKanaSwift

@Suite("IsHiraganaTests")
final class IsHiraganaTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(isHiragana(nil) == false)
        #expect(isHiragana("") == false)
    }

    @Test("あ is hiragana") func singleHiragana() async throws {
        #expect(isHiragana("あ") == true)
    }

    @Test("ああ is hiragana") func multipleHiragana() async throws {
        #expect(isHiragana("ああ") == true)
    }

    @Test("ア is not hiragana") func katakanaIsNotHiragana() async throws {
        #expect(isHiragana("ア") == false)
    }

    @Test("A is not hiragana") func romajiIsNotHiragana() async throws {
        #expect(isHiragana("A") == false)
    }

    @Test("あア is not hiragana") func mixedIsNotHiragana() async throws {
        #expect(isHiragana("あア") == false)
    }

    @Test("ignores long dash in hiragana") func ignoresLongDash() async throws {
        #expect(isHiragana("げーむ") == true)
    }
}
