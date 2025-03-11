import Testing
@testable import WanaKanaSwift

@Suite("GetChunkTests")
final class GetChunkTests {
    @Test("sane default") func saneDefault() async throws {
        #expect(getChunk() == "")
    }

    @Test("passes parameter tests") func parameterTests() async throws {
        #expect(getChunk("derpalerp", start: 3, end: 6) == "pal")
        #expect(getChunk("de", start: 0, end: 1) == "d")
        #expect(getChunk("", start: 1, end: 2) == "")
    }
}
