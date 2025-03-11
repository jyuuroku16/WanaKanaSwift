import Testing
@testable import WanaKanaSwift

@Suite("IsCharPunctuationTests")
final class IsCharPunctuationTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(isCharPunctuation(nil) == false)
        #expect(isCharPunctuation("") == false)
    }

    @Test("passes parameter tests") func parameterTests() async throws {
        let japanesePunctuation = ["！", "？", "。", "：", "・", "、", "〜", "ー", "「", "」", "『", "』", "［", "］", "（", "）", "｛", "｝"]
        let englishPunctuation = ["!", "?", ".", ":", "/", ",", "~", "-", "\"", "\"", "\"", "\"", "[", "]", "(", ")", "{", "}"]

        for char in japanesePunctuation {
            #expect(isCharPunctuation(char) == true)
        }
        for char in englishPunctuation {
            #expect(isCharPunctuation(char) == true)
        }

        #expect(isCharPunctuation(" ") == true)
        #expect(isCharPunctuation("　") == true)
        #expect(isCharPunctuation("a") == false)
        #expect(isCharPunctuation("ふ") == false)
        #expect(isCharPunctuation("字") == false)
        #expect(isCharPunctuation("々") == false)
    }
}
