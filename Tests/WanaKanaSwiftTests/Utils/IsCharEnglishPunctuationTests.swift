import Testing
@testable import WanaKanaSwift

@Suite("IsCharEnglishPunctuationTests")
final class IsCharEnglishPunctuationTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(isCharEnglishPunctuation() == false)
        #expect(isCharEnglishPunctuation("") == false)
    }

    @Test("passes parameter tests") func parameterTests() async throws {
        let japanesePunctuation = ["！", "？", "。", "：", "・", "、", "〜", "ー", "「", "」", "『", "』", "［", "］", "（", "）", "｛", "｝"]
        let englishPunctuation = ["!", "?", ".", ":", "/", ",", "~", "-", "\"", "\"", "\"", "\"", "[", "]", "(", ")", "{", "}"]

        for char in englishPunctuation {
            #expect(isCharEnglishPunctuation(char) == true)
        }
        for char in japanesePunctuation {
            #expect(isCharEnglishPunctuation(char) == false)
        }

        #expect(isCharEnglishPunctuation(" ") == true)
        #expect(isCharEnglishPunctuation("a") == false)
        #expect(isCharEnglishPunctuation("ふ") == false)
        #expect(isCharEnglishPunctuation("字") == false)
    }
}
