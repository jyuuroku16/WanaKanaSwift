import Testing
@testable import WanaKanaSwift

@Suite("ToHiraganaTests")
final class ToHiraganaTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(WanaKanaSwift.toHiragana() == "")
        #expect(WanaKanaSwift.toHiragana("") == "")
    }

    @Test("Quick Brown Fox - Romaji to Hiragana") func quickBrownFox() async throws {
        let options = ["useObsoleteKana": true]
        // https://en.wikipedia.org/wiki/Iroha
        // Even the colorful fragrant flowers'
        #expect(WanaKanaSwift.toHiragana("IROHANIHOHETO", options: options) == "いろはにほへと")
        // die sooner or later.'
        #expect(WanaKanaSwift.toHiragana("CHIRINURUWO", options: options) == "ちりぬるを")
        // Us who live in this world'
        #expect(WanaKanaSwift.toHiragana("WAKAYOTARESO", options: options) == "わかよたれそ")
        // cannot live forever, either.'
        #expect(WanaKanaSwift.toHiragana("TSUNENARAMU", options: options) == "つねならむ")
        // This transient mountain with shifts and changes,'
        #expect(WanaKanaSwift.toHiragana("UWINOOKUYAMA", options: options) == "うゐのおくやま")
        // today we are going to overcome, and reach the world of enlightenment.'
        #expect(WanaKanaSwift.toHiragana("KEFUKOETE", options: options) == "けふこえて")
        // We are not going to have meaningless dreams'
        #expect(WanaKanaSwift.toHiragana("ASAKIYUMEMISHI", options: options) == "あさきゆめみし")
        // nor become intoxicated with the fake world anymore.'
        #expect(WanaKanaSwift.toHiragana("WEHIMOSESU", options: options) == "ゑひもせす")
        // *not in iroha*
        #expect(WanaKanaSwift.toHiragana("NLTU") == "んっ")
    }

    @Test("useObsoleteKana is false by default") func useObsoleteKanaDefault() async throws {
        #expect(WanaKanaSwift.toHiragana("wi") == "うぃ")
    }

    @Test("wi = ゐ when useObsoleteKana is true") func useObsoleteKanaWi() async throws {
        #expect(WanaKanaSwift.toHiragana("wi", options: ["useObsoleteKana": true]) == "ゐ")
    }

    @Test("we = ゑ when useObsoleteKana is true") func useObsoleteKanaWe() async throws {
        #expect(WanaKanaSwift.toHiragana("we", options: ["useObsoleteKana": true]) == "ゑ")
    }

    @Test("wi = うぃ when useObsoleteKana is false") func useObsoleteKanaWiFalse() async throws {
        #expect(WanaKanaSwift.toHiragana("wi", options: ["useObsoleteKana": false]) == "うぃ")
    }

    @Test("passRomaji false by default") func passRomajiDefault() async throws {
        #expect(WanaKanaSwift.toHiragana("only カナ") == "おんly かな")
        #expect(WanaKanaSwift.toHiragana("only カナ", options: ["passRomaji": true]) == "only かな")
    }

    @Test("convertLongVowelMark when true") func convertLongVowelMarkTrue() async throws {
        #expect(WanaKanaSwift.toHiragana("スーパー") == "すうぱあ")
        #expect(WanaKanaSwift.toHiragana("バンゴー") == "ばんごう")
    }

    @Test("convertLongVowelMark when false") func convertLongVowelMarkFalse() async throws {
        #expect(WanaKanaSwift.toHiragana("ラーメン", options: ["convertLongVowelMark": false]) == "らーめん")
    }

    @Test("mixed input") func mixedInput() async throws {
        #expect(WanaKanaSwift.toHiragana("#22 ２２漢字、toukyou, オオサカ") == "#22 ２２漢字、とうきょう、 おおさか")
    }
}
