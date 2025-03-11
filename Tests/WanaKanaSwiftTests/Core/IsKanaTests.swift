import Testing
@testable import WanaKanaSwift

@Suite("IsKanaTests")
final class IsKanaTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(WanaKana.isKana() == false)
        #expect(WanaKana.isKana("") == false)
    }

    @Test("あ is kana") func hiraganaIsKana() async throws {
        #expect(WanaKana.isKana("あ") == true)
    }

    @Test("ア is kana") func katakanaIsKana() async throws {
        #expect(WanaKana.isKana("ア") == true)
    }

    @Test("あア is kana") func mixedKanaIsKana() async throws {
        #expect(WanaKana.isKana("あア") == true)
    }

    @Test("A is not kana") func romajiIsNotKana() async throws {
        #expect(WanaKana.isKana("A") == false)
    }

    @Test("あAア is not kana") func mixedWithRomajiIsNotKana() async throws {
        #expect(WanaKana.isKana("あAア") == false)
    }

    @Test("ignores long dash in mixed kana") func ignoresLongDash() async throws {
        #expect(WanaKana.isKana("アーあ") == true)
    }
}
