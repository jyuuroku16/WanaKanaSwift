import Testing
@testable import WanaKanaSwift

@Suite("IsCharJapanesePunctuationTests")
final class IsCharJapanesePunctuationTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(isCharJapanesePunctuation() == false)
        #expect(isCharJapanesePunctuation("") == false)
    }

    @Test("passes parameter tests") func parameterTests() async throws {
        let japanesePunctuation = ["！", "？", "。", "：", "・", "、", "〜", "ー", "「", "」", "『", "』", "［", "］", "（", "）", "｛", "｝"]
        let englishPunctuation = ["!", "?", ".", ":", "/", ",", "~", "-", "\"", "\"", "\"", "\"", "[", "]", "(", ")", "{", "}"]

        for char in japanesePunctuation {
            #expect(isCharJapanesePunctuation(char) == true)
        }
        for char in englishPunctuation {
            #expect(isCharJapanesePunctuation(char) == false)
        }

        #expect(isCharJapanesePunctuation("　") == true)
        #expect(isCharJapanesePunctuation("?") == false)
        #expect(isCharJapanesePunctuation("a") == false)
        #expect(isCharJapanesePunctuation("ふ") == false)
        #expect(isCharJapanesePunctuation("字") == false)
    }
}
