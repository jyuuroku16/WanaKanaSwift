import Testing
@testable import WanaKanaSwift

@Suite("IsJapaneseTests")
final class IsJapaneseTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(WanaKana.isJapanese() == false)
        #expect(WanaKana.isJapanese("") == false)
    }

    @Test("泣き虫 is japanese") func kanjiAndHiragana() async throws {
        #expect(WanaKana.isJapanese("泣き虫") == true)
    }

    @Test("あア is japanese") func mixedKana() async throws {
        #expect(WanaKana.isJapanese("あア") == true)
    }

    @Test("A泣き虫 is not japanese") func romajiAndJapanese() async throws {
        #expect(WanaKana.isJapanese("A泣き虫") == false)
    }

    @Test("A is not japanese") func romaji() async throws {
        #expect(WanaKana.isJapanese("A") == false)
    }

    @Test("ja space is japanese") func japaneseSpace() async throws {
        #expect(WanaKana.isJapanese("　") == true)
    }

    @Test("en space is not japanese") func englishSpace() async throws {
        #expect(WanaKana.isJapanese(" ") == false)
    }

    @Test("泣き虫。！〜 (w. zenkaku punctuation) is japanese") func japanesePunctuation() async throws {
        #expect(WanaKana.isJapanese("泣き虫。＃！〜〈〉《》〔〕［］【】（）｛｝〝〟") == true)
    }

    @Test("泣き虫.!~ (w. romaji punctuation) is not japanese") func romajiPunctuation() async throws {
        #expect(WanaKana.isJapanese("泣き虫.!~") == false)
    }

    @Test("zenkaku numbers are considered neutral") func zenkakuNumbers() async throws {
        #expect(WanaKana.isJapanese("０１２３４５６７８９") == true)
    }

    @Test("latin numbers are not japanese") func latinNumbers() async throws {
        #expect(WanaKana.isJapanese("0123456789") == false)
    }

    @Test("zenkaku latin letters are considered neutral") func zenkakuLetters() async throws {
        #expect(WanaKana.isJapanese("ＭｅＴｏｏ") == true)
    }

    @Test("mixed with numbers is japanese") func mixedWithNumbers() async throws {
        #expect(WanaKana.isJapanese("２０１１年") == true)
    }

    @Test("hankaku katakana is allowed") func hankakuKatakana() async throws {
        #expect(WanaKana.isJapanese("ﾊﾝｶｸｶﾀｶﾅ") == true)
    }

    @Test("accepts optional allowed chars") func acceptsAllowedChars() async throws {
        #expect(WanaKana.isJapanese("≪偽括弧≫", allowed: "≪≫") == true)
    }
}
