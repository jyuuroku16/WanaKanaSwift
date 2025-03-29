import Testing
@testable import WanaKanaSwift

@Suite("ToKatakanaTests")
final class ToKatakanaTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(WanaKanaSwift.toKatakana().isEmpty)
        #expect(WanaKanaSwift.toKatakana("").isEmpty)
    }

    @Test("Quick Brown Fox - Romaji to Katakana") func quickBrownFox() async throws {
        let options = ["useObsoleteKana": true]
        // https://en.wikipedia.org/wiki/Iroha
        // Even the colorful fragrant flowers'
        #expect(WanaKanaSwift.toKatakana("IROHANIHOHETO", options: options) == "イロハニホヘト")
        // die sooner or later.'
        #expect(WanaKanaSwift.toKatakana("CHIRINURUWO", options: options) == "チリヌルヲ")
        // Us who live in this world'
        #expect(WanaKanaSwift.toKatakana("WAKAYOTARESO", options: options) == "ワカヨタレソ")
        // cannot live forever, either.'
        #expect(WanaKanaSwift.toKatakana("TSUNENARAMU", options: options) == "ツネナラム")
        // This transient mountain with shifts and changes,'
        #expect(WanaKanaSwift.toKatakana("UWINOOKUYAMA", options: options) == "ウヰノオクヤマ")
        // today we are going to overcome, and reach the world of enlightenment.'
        #expect(WanaKanaSwift.toKatakana("KEFUKOETE", options: options) == "ケフコエテ")
        // We are not going to have meaningless dreams'
        #expect(WanaKanaSwift.toKatakana("ASAKIYUMEMISHI", options: options) == "アサキユメミシ")
        // nor become intoxicated with the fake world anymore.'
        #expect(WanaKanaSwift.toKatakana("WEHIMOSESU", options: options) == "ヱヒモセス")
        // *not in iroha*
        #expect(WanaKanaSwift.toKatakana("NLTU") == "ンッ")
    }

    @Test("useObsoleteKana is false by default") func useObsoleteKanaDefault() async throws {
        #expect(WanaKanaSwift.toKatakana("wi") == "ウィ")
    }

    @Test("WI = ヰ when useObsoleteKana is true") func useObsoleteKanaWi() async throws {
        #expect(WanaKanaSwift.toKatakana("wi", options: ["useObsoleteKana": true]) == "ヰ")
    }

    @Test("WE = ヱ when useObsoleteKana is true") func useObsoleteKanaWe() async throws {
        #expect(WanaKanaSwift.toKatakana("we", options: ["useObsoleteKana": true]) == "ヱ")
    }

    @Test("passRomaji false by default") func passRomajiDefault() async throws {
        #expect(WanaKanaSwift.toKatakana("only かな") == "オンly カナ")
        #expect(WanaKanaSwift.toKatakana("only かな", options: ["passRomaji": true]) == "only カナ")
    }
}
