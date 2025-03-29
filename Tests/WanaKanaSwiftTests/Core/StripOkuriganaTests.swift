import Testing
@testable import WanaKanaSwift

@Suite("StripOkuriganaTests")
final class StripOkuriganaTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(WanaKanaSwift.stripOkurigana() == "")
        #expect(WanaKanaSwift.stripOkurigana("") == "")
        #expect(WanaKanaSwift.stripOkurigana("ふふフフ") == "ふふフフ")
        #expect(WanaKanaSwift.stripOkurigana("abc") == "abc")
        #expect(WanaKanaSwift.stripOkurigana("ふaふbフcフ") == "ふaふbフcフ")
    }

    @Test("default parameter tests") func defaultParameterTests() async throws {
        #expect(WanaKanaSwift.stripOkurigana("踏み込む") == "踏み込")
        #expect(WanaKanaSwift.stripOkurigana("使い方") == "使い方")
        #expect(WanaKanaSwift.stripOkurigana("申し申し") == "申し申")
        #expect(WanaKanaSwift.stripOkurigana("人々") == "人々")
        #expect(WanaKanaSwift.stripOkurigana("お腹") == "お腹")
        #expect(WanaKanaSwift.stripOkurigana("お祝い") == "お祝")
    }

    @Test("strips leading when passed optional config") func stripsLeading() async throws {
        #expect(WanaKanaSwift.stripOkurigana("踏み込む", options: [
            "leading": true
        ]) == "踏み込む")
        #expect(WanaKanaSwift.stripOkurigana("お腹", options: [
            "leading": true
        ]) == "腹")
        #expect(WanaKanaSwift.stripOkurigana("お祝い", options: [
            "leading": true
        ]) == "祝い")
    }

    @Test("strips reading by matching original word when passed matchKanji") func stripsReadingMatchKanji() async throws {
        #expect(WanaKanaSwift.stripOkurigana("おはら", options: [
            "matchKanji": "お腹"
        ]) == "おはら")
        #expect(WanaKanaSwift.stripOkurigana("ふみこむ", options: [
            "matchKanji": "踏み込む"
        ]) == "ふみこ")
        #expect(WanaKanaSwift.stripOkurigana("おみまい", options: [
            "matchKanji": "お祝い",
            "leading": true
        ]) == "みまい")
        #expect(WanaKanaSwift.stripOkurigana("おはら", options: [
            "matchKanji": "お腹",
            "leading": true
        ]) == "はら")
    }
}
