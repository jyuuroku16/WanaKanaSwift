import Testing
@testable import WanaKanaSwift

@Suite("StripOkuriganaTests")
final class StripOkuriganaTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(WanaKana.stripOkurigana() == "")
        #expect(WanaKana.stripOkurigana("") == "")
        #expect(WanaKana.stripOkurigana("ふふフフ") == "ふふフフ")
        #expect(WanaKana.stripOkurigana("abc") == "abc")
        #expect(WanaKana.stripOkurigana("ふaふbフcフ") == "ふaふbフcフ")
    }

    @Test("default parameter tests") func defaultParameterTests() async throws {
        #expect(WanaKana.stripOkurigana("踏み込む") == "踏み込")
        #expect(WanaKana.stripOkurigana("使い方") == "使い方")
        #expect(WanaKana.stripOkurigana("申し申し") == "申し申")
        #expect(WanaKana.stripOkurigana("人々") == "人々")
        #expect(WanaKana.stripOkurigana("お腹") == "お腹")
        #expect(WanaKana.stripOkurigana("お祝い") == "お祝")
    }

    @Test("strips leading when passed optional config") func stripsLeading() async throws {
        #expect(WanaKana.stripOkurigana("踏み込む", options: [
            "leading": true
        ]) == "踏み込む")
        #expect(WanaKana.stripOkurigana("お腹", options: [
            "leading": true
        ]) == "腹")
        #expect(WanaKana.stripOkurigana("お祝い", options: [
            "leading": true
        ]) == "祝い")
    }

    @Test("strips reading by matching original word when passed matchKanji") func stripsReadingMatchKanji() async throws {
        #expect(WanaKana.stripOkurigana("おはら", options: [
            "matchKanji": "お腹"
        ]) == "おはら")
        #expect(WanaKana.stripOkurigana("ふみこむ", options: [
            "matchKanji": "踏み込む"
        ]) == "ふみこ")
        #expect(WanaKana.stripOkurigana("おみまい", options: [
            "matchKanji": "お祝い"
        ]) == "みまい")
        #expect(WanaKana.stripOkurigana("おはら", options: [
            "matchKanji": "お腹"
        ]) == "はら")
    }
}
