import Testing
@testable import WanaKanaSwift

@Suite("TokenizeTests")
final class TokenizeTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(WanaKana.tokenize() == [])
        #expect(WanaKana.tokenize("") == [])
        #expect(getType(nil) == "other")
        #expect(getType("") == "other")
    }

    @Test("basic tests") func basicTests() async throws {
        #expect(WanaKana.tokenize("ふふ") == ["ふふ"])
        #expect(WanaKana.tokenize("フフ") == ["フフ"])
        #expect(WanaKana.tokenize("ふふフフ") == ["ふふ", "フフ"])
        #expect(WanaKana.tokenize("阮咸") == ["阮咸"])
        #expect(WanaKana.tokenize("人々") == ["人々"])
        #expect(WanaKana.tokenize("感じ") == ["感", "じ"])
        #expect(WanaKana.tokenize("私は悲しい") == ["私", "は", "悲", "しい"])
        #expect(WanaKana.tokenize("ok لنذهب!") == ["ok", " ", "لنذهب", "!"])
    }

    @Test("handles mixed input") func mixedInput() async throws {
        #expect(WanaKana.tokenize("5romaji here...!?人々漢字ひらがなカタ　カナ４「ＳＨＩＯ」。！") == [
            "5",
            "romaji",
            " ",
            "here",
            "...!?",
            "人々漢字",
            "ひらがな",
            "カタ",
            "　",
            "カナ",
            "４",
            "「",
            "ＳＨＩＯ",
            "」。！"
        ])
    }

    @Test("compact option") func compactOption() async throws {
        #expect(WanaKana.tokenize("5romaji here...!?人々漢字ひらがなカタ　カナ４「ＳＨＩＯ」。！ لنذهب", options: TokenizeOptions(compact: true)) == [
            "5",
            "romaji here",
            "...!?",
            "人々漢字ひらがなカタ　カナ",
            "４「",
            "ＳＨＩＯ",
            "」。！",
            " ",
            "لنذهب"
        ])
    }

    @Test("detailed option") func detailedOption() async throws {
        let result = WanaKana.tokenize("5romaji here...!?人々漢字ひらがなカタ　カナ４「ＳＨＩＯ」。！ لنذهب", options: TokenizeOptions(detailed: true))
        #expect(result == [
            TokenDetail(type: "englishNumeral", value: "5"),
            TokenDetail(type: "en", value: "romaji"),
            TokenDetail(type: "space", value: " "),
            TokenDetail(type: "en", value: "here"),
            TokenDetail(type: "englishPunctuation", value: "...!?"),
            TokenDetail(type: "kanji", value: "人々漢字"),
            TokenDetail(type: "hiragana", value: "ひらがな"),
            TokenDetail(type: "katakana", value: "カタ"),
            TokenDetail(type: "space", value: "　"),
            TokenDetail(type: "katakana", value: "カナ"),
            TokenDetail(type: "japaneseNumeral", value: "４"),
            TokenDetail(type: "japanesePunctuation", value: "「"),
            TokenDetail(type: "ja", value: "ＳＨＩＯ"),
            TokenDetail(type: "japanesePunctuation", value: "」。！"),
            TokenDetail(type: "space", value: " "),
            TokenDetail(type: "other", value: "لنذهب")
        ])
    }

    @Test("compact and detailed options") func compactAndDetailedOptions() async throws {
        let result = WanaKana.tokenize("5romaji here...!?人々漢字ひらがなカタ　カナ４「ＳＨＩＯ」。！ لنذهب", options: TokenizeOptions(compact: true, detailed: true))
        #expect(result == [
            TokenDetail(type: "other", value: "5"),
            TokenDetail(type: "en", value: "romaji here"),
            TokenDetail(type: "other", value: "...!?"),
            TokenDetail(type: "ja", value: "人々漢字ひらがなカタ　カナ"),
            TokenDetail(type: "other", value: "４「"),
            TokenDetail(type: "ja", value: "ＳＨＩＯ"),
            TokenDetail(type: "other", value: "」。！"),
            TokenDetail(type: "en", value: " "),
            TokenDetail(type: "other", value: "لنذهب")
        ])
    }
}
