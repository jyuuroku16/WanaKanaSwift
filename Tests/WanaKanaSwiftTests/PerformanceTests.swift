import Foundation
import Testing
@testable import WanaKanaSwift

@Suite("PerformanceTests")
final class PerformanceTests {
    @Test("Mean romaji toKana as hiragana speed < 1ms") func testRomajiToKanaHiragana() async throws {
        let startTime = Date()
        let _ = WanaKana.toKana("aiueosashisusesonaninunenokakikukeko")
        let endTime = Date()

        let duration = endTime.timeIntervalSince(startTime)
        #expect(duration < 0.01)
    }

    @Test("Mean romaji toKana as katakana speed < 1ms") func testRomajiToKanaKatakana() async throws {
        let startTime = Date()
        let _ = WanaKana.toKana("AIUEOSASHISUSESONANINUNENOKAKIKUKEKO")
        let endTime = Date()

        let duration = endTime.timeIntervalSince(startTime)
        #expect(duration < 0.01)
    }

    @Test("Mean romaji toHiragana speed < 1ms") func testRomajiToHiragana() async throws {
        let startTime = Date()
        let _ = WanaKana.toHiragana("aiueosashisusesonaninunenokakikukeko")
        let endTime = Date()

        let duration = endTime.timeIntervalSince(startTime)
        #expect(duration < 0.01)
    }

    @Test("Mean katakana toHiragana speed < 1ms") func testKatakanaToHiragana() async throws {
        let startTime = Date()
        let _ = WanaKana.toHiragana("アイウエオサシスセソナニヌネノカキクケコ")
        let endTime = Date()

        let duration = endTime.timeIntervalSince(startTime)
        #expect(duration < 0.01)
    }

    @Test("Mean romaji toKatakana speed < 1ms") func testRomajiToKatakana() async throws {
        let startTime = Date()
        let _ = WanaKana.toKatakana("aiueosashisusesonaninunenokakikukeko")
        let endTime = Date()

        let duration = endTime.timeIntervalSince(startTime)
        #expect(duration < 0.01)
    }

    @Test("Mean hiragana toKatakana speed < 1ms") func testHiraganaToKatakana() async throws {
        let startTime = Date()
        let _ = WanaKana.toKatakana("あいうえおさしすせそなにぬねのかきくけこ")
        let endTime = Date()

        let duration = endTime.timeIntervalSince(startTime)
        #expect(duration < 0.01)
    }

    @Test("Mean hiragana toRomaji speed < 1ms") func testHiraganaToRomaji() async throws {
        let startTime = Date()
        let _ = WanaKana.toRomaji("あいうえおさしすせそなにぬねのかきくけこ")
        let endTime = Date()

        let duration = endTime.timeIntervalSince(startTime)
        #expect(duration < 0.01)
    }

    @Test("Mean katakana toRomaji speed < 1ms") func testKatakanaToRomaji() async throws {
        let startTime = Date()
        let _ = WanaKana.toRomaji("アイウエオサシスセソナニヌネノカキクケコ")
        let endTime = Date()

        let duration = endTime.timeIntervalSince(startTime)
        #expect(duration < 0.01)
    }
}
