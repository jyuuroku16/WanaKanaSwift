import Testing
@testable import WanaKanaSwift

@Suite("IsCharSlashDotTests")
final class IsCharSlashDotTests {
    @Test("sane default") func saneDefault() async throws {
        #expect(isCharSlashDot(nil) == false)
    }

    @Test("passes parameter tests") func parameterTests() async throws {
        #expect(isCharSlashDot("・") == true)
        #expect(isCharSlashDot("/") == false)
    }
}
