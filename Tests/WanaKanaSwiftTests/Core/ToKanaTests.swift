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
        #expect(WanaKana.toKana("n", options: ToKanaOptions(IMEMode: true)) == "n")
        #expect(WanaKana.toKana("shin", options: ToKanaOptions(IMEMode: true)) == "しn")
        #expect(WanaKana.toKana("shinyou", options: ToKanaOptions(IMEMode: true)) == "しにょう")
        #expect(WanaKana.toKana("shin'you", options: ToKanaOptions(IMEMode: true)) == "しんよう")
        #expect(WanaKana.toKana("shin you", options: ToKanaOptions(IMEMode: true)) == "しんよう")
    }

    @Test("With IME Mode - double n's") func withIMEModeDoubleN() async throws {
        #expect(WanaKana.toKana("nn", options: ToKanaOptions(IMEMode: true)) == "ん")
    }

    @Test("useObsoleteKana is false by default") func useObsoleteKanaDefault() async throws {
        #expect(WanaKana.toKana("wi") == "うぃ")
        #expect(WanaKana.toKana("WI") == "ウィ")
    }

    @Test("wi = ゐ when useObsoleteKana is true") func useObsoleteKanaWi() async throws {
        #expect(WanaKana.toKana("wi", options: ToKanaOptions(useObsoleteKana: true)) == "ゐ")
    }

    @Test("we = ゑ when useObsoleteKana is true") func useObsoleteKanaWe() async throws {
        #expect(WanaKana.toKana("we", options: ToKanaOptions(useObsoleteKana: true)) == "ゑ")
    }

    @Test("WI = ヰ when useObsoleteKana is true") func useObsoleteKanaWiUpper() async throws {
        #expect(WanaKana.toKana("WI", options: ToKanaOptions(useObsoleteKana: true)) == "ヰ")
    }

    @Test("WE = ヱ when useObsoleteKana is true") func useObsoleteKanaWeUpper() async throws {
        #expect(WanaKana.toKana("WE", options: ToKanaOptions(useObsoleteKana: true)) == "ヱ")
    }
}
