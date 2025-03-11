import Testing
@testable import WanaKanaSwift

@Suite("StripOkuriganaTests")
final class StripOkuriganaTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(stripOkurigana(nil) == "")
        #expect(stripOkurigana("") == "")
        #expect(stripOkurigana("ふふフフ") == "ふふフフ")
        #expect(stripOkurigana("abc") == "abc")
        #expect(stripOkurigana("ふaふbフcフ") == "ふaふbフcフ")
    }

    @Test("default parameter tests") func defaultParameterTests() async throws {
        #expect(stripOkurigana("踏み込む") == "踏み込")
        #expect(stripOkurigana("使い方") == "使い方")
        #expect(stripOkurigana("申し申し") == "申し申")
        #expect(stripOkurigana("人々") == "人々")
        #expect(stripOkurigana("お腹") == "お腹")
        #expect(stripOkurigana("お祝い") == "お祝")
    }

    @Test("strips leading when passed optional config") func stripsLeading() async throws {
        #expect(stripOkurigana("踏み込む", options: StripOkuriganaOptions(leading: true)) == "踏み込む")
        #expect(stripOkurigana("お腹", options: StripOkuriganaOptions(leading: true)) == "腹")
        #expect(stripOkurigana("お祝い", options: StripOkuriganaOptions(leading: true)) == "祝い")
    }

    @Test("strips reading by matching original word when passed matchKanji") func stripsReadingMatchKanji() async throws {
        #expect(stripOkurigana("おはら", options: StripOkuriganaOptions(matchKanji: "お腹")) == "おはら")
        #expect(stripOkurigana("ふみこむ", options: StripOkuriganaOptions(matchKanji: "踏み込む")) == "ふみこ")
        #expect(stripOkurigana("おみまい", options: StripOkuriganaOptions(matchKanji: "お祝い", leading: true)) == "みまい")
        #expect(stripOkurigana("おはら", options: StripOkuriganaOptions(matchKanji: "お腹", leading: true)) == "はら")
    }
}
