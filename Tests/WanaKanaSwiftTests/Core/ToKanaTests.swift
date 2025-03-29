import Testing
@testable import WanaKanaSwift

@Suite("ToKanaTests")
final class ToKanaTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(WanaKanaSwift.toKana() == "")
        #expect(WanaKanaSwift.toKana("") == "")
    }

    @Test("Lowercase characters are transliterated to hiragana") func lowercaseToHiragana() async throws {
        #expect(WanaKanaSwift.toKana("onaji") == "おなじ")
    }

    @Test("Lowercase with double consonants and double vowels") func lowercaseWithDoubles() async throws {
        #expect(WanaKanaSwift.toKana("buttsuuji") == "ぶっつうじ")
    }

    @Test("Uppercase characters are transliterated to katakana") func uppercaseToKatakana() async throws {
        #expect(WanaKanaSwift.toKana("ONAJI") == "オナジ")
    }

    @Test("Uppercase with double consonants and double vowels") func uppercaseWithDoubles() async throws {
        #expect(WanaKanaSwift.toKana("BUTTSUUJI") == "ブッツウジ")
    }

    @Test("Mixed case returns hiragana") func mixedCase() async throws {
        #expect(WanaKanaSwift.toKana("WaniKani") == "わにかに")
    }

    @Test("Converts Ryukyuan constructions") func ryukyuanConstructions() async throws {
        #expect(WanaKanaSwift.toKana("kwi kuxi kuli kwe kuxe kule kwo kuxo kulo") == "くぃ くぃ くぃ くぇ くぇ くぇ くぉ くぉ くぉ")
    }

    @Test("Non-romaji will be passed through") func nonRomajiPassthrough() async throws {
        #expect(WanaKanaSwift.toKana("ワニカニ AiUeO 鰐蟹 12345 @#$%") == "ワニカニ アいウえオ 鰐蟹 12345 @#$%")
    }

    @Test("It handles mixed syllabaries") func mixedSyllabaries() async throws {
        #expect(WanaKanaSwift.toKana("座禅‘zazen’スタイル") == "座禅「ざぜん」スタイル")
    }

    @Test("Will convert short to long dashes") func shortToLongDashes() async throws {
        #expect(WanaKanaSwift.toKana("batsuge-mu") == "ばつげーむ")
    }

    @Test("Without IME Mode - solo n's") func withoutIMEModeSoloN() async throws {
        #expect(WanaKanaSwift.toKana("n") == "ん")
        #expect(WanaKanaSwift.toKana("shin") == "しん")
    }

    @Test("Without IME Mode - double n's") func withoutIMEModeDoubleN() async throws {
        #expect(WanaKanaSwift.toKana("nn") == "んん")
    }

    @Test("With IME Mode - solo n's") func withIMEModeSoloN() async throws {
        #expect(WanaKanaSwift.toKana("n", options: ["IMEMode": true]) == "n")
        #expect(WanaKanaSwift.toKana("shin", options: ["IMEMode": true]) == "しn")
        #expect(WanaKanaSwift.toKana("shinyou", options: ["IMEMode": true]) == "しにょう")
        #expect(WanaKanaSwift.toKana("shin'you", options: ["IMEMode": true]) == "しんよう")
        #expect(WanaKanaSwift.toKana("shin you", options: ["IMEMode": true]) == "しんよう")
    }

    @Test("With IME Mode - double n's") func withIMEModeDoubleN() async throws {
        #expect(WanaKanaSwift.toKana("nn", options: ["IMEMode": true]) == "ん")
    }

    @Test("useObsoleteKana is false by default") func useObsoleteKanaDefault() async throws {
        #expect(WanaKanaSwift.toKana("wi") == "うぃ")
        #expect(WanaKanaSwift.toKana("WI") == "ウィ")
    }

    @Test("wi = ゐ when useObsoleteKana is true") func useObsoleteKanaWi() async throws {
        #expect(WanaKanaSwift.toKana("wi", options: ["useObsoleteKana": true]) == "ゐ")
    }

    @Test("we = ゑ when useObsoleteKana is true") func useObsoleteKanaWe() async throws {
        #expect(WanaKanaSwift.toKana("we", options: ["useObsoleteKana": true]) == "ゑ")
    }

    @Test("WI = ヰ when useObsoleteKana is true") func useObsoleteKanaWiUpper() async throws {
        #expect(WanaKanaSwift.toKana("WI", options: ["useObsoleteKana": true]) == "ヰ")
    }

    @Test("WE = ヱ when useObsoleteKana is true") func useObsoleteKanaWeUpper() async throws {
        #expect(WanaKanaSwift.toKana("WE", options: ["useObsoleteKana": true]) == "ヱ")
    }
}

@Suite("SplitIntoConvertedKanaTests")
final class SplitIntoConvertedKanaTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(areTupleArraysEqual(splitIntoConvertedKana(), []));
        #expect(areTupleArraysEqual(splitIntoConvertedKana(""), []));
    }

    @Test("Lowercase characters are transliterated to hiragana") func lowercaseToHiragana() async throws {
        #expect(areTupleArraysEqual(splitIntoConvertedKana("onaji"), [
            (0, 1, "お"),
            (1, 3, "な"),
            (3, 5, "じ")
        ]))
    }

    @Test("Lowercase with double consonants and double vowels") func lowercaseWithDoubles() async throws {
        #expect(areTupleArraysEqual(splitIntoConvertedKana("buttsuuji"), [
            (0, 2, "ぶ"),
            (2, 6, "っつ"),
            (6, 7, "う"),
            (7, 9, "じ")
        ]))
    }

    @Test("Non-romaji will be passed through") func nonRomajiPassthrough() async throws {
        #expect(areTupleArraysEqual(splitIntoConvertedKana("ワニカニ AiUeO 鰐蟹 12345 @#$%"), [
            (0, 1, "ワ"), (1, 2, "ニ"), (2, 3, "カ"), (3, 4, "ニ"),
            (4, 5, " "),
            (5, 6, "あ"), (6, 7, "い"), (7, 8, "う"), (8, 9, "え"), (9, 10, "お"),
            (10, 11, " "),
            (11, 12, "鰐"), (12, 13, "蟹"),
            (13, 14, " "),
            (14, 15, "1"), (15, 16, "2"), (16, 17, "3"), (17, 18, "4"), (18, 19, "5"),
            (19, 20, " "),
            (20, 21, "@"), (21, 22, "#"), (22, 23, "$"), (23, 24, "%")
        ]))
    }

    @Test("It handles mixed syllabaries") func mixedSyllabaries() async throws {
        #expect(areTupleArraysEqual(splitIntoConvertedKana("座禅‘zazen’スタイル"), [
            (0, 1, "座"), (1, 2, "禅"),
            (2, 3, "「"),
            (3, 5, "ざ"), (5, 7, "ぜ"), (7, 8, "ん"),
            (8, 9, "」"),
            (9, 10, "ス"), (10, 11, "タ"), (11, 12, "イ"), (12, 13, "ル")
        ]))
    }

    @Test("Will convert short to long dashes") func shortToLongDashes() async throws {
        #expect(areTupleArraysEqual(splitIntoConvertedKana("batsuge-mu"), [
            (0, 2, "ば"),
            (2, 5, "つ"),
            (5, 7, "げ"),
            (7, 8, "ー"),
            (8, 10, "む")
        ]))
    }
}
