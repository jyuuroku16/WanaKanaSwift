import Testing
@testable import WanaKanaSwift

@Suite("IsKanjiTests")
final class IsKanjiTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(WanaKanaSwift.isKanji() == false)
        #expect(WanaKanaSwift.isKanji("") == false)
    }

    @Test("切腹 is kanji") func multipleKanji() async throws {
        #expect(WanaKanaSwift.isKanji("切腹") == true)
    }

    @Test("刀 is kanji") func singleKanji() async throws {
        #expect(WanaKanaSwift.isKanji("刀") == true)
    }

    @Test("人々 is kanji") func kanjiWithIterationMark() async throws {
        #expect(WanaKanaSwift.isKanji("人々") == true)
    }

    @Test("emoji are not kanji") func emojiIsNotKanji() async throws {
        #expect(WanaKanaSwift.isKanji("🐸") == false)
    }

    @Test("あ is not kanji") func hiraganaIsNotKanji() async throws {
        #expect(WanaKanaSwift.isKanji("あ") == false)
    }

    @Test("ア is not kanji") func katakanaIsNotKanji() async throws {
        #expect(WanaKanaSwift.isKanji("ア") == false)
    }

    @Test("あア is not kanji") func mixedKanaIsNotKanji() async throws {
        #expect(WanaKanaSwift.isKanji("あア") == false)
    }

    @Test("A is not kanji") func romajiIsNotKanji() async throws {
        #expect(WanaKanaSwift.isKanji("A") == false)
    }

    @Test("あAア is not kanji") func mixedIsNotKanji() async throws {
        #expect(WanaKanaSwift.isKanji("あAア") == false)
    }

    @Test("１２隻 is not kanji") func numbersAndKanjiIsNotKanji() async throws {
        #expect(WanaKanaSwift.isKanji("１２隻") == false)
    }

    @Test("12隻 is not kanji") func asciiNumbersAndKanjiIsNotKanji() async throws {
        #expect(WanaKanaSwift.isKanji("12隻") == false)
    }

    @Test("隻。 is not kanji") func kanjiAndPunctuationIsNotKanji() async throws {
        #expect(WanaKanaSwift.isKanji("隻。") == false)
    }
}
