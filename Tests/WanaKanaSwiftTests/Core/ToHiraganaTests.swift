import Testing
@testable import WanaKanaSwift

@Suite("ToHiraganaTests")
final class ToHiraganaTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(WanaKana.toHiragana() == "")
        #expect(WanaKana.toHiragana("") == "")
    }

    @Test("Quick Brown Fox - Romaji to Hiragana") func quickBrownFox() async throws {
        let options = ["useObsoleteKana": true]
        // https://en.wikipedia.org/wiki/Iroha
        // Even the colorful fragrant flowers'
        #expect(WanaKana.toHiragana("IROHANIHOHETO", options: options) == "いろはにほへと")
        // die sooner or later.'
        #expect(WanaKana.toHiragana("CHIRINURUWO", options: options) == "ちりぬるを")
        // Us who live in this world'
        #expect(WanaKana.toHiragana("WAKAYOTARESO", options: options) == "わかよたれそ")
        // cannot live forever, either.'
        #expect(WanaKana.toHiragana("TSUNENARAMU", options: options) == "つねならむ")
        // This transient mountain with shifts and changes,'
        #expect(WanaKana.toHiragana("UWINOOKUYAMA", options: options) == "うゐのおくやま")
        // today we are going to overcome, and reach the world of enlightenment.'
        #expect(WanaKana.toHiragana("KEFUKOETE", options: options) == "けふこえて")
        // We are not going to have meaningless dreams'
        #expect(WanaKana.toHiragana("ASAKIYUMEMISHI", options: options) == "あさきゆめみし")
        // nor become intoxicated with the fake world anymore.'
        #expect(WanaKana.toHiragana("WEHIMOSESU", options: options) == "ゑひもせす")
        // *not in iroha*
        #expect(WanaKana.toHiragana("NLTU") == "んっ")
    }

    @Test("useObsoleteKana is false by default") func useObsoleteKanaDefault() async throws {
        #expect(WanaKana.toHiragana("wi") == "うぃ")
    }

    @Test("wi = ゐ when useObsoleteKana is true") func useObsoleteKanaWi() async throws {
        #expect(WanaKana.toHiragana("wi", options: ["useObsoleteKana": true]) == "ゐ")
    }

    @Test("we = ゑ when useObsoleteKana is true") func useObsoleteKanaWe() async throws {
        #expect(WanaKana.toHiragana("we", options: ["useObsoleteKana": true]) == "ゑ")
    }

    @Test("wi = うぃ when useObsoleteKana is false") func useObsoleteKanaWiFalse() async throws {
        #expect(WanaKana.toHiragana("wi", options: ["useObsoleteKana": false]) == "うぃ")
    }

    @Test("passRomaji false by default") func passRomajiDefault() async throws {
        #expect(WanaKana.toHiragana("only カナ") == "おんly かな")
        #expect(WanaKana.toHiragana("only カナ", options: ["passRomaji": true]) == "only かな")
    }

    @Test("convertLongVowelMark when true") func convertLongVowelMarkTrue() async throws {
        #expect(WanaKana.toHiragana("スーパー") == "すうぱあ")
        #expect(WanaKana.toHiragana("バンゴー") == "ばんごう")
    }

    @Test("convertLongVowelMark when false") func convertLongVowelMarkFalse() async throws {
        #expect(WanaKana.toHiragana("ラーメン", options: ["convertLongVowelMark": false]) == "らーめん")
    }

    @Test("mixed input") func mixedInput() async throws {
        #expect(WanaKana.toHiragana("#22 ２２漢字、toukyou, オオサカ") == "#22 ２２漢字、とうきょう、 おおさか")
    }
}
