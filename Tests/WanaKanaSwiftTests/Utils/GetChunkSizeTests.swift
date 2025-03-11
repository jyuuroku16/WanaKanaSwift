import Testing
@testable import WanaKanaSwift

@Suite("GetChunkSizeTests")
final class GetChunkSizeTests {
    @Test("sane default") func saneDefault() async throws {
        #expect(getChunkSize() == 0)
    }

    @Test("passes parameter tests") func parameterTests() async throws {
        #expect(getChunkSize(max: 4, remaining: 2) == 2)
        #expect(getChunkSize(max: 2, remaining: 2) == 2)
        #expect(getChunkSize(max: 2, remaining: 4) == 2)
        #expect(getChunkSize(max: 0, remaining: 0) == 0)
        #expect(getChunkSize(max: 3, remaining: -1) == -1)
    }
}
