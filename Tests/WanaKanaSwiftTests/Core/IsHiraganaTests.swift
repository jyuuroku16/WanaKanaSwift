import Testing
@testable import WanaKanaSwift

@Suite("IsHiraganaTests")
final class IsHiraganaTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(WanaKanaSwift.isHiragana() == false)
        #expect(WanaKanaSwift.isHiragana("") == false)
    }

    @Test("あ is hiragana") func singleHiragana() async throws {
        #expect(WanaKanaSwift.isHiragana("あ") == true)
    }

    @Test("ああ is hiragana") func multipleHiragana() async throws {
        #expect(WanaKanaSwift.isHiragana("ああ") == true)
    }

    @Test("ア is not hiragana") func katakanaIsNotHiragana() async throws {
        #expect(WanaKanaSwift.isHiragana("ア") == false)
    }

    @Test("A is not hiragana") func romajiIsNotHiragana() async throws {
        #expect(WanaKanaSwift.isHiragana("A") == false)
    }

    @Test("あア is not hiragana") func mixedIsNotHiragana() async throws {
        #expect(WanaKanaSwift.isHiragana("あア") == false)
    }

    @Test("ignores long dash in hiragana") func ignoresLongDash() async throws {
        #expect(WanaKanaSwift.isHiragana("げーむ") == true)
    }
}
