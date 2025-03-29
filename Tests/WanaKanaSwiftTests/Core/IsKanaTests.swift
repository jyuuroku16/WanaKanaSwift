import Testing
@testable import WanaKanaSwift

@Suite("IsKanaTests")
final class IsKanaTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(WanaKanaSwift.isKana() == false)
        #expect(WanaKanaSwift.isKana("") == false)
    }

    @Test("あ is kana") func hiraganaIsKana() async throws {
        #expect(WanaKanaSwift.isKana("あ") == true)
    }

    @Test("ア is kana") func katakanaIsKana() async throws {
        #expect(WanaKanaSwift.isKana("ア") == true)
    }

    @Test("あア is kana") func mixedKanaIsKana() async throws {
        #expect(WanaKanaSwift.isKana("あア") == true)
    }

    @Test("A is not kana") func romajiIsNotKana() async throws {
        #expect(WanaKanaSwift.isKana("A") == false)
    }

    @Test("あAア is not kana") func mixedWithRomajiIsNotKana() async throws {
        #expect(WanaKanaSwift.isKana("あAア") == false)
    }

    @Test("ignores long dash in mixed kana") func ignoresLongDash() async throws {
        #expect(WanaKanaSwift.isKana("アーあ") == true)
    }
}
