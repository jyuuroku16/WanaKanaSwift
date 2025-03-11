import Testing
@testable import WanaKanaSwift

@Suite("ToKatakanaTests")
final class ToKatakanaTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(WanaKana.toKatakana() == "")
        #expect(WanaKana.toKatakana("") == "")
    }

    @Test("Quick Brown Fox - Romaji to Katakana") func quickBrownFox() async throws {
        let options = ToKatakanaOptions(useObsoleteKana: true)
        // https://en.wikipedia.org/wiki/Iroha
        // Even the colorful fragrant flowers'
        #expect(WanaKana.toKatakana("IROHANIHOHETO", options: options) == "イロハニホヘト")
        // die sooner or later.'
        #expect(WanaKana.toKatakana("CHIRINURUWO", options: options) == "チリヌルヲ")
        // Us who live in this world'
        #expect(WanaKana.toKatakana("WAKAYOTARESO", options: options) == "ワカヨタレソ")
        // cannot live forever, either.'
        #expect(WanaKana.toKatakana("TSUNENARAMU", options: options) == "ツネナラム")
        // This transient mountain with shifts and changes,'
        #expect(WanaKana.toKatakana("UWINOOKUYAMA", options: options) == "ウヰノオクヤマ")
        // today we are going to overcome, and reach the world of enlightenment.'
        #expect(WanaKana.toKatakana("KEFUKOETE", options: options) == "ケフコエテ")
        // We are not going to have meaningless dreams'
        #expect(WanaKana.toKatakana("ASAKIYUMEMISHI", options: options) == "アサキユメミシ")
        // nor become intoxicated with the fake world anymore.'
        #expect(WanaKana.toKatakana("WEHIMOSESU", options: options) == "ヱヒモセス")
        // *not in iroha*
        #expect(WanaKana.toKatakana("NLTU") == "ンッ")
    }

    @Test("useObsoleteKana is false by default") func useObsoleteKanaDefault() async throws {
        #expect(WanaKana.toKatakana("wi") == "ウィ")
    }

    @Test("WI = ヰ when useObsoleteKana is true") func useObsoleteKanaWi() async throws {
        #expect(WanaKana.toKatakana("wi", options: ToKatakanaOptions(useObsoleteKana: true)) == "ヰ")
    }

    @Test("WE = ヱ when useObsoleteKana is true") func useObsoleteKanaWe() async throws {
        #expect(WanaKana.toKatakana("we", options: ToKatakanaOptions(useObsoleteKana: true)) == "ヱ")
    }

    @Test("passRomaji false by default") func passRomajiDefault() async throws {
        #expect(WanaKana.toKatakana("only かな") == "オンly カナ")
        #expect(WanaKana.toKatakana("only かな", options: ToKatakanaOptions(passRomaji: true)) == "only カナ")
    }
}
