import Testing
@testable import WanaKanaSwift

@Suite("IsCharRomajiTests")
final class IsCharRomajiTests {
    @Test("sane default") func saneDefault() async throws {
        #expect(isCharRomaji(nil) == false)
    }

    @Test("passes parameter tests") func parameterTests() async throws {
        #expect(isCharRomaji("n") == true)
        #expect(isCharRomaji("!") == true)
        #expect(isCharRomaji("ナ") == false)
        #expect(isCharRomaji("は") == false)
        #expect(isCharRomaji("缶") == false)
        #expect(isCharRomaji("") == false)
    }
}
