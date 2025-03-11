import Testing
@testable import WanaKanaSwift

@Suite("IsCharUpperCaseTests")
final class IsCharUpperCaseTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(isCharUpperCase(nil) == false)
        #expect(isCharUpperCase("") == false)
    }

    @Test("passes parameter tests") func parameterTests() async throws {
        #expect(isCharUpperCase("A") == true)
        #expect(isCharUpperCase("D") == true)
        #expect(isCharUpperCase("-") == false)
        #expect(isCharUpperCase("ー") == false)
        #expect(isCharUpperCase("a") == false)
        #expect(isCharUpperCase("d") == false)
    }
}
