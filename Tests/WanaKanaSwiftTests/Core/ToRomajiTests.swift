import Testing
@testable import WanaKanaSwift

@Suite("ToRomajiTests")
final class ToRomajiTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(WanaKanaSwift.toRomaji() == "")
        #expect(WanaKanaSwift.toRomaji("") == "")
    }

    @Test("Convert katakana to romaji") func katakanaToRomaji() async throws {
        #expect(WanaKanaSwift.toRomaji("ワニカニ　ガ　スゴイ　ダ") == "wanikani ga sugoi da")
    }

    @Test("Convert hiragana to romaji") func hiraganaToRomaji() async throws {
        #expect(WanaKanaSwift.toRomaji("わにかに　が　すごい　だ") == "wanikani ga sugoi da")
    }

    @Test("Convert mixed kana to romaji") func mixedKanaToRomaji() async throws {
        #expect(WanaKanaSwift.toRomaji("ワニカニ　が　すごい　だ") == "wanikani ga sugoi da")
    }

    @Test("Will convert punctuation and full-width spaces") func punctuationAndSpaces() async throws {
        #expect(WanaKanaSwift.toRomaji(JA_PUNC.joined(separator: "")) == EN_PUNC.joined(separator: ""))
    }

    @Test("Use the upcaseKatakana flag to preserve casing for katakana") func upcaseKatakanaFlag() async throws {
        #expect(WanaKanaSwift.toRomaji("ワニカニ", options: ["upcaseKatakana": true]) == "WANIKANI")
    }

    @Test("Use the upcaseKatakana flag to preserve casing for mixed kana") func upcaseKatakanaMixed() async throws {
        #expect(WanaKanaSwift.toRomaji("ワニカニ　が　すごい　だ", options: ["upcaseKatakana": true]) == "WANIKANI ga sugoi da")
    }

    @Test("Converts long dash 'ー' in hiragana to hyphen") func longDashToHyphen() async throws {
        #expect(WanaKanaSwift.toRomaji("ばつげーむ") == "batsuge-mu")
    }

    @Test("Doesn't confuse '一' (one kanji) for long dash 'ー'") func oneKanjiVsLongDash() async throws {
        #expect(WanaKanaSwift.toRomaji("一抹げーむ") == "一抹ge-mu")
    }

    @Test("Converts long dash 'ー' (chōonpu) in katakana to long vowel") func longDashToLongVowel() async throws {
        #expect(WanaKanaSwift.toRomaji("スーパー") == "suupaa")
    }

    @Test("Doesn't convert オー to 'ou' which occurs with hiragana") func katakanaOLongDash() async throws {
        #expect(WanaKanaSwift.toRomaji("缶コーヒー") == "缶koohii")
    }

    @Test("Spaces must be manually entered") func manualSpaces() async throws {
        #expect(WanaKanaSwift.toRomaji("わにかにがすごいだ") != "wanikani ga sugoi da")
    }

    @Test("Double and single n") func doubleAndSingleN() async throws {
        #expect(WanaKanaSwift.toRomaji("きんにくまん") == "kinnikuman")
    }

    @Test("N extravaganza") func nExtravaganza() async throws {
        #expect(WanaKanaSwift.toRomaji("んんにんにんにゃんやん") == "nnninninnyan'yan")
    }

    @Test("Double consonants") func doubleConsonants() async throws {
        #expect(WanaKanaSwift.toRomaji("かっぱ　たった　しゅっしゅ ちゃっちゃ　やっつ") == "kappa tatta shusshu chatcha yattsu")
    }

    @Test("Small kana") func smallKana() async throws {
        #expect(WanaKanaSwift.toRomaji("っ") == "")
        #expect(WanaKanaSwift.toRomaji("ヶ") == "ヶ")
        #expect(WanaKanaSwift.toRomaji("ヵ") == "ヵ")
        #expect(WanaKanaSwift.toRomaji("ゃ") == "ya")
        #expect(WanaKanaSwift.toRomaji("ゅ") == "yu")
        #expect(WanaKanaSwift.toRomaji("ょ") == "yo")
        #expect(WanaKanaSwift.toRomaji("ぁ") == "a")
        #expect(WanaKanaSwift.toRomaji("ぃ") == "i")
        #expect(WanaKanaSwift.toRomaji("ぅ") == "u")
        #expect(WanaKanaSwift.toRomaji("ぇ") == "e")
        #expect(WanaKanaSwift.toRomaji("ぉ") == "o")
    }

    @Test("Apostrophes in ambiguous consonant vowel combos") func apostrophes() async throws {
        #expect(WanaKanaSwift.toRomaji("おんよみ") == "on'yomi")
        #expect(WanaKanaSwift.toRomaji("んよ んあ んゆ") == "n'yo n'a n'yu")
        #expect(WanaKanaSwift.toRomaji("シンヨ") == "shin'yo")
    }
}
