import Testing
@testable import WanaKanaSwift

@Suite("GetChunkSizeTests")
final class GetChunkSizeTests {
    @Test("sane default") func saneDefault() async throws {
        #expect(getChunkSize(nil, nil) == 0)
    }

    @Test("passes parameter tests") func parameterTests() async throws {
        #expect(getChunkSize(4, 2) == 2)
        #expect(getChunkSize(2, 2) == 2)
        #expect(getChunkSize(2, 4) == 2)
        #expect(getChunkSize(0, 0) == 0)
        #expect(getChunkSize(3, -1) == -1)
    }
}
