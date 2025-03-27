import Testing
@testable import WanaKanaSwift

@Suite("ToKanaTests")
final class ToKanaTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(WanaKana.toKana() == "")
        #expect(WanaKana.toKana("") == "")
    }

    @Test("Lowercase characters are transliterated to hiragana") func lowercaseToHiragana() async throws {
        #expect(WanaKana.toKana("onaji") == "おなじ")
    }

    @Test("Lowercase with double consonants and double vowels") func lowercaseWithDoubles() async throws {
        #expect(WanaKana.toKana("buttsuuji") == "ぶっつうじ")
    }

    @Test("Uppercase characters are transliterated to katakana") func uppercaseToKatakana() async throws {
        #expect(WanaKana.toKana("ONAJI") == "オナジ")
    }

    @Test("Uppercase with double consonants and double vowels") func uppercaseWithDoubles() async throws {
        #expect(WanaKana.toKana("BUTTSUUJI") == "ブッツウジ")
    }

    @Test("Mixed case returns hiragana") func mixedCase() async throws {
        #expect(WanaKana.toKana("WaniKani") == "わにかに")
    }

    @Test("Converts Ryukyuan constructions") func ryukyuanConstructions() async throws {
        #expect(WanaKana.toKana("kwi kuxi kuli kwe kuxe kule kwo kuxo kulo") == "くぃ くぃ くぃ くぇ くぇ くぇ くぉ くぉ くぉ")
    }

    @Test("Non-romaji will be passed through") func nonRomajiPassthrough() async throws {
        #expect(WanaKana.toKana("ワニカニ AiUeO 鰐蟹 12345 @#$%") == "ワニカニ アいウえオ 鰐蟹 12345 @#$%")
    }

    @Test("It handles mixed syllabaries") func mixedSyllabaries() async throws {
        #expect(WanaKana.toKana("座禅'zazen'スタイル") == "座禅「ざぜん」スタイル")
    }

    @Test("Will convert short to long dashes") func shortToLongDashes() async throws {
        #expect(WanaKana.toKana("batsuge-mu") == "ばつげーむ")
    }

    @Test("Without IME Mode - solo n's") func withoutIMEModeSoloN() async throws {
        #expect(WanaKana.toKana("n") == "ん")
        #expect(WanaKana.toKana("shin") == "しん")
    }

    @Test("Without IME Mode - double n's") func withoutIMEModeDoubleN() async throws {
        #expect(WanaKana.toKana("nn") == "んん")
    }

    @Test("With IME Mode - solo n's") func withIMEModeSoloN() async throws {
        #expect(WanaKana.toKana("n", options: ["IMEMode": true]) == "n")
        #expect(WanaKana.toKana("shin", options: ["IMEMode": true]) == "しn")
        #expect(WanaKana.toKana("shinyou", options: ["IMEMode": true]) == "しにょう")
        #expect(WanaKana.toKana("shin'you", options: ["IMEMode": true]) == "しんよう")
        #expect(WanaKana.toKana("shin you", options: ["IMEMode": true]) == "しんよう")
    }

    @Test("With IME Mode - double n's") func withIMEModeDoubleN() async throws {
        #expect(WanaKana.toKana("nn", options: ["IMEMode": true]) == "ん")
    }

    @Test("useObsoleteKana is false by default") func useObsoleteKanaDefault() async throws {
        #expect(WanaKana.toKana("wi") == "うぃ")
        #expect(WanaKana.toKana("WI") == "ウィ")
    }

    @Test("wi = ゐ when useObsoleteKana is true") func useObsoleteKanaWi() async throws {
        #expect(WanaKana.toKana("wi", options: ["useObsoleteKana": true]) == "ゐ")
    }

    @Test("we = ゑ when useObsoleteKana is true") func useObsoleteKanaWe() async throws {
        #expect(WanaKana.toKana("we", options: ["useObsoleteKana": true]) == "ゑ")
    }

    @Test("WI = ヰ when useObsoleteKana is true") func useObsoleteKanaWiUpper() async throws {
        #expect(WanaKana.toKana("WI", options: ["useObsoleteKana": true]) == "ヰ")
    }

    @Test("WE = ヱ when useObsoleteKana is true") func useObsoleteKanaWeUpper() async throws {
        #expect(WanaKana.toKana("WE", options: ["useObsoleteKana": true]) == "ヱ")
    }
}

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
        #expect(areTupleArraysEqual(splitIntoConvertedKana("座禅'zazen'スタイル"), [
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
