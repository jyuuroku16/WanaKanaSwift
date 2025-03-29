import Testing
@testable import WanaKanaSwift

@Suite("IsMixedTests")
final class IsMixedTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(WanaKanaSwift.isMixed() == false)
        #expect(WanaKanaSwift.isMixed("") == false)
    }

    @Test("Aア is mixed") func romajiAndKatakana() async throws {
        #expect(WanaKanaSwift.isMixed("Aア") == true)
    }

    @Test("Aあ is mixed") func romajiAndHiragana() async throws {
        #expect(WanaKanaSwift.isMixed("Aあ") == true)
    }

    @Test("Aあア is mixed") func romajiAndBothKana() async throws {
        #expect(WanaKanaSwift.isMixed("Aあア") == true)
    }

    @Test("２あア is not mixed") func numbersAndKana() async throws {
        #expect(WanaKanaSwift.isMixed("２あア") == false)
    }

    @Test("お腹A is mixed") func kanjiKanaAndRomaji() async throws {
        #expect(WanaKanaSwift.isMixed("お腹A") == true)
    }

    @Test("お腹A is not mixed when passKanji is false") func respectsPassKanji() async throws {
        #expect(WanaKanaSwift.isMixed("お腹A", options: ["passKanji": false]) == false)
    }

    @Test("お腹 is not mixed") func kanjiAndKana() async throws {
        #expect(WanaKanaSwift.isMixed("お腹") == false)
    }

    @Test("腹 is not mixed") func singleKanji() async throws {
        #expect(WanaKanaSwift.isMixed("腹") == false)
    }

    @Test("A is not mixed") func singleRomaji() async throws {
        #expect(WanaKanaSwift.isMixed("A") == false)
    }

    @Test("あ is not mixed") func singleHiragana() async throws {
        #expect(WanaKanaSwift.isMixed("あ") == false)
    }

    @Test("ア is not mixed") func singleKatakana() async throws {
        #expect(WanaKanaSwift.isMixed("ア") == false)
    }
}
