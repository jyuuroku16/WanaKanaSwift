import Testing
@testable import WanaKanaSwift

@Suite("ToKanaTests")
final class ToKanaTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(toKana(nil) == "")
        #expect(toKana("") == "")
    }

    @Test("Lowercase characters are transliterated to hiragana") func lowercaseToHiragana() async throws {
        #expect(toKana("onaji") == "おなじ")
    }

    @Test("Lowercase with double consonants and double vowels") func lowercaseWithDoubles() async throws {
        #expect(toKana("buttsuuji") == "ぶっつうじ")
    }

    @Test("Uppercase characters are transliterated to katakana") func uppercaseToKatakana() async throws {
        #expect(toKana("ONAJI") == "オナジ")
    }

    @Test("Uppercase with double consonants and double vowels") func uppercaseWithDoubles() async throws {
        #expect(toKana("BUTTSUUJI") == "ブッツウジ")
    }

    @Test("Mixed case returns hiragana") func mixedCase() async throws {
        #expect(toKana("WaniKani") == "わにかに")
    }

    @Test("Converts Ryukyuan constructions") func ryukyuanConstructions() async throws {
        #expect(toKana("kwi kuxi kuli kwe kuxe kule kwo kuxo kulo") == "くぃ くぃ くぃ くぇ くぇ くぇ くぉ くぉ くぉ")
    }

    @Test("Non-romaji will be passed through") func nonRomajiPassthrough() async throws {
        #expect(toKana("ワニカニ AiUeO 鰐蟹 12345 @#$%") == "ワニカニ アいウえオ 鰐蟹 12345 @#$%")
    }

    @Test("It handles mixed syllabaries") func mixedSyllabaries() async throws {
        #expect(toKana("座禅'zazen'スタイル") == "座禅「ざぜん」スタイル")
    }

    @Test("Will convert short to long dashes") func shortToLongDashes() async throws {
        #expect(toKana("batsuge-mu") == "ばつげーむ")
    }

    @Test("Without IME Mode - solo n's") func withoutIMEModeSoloN() async throws {
        #expect(toKana("n") == "ん")
        #expect(toKana("shin") == "しん")
    }

    @Test("Without IME Mode - double n's") func withoutIMEModeDoubleN() async throws {
        #expect(toKana("nn") == "んん")
    }

    @Test("With IME Mode - solo n's") func withIMEModeSoloN() async throws {
        #expect(toKana("n", options: ToKanaOptions(IMEMode: true)) == "n")
        #expect(toKana("shin", options: ToKanaOptions(IMEMode: true)) == "しn")
        #expect(toKana("shinyou", options: ToKanaOptions(IMEMode: true)) == "しにょう")
        #expect(toKana("shin'you", options: ToKanaOptions(IMEMode: true)) == "しんよう")
        #expect(toKana("shin you", options: ToKanaOptions(IMEMode: true)) == "しんよう")
    }

    @Test("With IME Mode - double n's") func withIMEModeDoubleN() async throws {
        #expect(toKana("nn", options: ToKanaOptions(IMEMode: true)) == "ん")
    }

    @Test("useObsoleteKana is false by default") func useObsoleteKanaDefault() async throws {
        #expect(toKana("wi") == "うぃ")
        #expect(toKana("WI") == "ウィ")
    }

    @Test("wi = ゐ when useObsoleteKana is true") func useObsoleteKanaWi() async throws {
        #expect(toKana("wi", options: ToKanaOptions(useObsoleteKana: true)) == "ゐ")
    }

    @Test("we = ゑ when useObsoleteKana is true") func useObsoleteKanaWe() async throws {
        #expect(toKana("we", options: ToKanaOptions(useObsoleteKana: true)) == "ゑ")
    }

    @Test("WI = ヰ when useObsoleteKana is true") func useObsoleteKanaWiUpper() async throws {
        #expect(toKana("WI", options: ToKanaOptions(useObsoleteKana: true)) == "ヰ")
    }

    @Test("WE = ヱ when useObsoleteKana is true") func useObsoleteKanaWeUpper() async throws {
        #expect(toKana("WE", options: ToKanaOptions(useObsoleteKana: true)) == "ヱ")
    }
}
