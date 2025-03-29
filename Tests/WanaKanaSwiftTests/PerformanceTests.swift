import Foundation
import Testing
@testable import WanaKanaSwift

@Suite("PerformanceTests")
final class PerformanceTests {
    @Test("Converts 100,000 characters in less than 1 second") func testLargeConversion() async throws {
        let startTime = Date()
        let testString = String(repeating: "aiueoshinnndesu", count: 6250) // 16 chars * 6250 = 100,000 chars
        let _ = WanaKana.toKana(testString)
        let endTime = Date()

        let duration = endTime.timeIntervalSince(startTime)
        #expect(duration < 1.0)
    }

    @Test("Converts 100,000 characters in less than 1 second with IME mode") func testLargeConversionIME() async throws {
        let startTime = Date()
        let testString = String(repeating: "aiueoshinnndesu", count: 6250) // 16 chars * 6250 = 100,000 chars
        let _ = WanaKana.toKana(testString, options: [
            "IMEMode": true
        ])
        let endTime = Date()

        let duration = endTime.timeIntervalSince(startTime)
        #expect(duration < 1.0)
    }

    @Test("Converts 100,000 characters in less than 1 second with custom mappings") func testLargeConversionCustomMappings() async throws {
        let startTime = Date()
        let testString = String(repeating: "aiueoshinnndesu", count: 6250) // 16 chars * 6250 = 100,000 chars
        let _ = WanaKana.toKana(testString, options: [ "customKanaMapping": [
            "sh": "し",
            "nn": "ん",
            "n": "の"
        ]])
        let endTime = Date()

        let duration = endTime.timeIntervalSince(startTime)
        #expect(duration < 1.0)
    }

    @Test("Converts hiragana to katakana in less than 1 second") func testHiraganaToKatakana() async throws {
        let startTime = Date()
        let testString = String(repeating: "あいうえおさしすせそなにぬねのかきくけこ", count: 2500)
        let _ = WanaKana.toKatakana(testString)
        let endTime = Date()

        let duration = endTime.timeIntervalSince(startTime)
        #expect(duration < 1.0)
    }

    @Test("Converts katakana to hiragana in less than 1 second") func testKatakanaToHiragana() async throws {
        let startTime = Date()
        let testString = String(repeating: "アイウエオサシスセソナニヌネノカキクケコ", count: 2500)
        let _ = WanaKana.toHiragana(testString)
        let endTime = Date()

        let duration = endTime.timeIntervalSince(startTime)
        #expect(duration < 1.0)
    }

    @Test("Converts hiragana to romaji in less than 1 second") func testHiraganaToRomaji() async throws {
        let startTime = Date()
        let testString = String(repeating: "あいうえおさしすせそなにぬねのかきくけこ", count: 2500)
        let _ = WanaKana.toRomaji(testString)
        let endTime = Date()

        let duration = endTime.timeIntervalSince(startTime)
        #expect(duration < 1.0)
    }

    @Test("Converts katakana to romaji in less than 1 second") func testKatakanaToRomaji() async throws {
        let startTime = Date()
        let testString = String(repeating: "アイウエオサシスセソナニヌネノカキクケコ", count: 2500)
        let _ = WanaKana.toRomaji(testString)
        let endTime = Date()

        let duration = endTime.timeIntervalSince(startTime)
        #expect(duration < 1.0)
    }
}
