import Testing
@testable import WanaKanaSwift

@Suite("MergeWithDefaultOptionsTests")
final class MergeWithDefaultOptionsTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(mergeWithDefaultOptions() == DEFAULT_OPTIONS)
        #expect(mergeWithDefaultOptions([:]) == DEFAULT_OPTIONS)
    }

    @Test("applies custom options over default options") func customOptions() async throws {
        let customOptions: [String: Any] = [
            "useObsoleteKana": true,
            "passRomaji": true,
            "upcaseKatakana": true,
            "convertLongVowelMark": false,
            "IMEMode": true,
            "romanization": "hepburn",
            "customKanaMapping": ["wa": "な"],
            "customRomajiMapping": ["な": "wa"]
        ]

        let result = mergeWithDefaultOptions(customOptions)
        #expect(result["useObsoleteKana"] as? Bool == true)
        #expect(result["passRomaji"] as? Bool == true)
        #expect(result["upcaseKatakana"] as? Bool == true)
        #expect(result["convertLongVowelMark"] as? Bool == false)
        #expect(result["IMEMode"] as? Bool == true)
        #expect(result["romanization"] as? String == "hepburn")
        #expect((result["customKanaMapping"] as? [String: String])?["wa"] == "な")
        #expect((result["customRomajiMapping"] as? [String: String])?["な"] == "wa")
    }
}
