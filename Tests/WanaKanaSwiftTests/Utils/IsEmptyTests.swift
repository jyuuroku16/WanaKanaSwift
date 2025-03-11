import Testing
@testable import WanaKanaSwift

@Suite("IsEmptyTests")
final class IsEmptyTests {
    @Test("sane default") func saneDefault() async throws {
        #expect(isEmpty(nil) == true)
    }

    @Test("passes parameter tests") func parameterTests() async throws {
        #expect(isEmpty(nil) == true)
        #expect(isEmpty(22) == true)
        #expect(isEmpty(nil) == true)
        #expect(isEmpty("") == true)
        #expect(isEmpty([]) == true)
        #expect(isEmpty([:]) == true)
        #expect(isEmpty("nope") == false)
    }
}
