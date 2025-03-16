import Testing
@testable import WanaKanaSwift

@Suite("MergeWithDefaultOptionsTests")
final class MergeWithDefaultOptionsTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(areEqual(mergeWithDefaultOptions(), DEFAULT_OPTIONS))
        #expect(areEqual(mergeWithDefaultOptions([:]), DEFAULT_OPTIONS))
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
    
    func areEqual(_ dict1: [String: Any], _ dict2: [String: Any]) -> Bool {
        guard dict1.keys.count == dict2.keys.count else { return false }
        
        for (key, value1) in dict1 {
            guard let value2 = dict2[key] else { return false }
            
            switch value1 {
            case let v1 as Bool:
                guard let v2 = value2 as? Bool, v1 == v2 else { return false }
            case let v1 as String:
                guard let v2 = value2 as? String, v1 == v2 else { return false }
            case let v1 as [String: String]:
                guard let v2 = value2 as? [String: String], v1 == v2 else { return false }
            default:
                return false
            }
        }
        return true
    }
}
