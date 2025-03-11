import Testing
@testable import WanaKanaSwift

@Suite("IsKanaTests")
final class IsKanaTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(isKana(nil) == false)
        #expect(isKana("") == false)
    }

    @Test("あ is kana") func hiraganaIsKana() async throws {
        #expect(isKana("あ") == true)
    }

    @Test("ア is kana") func katakanaIsKana() async throws {
        #expect(isKana("ア") == true)
    }

    @Test("あア is kana") func mixedKanaIsKana() async throws {
        #expect(isKana("あア") == true)
    }

    @Test("A is not kana") func romajiIsNotKana() async throws {
        #expect(isKana("A") == false)
    }

    @Test("あAア is not kana") func mixedWithRomajiIsNotKana() async throws {
        #expect(isKana("あAア") == false)
    }

    @Test("ignores long dash in mixed kana") func ignoresLongDash() async throws {
        #expect(isKana("アーあ") == true)
    }
}
