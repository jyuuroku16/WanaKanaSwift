import Testing
@testable import WanaKanaSwift

@Suite("CustomMappingTests")
final class CustomMappingTests {
    @Test("safe defaults") func safeDefaults() async throws {
        #expect { try createCustomMapping(nil) }.toNotThrow()
        #expect { try createCustomMapping([:]) }.toNotThrow()
        #expect { try mergeCustomMapping(nil, nil) }.toNotThrow()
        #expect { try mergeCustomMapping([:], nil) }.toNotThrow()
        #expect { try mergeCustomMapping([:], [:]) }.toNotThrow()
        #expect { try mergeCustomMapping(nil, nil) }.toNotThrow()
    }

    @Test("applies customKanaMapping") func customKanaMapping() async throws {
        let result = toKana("wanakana", options: ToKanaOptions(customKanaMapping: createCustomMapping([
            "na": "に",
            "ka": "Bana"
        ])))
        #expect(result == "わにBanaに")
    }

    @Test("can't romanize with an invalid method") func invalidRomanization() async throws {
        #expect(toRomaji("つじぎり", options: ToRomajiOptions(romanization: "it's called rōmaji!!!")) == "つじぎり")
    }

    @Test("applies customRomajiMapping") func customRomajiMapping() async throws {
        let result = toRomaji("つじぎり", options: ToRomajiOptions(customRomajiMapping: createCustomMapping([
            "じ": "zi",
            "つ": "tu",
            "り": "li"
        ])))
        #expect(result == "tuzigili")
    }

    @Test("will replace previous custom mappings") func replacePreviousMappings() async throws {
        var result = toRomaji("つじぎり", options: ToRomajiOptions(customRomajiMapping: createCustomMapping([
            "じ": "zi",
            "つ": "tu",
            "り": "li"
        ])))
        #expect(result == "tuzigili")

        result = toRomaji("つじぎり", options: ToRomajiOptions(customRomajiMapping: createCustomMapping([
            "じ": "bi",
            "つ": "bu",
            "り": "bi"
        ])))
        #expect(result == "bubigibi")

        result = toKana("wanakana", options: ToKanaOptions(customKanaMapping: createCustomMapping([
            "na": "に",
            "ka": "Bana"
        ])))
        #expect(result == "わにBanaに")

        result = toKana("wanakana", options: ToKanaOptions(customKanaMapping: createCustomMapping([
            "na": "り",
            "ka": "Cabana"
        ])))
        #expect(result == "わりCabanaり")
    }

    @Test("will accept a plain object and merge it internally via createCustomMapping()") func acceptPlainObject() async throws {
        var result = toKana("wanakana", options: ToKanaOptions(customKanaMapping: [
            "na": "に",
            "ka": "Bana"
        ]))
        #expect(result == "わにBanaに")

        result = toRomaji("つじぎり", options: ToRomajiOptions(customRomajiMapping: [
            "じ": "zi",
            "つ": "tu",
            "り": "li"
        ]))
        #expect(result == "tuzigili")
    }
}
