import Testing
@testable import WanaKanaSwift

@Suite("PerformanceTests")
final class PerformanceTests {
    @Test("Converts 100,000 characters in less than 1 second") func testLargeConversion() async throws {
        let startTime = Date()
        let testString = String(repeating: "aiueoshinnndesu", count: 6250) // 16 chars * 6250 = 100,000 chars
        let _ = toKana(testString)
        let endTime = Date()

        let duration = endTime.timeIntervalSince(startTime)
        #expect(duration < 1.0)
    }

    @Test("Converts 100,000 characters in less than 1 second with IME mode") func testLargeConversionIME() async throws {
        let startTime = Date()
        let testString = String(repeating: "aiueoshinnndesu", count: 6250) // 16 chars * 6250 = 100,000 chars
        let _ = toKana(testString, options: ToKanaOptions(IMEMode: true))
        let endTime = Date()

        let duration = endTime.timeIntervalSince(startTime)
        #expect(duration < 1.0)
    }

    @Test("Converts 100,000 characters in less than 1 second with custom mappings") func testLargeConversionCustomMappings() async throws {
        let startTime = Date()
        let testString = String(repeating: "aiueoshinnndesu", count: 6250) // 16 chars * 6250 = 100,000 chars
        let _ = toKana(testString, options: ToKanaOptions(customKanaMapping: [
            "sh": "し",
            "nn": "ん",
            "n": "の"
        ]))
        let endTime = Date()

        let duration = endTime.timeIntervalSince(startTime)
        #expect(duration < 1.0)
    }
}
