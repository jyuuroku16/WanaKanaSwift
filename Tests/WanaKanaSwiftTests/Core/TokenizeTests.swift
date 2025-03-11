import Testing
@testable import WanaKanaSwift

@Suite("TokenizeTests")
final class TokenizeTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(tokenize(nil) == [])
        #expect(tokenize("") == [])
        #expect(getType(nil) == "other")
        #expect(getType("") == "other")
    }

    @Test("basic tests") func basicTests() async throws {
        #expect(tokenize("ふふ") == ["ふふ"])
        #expect(tokenize("フフ") == ["フフ"])
        #expect(tokenize("ふふフフ") == ["ふふ", "フフ"])
        #expect(tokenize("阮咸") == ["阮咸"])
        #expect(tokenize("人々") == ["人々"])
        #expect(tokenize("感じ") == ["感", "じ"])
        #expect(tokenize("私は悲しい") == ["私", "は", "悲", "しい"])
        #expect(tokenize("ok لنذهب!") == ["ok", " ", "لنذهب", "!"])
    }

    @Test("handles mixed input") func mixedInput() async throws {
        #expect(tokenize("5romaji here...!?人々漢字ひらがなカタ　カナ４「ＳＨＩＯ」。！") == [
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
        #expect(tokenize("5romaji here...!?人々漢字ひらがなカタ　カナ４「ＳＨＩＯ」。！ لنذهب", options: TokenizeOptions(compact: true)) == [
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
        let result = tokenize("5romaji here...!?人々漢字ひらがなカタ　カナ４「ＳＨＩＯ」。！ لنذهب", options: TokenizeOptions(detailed: true))
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
        let result = tokenize("5romaji here...!?人々漢字ひらがなカタ　カナ４「ＳＨＩＯ」。！ لنذهب", options: TokenizeOptions(compact: true, detailed: true))
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
