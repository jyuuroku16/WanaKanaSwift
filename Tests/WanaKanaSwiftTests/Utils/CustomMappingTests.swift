import Testing
@testable import WanaKanaSwift

@Suite("CustomMappingTests")
final class CustomMappingTests {
    @Test("safe defaults") func safeDefaults() async throws {
        _ = createCustomMapping()
        _ = createCustomMapping([:])
        _ = mergeCustomMapping([:], nil)
    }

    @Test("applies customKanaMapping") func customKanaMapping() async throws {
        let result = WanaKanaSwift.toKana("wanakana", options: [
            "customKanaMapping": createCustomMapping([
                "na": "に",
                "ka": "Bana"
            ])
        ])
        #expect(result == "わにBanaに")
    }

    @Test("can't romanize with an invalid method") func invalidRomanization() async throws {
        #expect(WanaKanaSwift.toRomaji("つじぎり", options: ["romanization": "it's called rōmaji!!!"]) == "つじぎり")
    }

    @Test("applies customRomajiMapping") func customRomajiMapping() async throws {
        let result = WanaKanaSwift.toRomaji("つじぎり", options: [
            "customRomajiMapping": createCustomMapping([
                "じ": "zi",
                "つ": "tu",
                "り": "li"
            ])
        ])
        #expect(result == "tuzigili")
    }

    @Test("will replace previous custom mappings") func replacePreviousMappings() async throws {
        var result = WanaKanaSwift.toRomaji("つじぎり", options: [
            "customRomajiMapping": createCustomMapping([
                "じ": "zi",
                "つ": "tu",
                "り": "li"
            ])
        ])
        #expect(result == "tuzigili")

        result = WanaKanaSwift.toRomaji("つじぎり", options: [
            "customRomajiMapping": createCustomMapping([
                "じ": "bi",
                "つ": "bu",
                "り": "bi"
            ])
        ])
        #expect(result == "bubigibi")

        result = WanaKanaSwift.toKana("wanakana", options: [
            "customKanaMapping": createCustomMapping([
                "na": "に",
                "ka": "Bana"
            ])
        ])
        #expect(result == "わにBanaに")

        result = WanaKanaSwift.toKana("wanakana", options: [
            "customKanaMapping": createCustomMapping([
                "na": "り",
                "ka": "Cabana"
            ])
        ])
        #expect(result == "わりCabanaり")
    }

    @Test("will accept a plain object and merge it internally via createCustomMapping()") func acceptPlainObject() async throws {
        var result = WanaKanaSwift.toKana("wanakana", options: [
            "customKanaMapping": [
                "na": "に",
                "ka": "Bana"
            ]
        ])
        #expect(result == "わにBanaに")

        result = WanaKanaSwift.toRomaji("つじぎり", options: [
            "customRomajiMapping": [
                "じ": "zi",
                "つ": "tu",
                "り": "li"
            ]
        ])
        #expect(result == "tuzigili")
    }
}
