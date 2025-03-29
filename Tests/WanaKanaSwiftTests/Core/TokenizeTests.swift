import Testing
@testable import WanaKanaSwift

@Suite("TokenizeTests")
final class TokenizeTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(areTokenArraysEqual(WanaKanaSwift.tokenize(), []))
        #expect(areTokenArraysEqual(WanaKanaSwift.tokenize(""), []))
        #expect(getType() == .other)
        #expect(getType("") == .other)
    }

    @Test("basic tests") func basicTests() async throws {
        #expect(areTokenArraysEqual(WanaKanaSwift.tokenize("ふふ"), ["ふふ"]))
        #expect(areTokenArraysEqual(WanaKanaSwift.tokenize("フフ"), ["フフ"]))
        #expect(areTokenArraysEqual(WanaKanaSwift.tokenize("ふふフフ"), ["ふふ", "フフ"]))
        #expect(areTokenArraysEqual(WanaKanaSwift.tokenize("阮咸"), ["阮咸"]))
        #expect(areTokenArraysEqual(WanaKanaSwift.tokenize("人々"), ["人々"]))
        #expect(areTokenArraysEqual(WanaKanaSwift.tokenize("感じ"), ["感", "じ"]))
        #expect(areTokenArraysEqual(WanaKanaSwift.tokenize("私は悲しい"), ["私", "は", "悲", "しい"]))
        #expect(areTokenArraysEqual(WanaKanaSwift.tokenize("ok لنذهب!"), ["ok", " ", "لنذهب", "!"]))
    }

    @Test("handles mixed input") func mixedInput() async throws {
        #expect(areTokenArraysEqual(WanaKanaSwift.tokenize("5romaji here...!?人々漢字ひらがなカタ　カナ４「ＳＨＩＯ」。！"), [
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
        ]))
    }

    @Test("compact option") func compactOption() async throws {
        #expect(areTokenArraysEqual(WanaKanaSwift.tokenize("5romaji here...!?人々漢字ひらがなカタ　カナ４「ＳＨＩＯ」。！ لنذهب", options: ["compact": true]), [
            "5",
            "romaji here",
            "...!?",
            "人々漢字ひらがなカタ　カナ",
            "４「",
            "ＳＨＩＯ",
            "」。！",
            " ",
            "لنذهب"
        ]))
    }

    @Test("detailed option") func detailedOption() async throws {
        let result = WanaKanaSwift.tokenize("5romaji here...!?人々漢字ひらがなカタ　カナ４「ＳＨＩＯ」。！ لنذهب", options: ["detailed": true])
        #expect(areTokenArraysEqual(result, [
            Token(type: .enNum, value: "5"),
            Token(type: .en, value: "romaji"),
            Token(type: .space, value: " "),
            Token(type: .en, value: "here"),
            Token(type: .enPunc, value: "...!?"),
            Token(type: .kanji, value: "人々漢字"),
            Token(type: .hiragana, value: "ひらがな"),
            Token(type: .katakana, value: "カタ"),
            Token(type: .space, value: "　"),
            Token(type: .katakana, value: "カナ"),
            Token(type: .jaNum, value: "４"),
            Token(type: .jaPunc, value: "「"),
            Token(type: .ja, value: "ＳＨＩＯ"),
            Token(type: .jaPunc, value: "」。！"),
            Token(type: .space, value: " "),
            Token(type: .other, value: "لنذهب")
        ]))
    }

    @Test("compact and detailed options") func compactAndDetailedOptions() async throws {
        let result = WanaKanaSwift.tokenize("5romaji here...!?人々漢字ひらがなカタ　カナ４「ＳＨＩＯ」。！ لنذهب", options: ["compact": true, "detailed": true])
        #expect(areTokenArraysEqual(result, [
            Token(type: .other, value: "5"),
            Token(type: .en, value: "romaji here"),
            Token(type: .other, value: "...!?"),
            Token(type: .ja, value: "人々漢字ひらがなカタ　カナ"),
            Token(type: .other, value: "４「"),
            Token(type: .ja, value: "ＳＨＩＯ"),
            Token(type: .other, value: "」。！"),
            Token(type: .en, value: " "),
            Token(type: .other, value: "لنذهب")
        ]))
    }
}
