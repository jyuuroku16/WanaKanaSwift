import Testing
@testable import WanaKanaSwift

@Suite("IsCharLongDashTests")
final class IsCharLongDashTests {
    @Test("sane default") func saneDefault() async throws {
        #expect(isCharLongDash() == false)
    }

    @Test("passes parameter tests") func parameterTests() async throws {
        #expect(isCharLongDash("ー") == true)
        #expect(isCharLongDash("-") == false)
        #expect(isCharLongDash("f") == false)
        #expect(isCharLongDash("ふ") == false)
    }
}
