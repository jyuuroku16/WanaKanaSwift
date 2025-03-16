import Testing
@testable import WanaKanaSwift

@Suite("ToKanaTests")
final class ToKanaTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(await WanaKana.toKana() == "")
        #expect(await WanaKana.toKana("") == "")
    }

    @Test("Lowercase characters are transliterated to hiragana") func lowercaseToHiragana() async throws {
        #expect(await WanaKana.toKana("onaji") == "おなじ")
    }

    @Test("Lowercase with double consonants and double vowels") func lowercaseWithDoubles() async throws {
        #expect(await WanaKana.toKana("buttsuuji") == "ぶっつうじ")
    }

    @Test("Uppercase characters are transliterated to katakana") func uppercaseToKatakana() async throws {
        #expect(await WanaKana.toKana("ONAJI") == "オナジ")
    }

    @Test("Uppercase with double consonants and double vowels") func uppercaseWithDoubles() async throws {
        #expect(await WanaKana.toKana("BUTTSUUJI") == "ブッツウジ")
    }

    @Test("Mixed case returns hiragana") func mixedCase() async throws {
        #expect(await WanaKana.toKana("WaniKani") == "わにかに")
    }

    @Test("Converts Ryukyuan constructions") func ryukyuanConstructions() async throws {
        #expect(await WanaKana.toKana("kwi kuxi kuli kwe kuxe kule kwo kuxo kulo") == "くぃ くぃ くぃ くぇ くぇ くぇ くぉ くぉ くぉ")
    }

    @Test("Non-romaji will be passed through") func nonRomajiPassthrough() async throws {
        #expect(await WanaKana.toKana("ワニカニ AiUeO 鰐蟹 12345 @#$%") == "ワニカニ アいウえオ 鰐蟹 12345 @#$%")
    }

    @Test("It handles mixed syllabaries") func mixedSyllabaries() async throws {
        #expect(await WanaKana.toKana("座禅'zazen'スタイル") == "座禅「ざぜん」スタイル")
    }

    @Test("Will convert short to long dashes") func shortToLongDashes() async throws {
        #expect(await WanaKana.toKana("batsuge-mu") == "ばつげーむ")
    }

    @Test("Without IME Mode - solo n's") func withoutIMEModeSoloN() async throws {
        #expect(await WanaKana.toKana("n") == "ん")
        #expect(await WanaKana.toKana("shin") == "しん")
    }

    @Test("Without IME Mode - double n's") func withoutIMEModeDoubleN() async throws {
        #expect(await WanaKana.toKana("nn") == "んん")
    }

    @Test("With IME Mode - solo n's") func withIMEModeSoloN() async throws {
        #expect(await WanaKana.toKana("n", options: ToKanaOptions(IMEMode: true)) == "n")
        #expect(await WanaKana.toKana("shin", options: ToKanaOptions(IMEMode: true)) == "しn")
        #expect(await WanaKana.toKana("shinyou", options: ToKanaOptions(IMEMode: true)) == "しにょう")
        #expect(await WanaKana.toKana("shin'you", options: ToKanaOptions(IMEMode: true)) == "しんよう")
        #expect(await WanaKana.toKana("shin you", options: ToKanaOptions(IMEMode: true)) == "しんよう")
    }

    @Test("With IME Mode - double n's") func withIMEModeDoubleN() async throws {
        #expect(await WanaKana.toKana("nn", options: ToKanaOptions(IMEMode: true)) == "ん")
    }

    @Test("useObsoleteKana is false by default") func useObsoleteKanaDefault() async throws {
        #expect(await WanaKana.toKana("wi") == "うぃ")
        #expect(await WanaKana.toKana("WI") == "ウィ")
    }

    @Test("wi = ゐ when useObsoleteKana is true") func useObsoleteKanaWi() async throws {
        #expect(await WanaKana.toKana("wi", options: ToKanaOptions(useObsoleteKana: true)) == "ゐ")
    }

    @Test("we = ゑ when useObsoleteKana is true") func useObsoleteKanaWe() async throws {
        #expect(await WanaKana.toKana("we", options: ToKanaOptions(useObsoleteKana: true)) == "ゑ")
    }

    @Test("WI = ヰ when useObsoleteKana is true") func useObsoleteKanaWiUpper() async throws {
        #expect(await WanaKana.toKana("WI", options: ToKanaOptions(useObsoleteKana: true)) == "ヰ")
    }

    @Test("WE = ヱ when useObsoleteKana is true") func useObsoleteKanaWeUpper() async throws {
        #expect(await WanaKana.toKana("WE", options: ToKanaOptions(useObsoleteKana: true)) == "ヱ")
    }
}
