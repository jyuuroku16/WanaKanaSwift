import Testing
@testable import WanaKanaSwift

@Suite("ToHiraganaTests")
final class ToHiraganaTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(toHiragana(nil) == "")
        #expect(toHiragana("") == "")
    }

    @Test("Quick Brown Fox - Romaji to Hiragana") func quickBrownFox() async throws {
        let options = ToHiraganaOptions(useObsoleteKana: true)
        // https://en.wikipedia.org/wiki/Iroha
        // Even the colorful fragrant flowers'
        #expect(toHiragana("IROHANIHOHETO", options: options) == "いろはにほへと")
        // die sooner or later.'
        #expect(toHiragana("CHIRINURUWO", options: options) == "ちりぬるを")
        // Us who live in this world'
        #expect(toHiragana("WAKAYOTARESO", options: options) == "わかよたれそ")
        // cannot live forever, either.'
        #expect(toHiragana("TSUNENARAMU", options: options) == "つねならむ")
        // This transient mountain with shifts and changes,'
        #expect(toHiragana("UWINOOKUYAMA", options: options) == "うゐのおくやま")
        // today we are going to overcome, and reach the world of enlightenment.'
        #expect(toHiragana("KEFUKOETE", options: options) == "けふこえて")
        // We are not going to have meaningless dreams'
        #expect(toHiragana("ASAKIYUMEMISHI", options: options) == "あさきゆめみし")
        // nor become intoxicated with the fake world anymore.'
        #expect(toHiragana("WEHIMOSESU", options: options) == "ゑひもせす")
        // *not in iroha*
        #expect(toHiragana("NLTU") == "んっ")
    }

    @Test("useObsoleteKana is false by default") func useObsoleteKanaDefault() async throws {
        #expect(toHiragana("wi") == "うぃ")
    }

    @Test("wi = ゐ when useObsoleteKana is true") func useObsoleteKanaWi() async throws {
        #expect(toHiragana("wi", options: ToHiraganaOptions(useObsoleteKana: true)) == "ゐ")
    }

    @Test("we = ゑ when useObsoleteKana is true") func useObsoleteKanaWe() async throws {
        #expect(toHiragana("we", options: ToHiraganaOptions(useObsoleteKana: true)) == "ゑ")
    }

    @Test("wi = うぃ when useObsoleteKana is false") func useObsoleteKanaWiFalse() async throws {
        #expect(toHiragana("wi", options: ToHiraganaOptions(useObsoleteKana: false)) == "うぃ")
    }

    @Test("passRomaji false by default") func passRomajiDefault() async throws {
        #expect(toHiragana("only カナ") == "おんly かな")
        #expect(toHiragana("only カナ", options: ToHiraganaOptions(passRomaji: true)) == "only かな")
    }

    @Test("convertLongVowelMark when true") func convertLongVowelMarkTrue() async throws {
        #expect(toHiragana("スーパー") == "すうぱあ")
        #expect(toHiragana("バンゴー") == "ばんごう")
    }

    @Test("convertLongVowelMark when false") func convertLongVowelMarkFalse() async throws {
        #expect(toHiragana("ラーメン", options: ToHiraganaOptions(convertLongVowelMark: false)) == "らーめん")
    }

    @Test("mixed input") func mixedInput() async throws {
        #expect(toHiragana("#22 ２２漢字、toukyou, オオサカ") == "#22 ２２漢字、とうきょう、 おおさか")
    }
}
