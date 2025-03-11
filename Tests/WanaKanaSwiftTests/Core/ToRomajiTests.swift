import Testing
@testable import WanaKanaSwift

@Suite("ToRomajiTests")
final class ToRomajiTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(toRomaji(nil) == "")
        #expect(toRomaji("") == "")
    }

    @Test("Convert katakana to romaji") func katakanaToRomaji() async throws {
        #expect(toRomaji("ワニカニ　ガ　スゴイ　ダ") == "wanikani ga sugoi da")
    }

    @Test("Convert hiragana to romaji") func hiraganaToRomaji() async throws {
        #expect(toRomaji("わにかに　が　すごい　だ") == "wanikani ga sugoi da")
    }

    @Test("Convert mixed kana to romaji") func mixedKanaToRomaji() async throws {
        #expect(toRomaji("ワニカニ　が　すごい　だ") == "wanikani ga sugoi da")
    }

    @Test("Will convert punctuation and full-width spaces") func punctuationAndSpaces() async throws {
        #expect(toRomaji("！？。：・、〜ー「」『』［］（）｛｝") == "!?.:/,~-\"\"\"\"[](){}")
    }

    @Test("Use the upcaseKatakana flag to preserve casing for katakana") func upcaseKatakanaFlag() async throws {
        #expect(toRomaji("ワニカニ", options: ToRomajiOptions(upcaseKatakana: true)) == "WANIKANI")
    }

    @Test("Use the upcaseKatakana flag to preserve casing for mixed kana") func upcaseKatakanaMixed() async throws {
        #expect(toRomaji("ワニカニ　が　すごい　だ", options: ToRomajiOptions(upcaseKatakana: true)) == "WANIKANI ga sugoi da")
    }

    @Test("Converts long dash 'ー' in hiragana to hyphen") func longDashToHyphen() async throws {
        #expect(toRomaji("ばつげーむ") == "batsuge-mu")
    }

    @Test("Doesn't confuse '一' (one kanji) for long dash 'ー'") func oneKanjiVsLongDash() async throws {
        #expect(toRomaji("一抹げーむ") == "一抹ge-mu")
    }

    @Test("Converts long dash 'ー' (chōonpu) in katakana to long vowel") func longDashToLongVowel() async throws {
        #expect(toRomaji("スーパー") == "suupaa")
    }

    @Test("Doesn't convert オー to 'ou' which occurs with hiragana") func katakanaOLongDash() async throws {
        #expect(toRomaji("缶コーヒー") == "缶koohii")
    }

    @Test("Spaces must be manually entered") func manualSpaces() async throws {
        #expect(toRomaji("わにかにがすごいだ") != "wanikani ga sugoi da")
    }

    @Test("Double and single n") func doubleAndSingleN() async throws {
        #expect(toRomaji("きんにくまん") == "kinnikuman")
    }

    @Test("N extravaganza") func nExtravaganza() async throws {
        #expect(toRomaji("んんにんにんにゃんやん") == "nnninninnyan'yan")
    }

    @Test("Double consonants") func doubleConsonants() async throws {
        #expect(toRomaji("かっぱ　たった　しゅっしゅ ちゃっちゃ　やっつ") == "kappa tatta shusshu chatcha yattsu")
    }

    @Test("Small kana") func smallKana() async throws {
        #expect(toRomaji("っ") == "")
        #expect(toRomaji("ヶ") == "ヶ")
        #expect(toRomaji("ヵ") == "ヵ")
        #expect(toRomaji("ゃ") == "ya")
        #expect(toRomaji("ゅ") == "yu")
        #expect(toRomaji("ょ") == "yo")
        #expect(toRomaji("ぁ") == "a")
        #expect(toRomaji("ぃ") == "i")
        #expect(toRomaji("ぅ") == "u")
        #expect(toRomaji("ぇ") == "e")
        #expect(toRomaji("ぉ") == "o")
    }

    @Test("Apostrophes in ambiguous consonant vowel combos") func apostrophes() async throws {
        #expect(toRomaji("おんよみ") == "on'yomi")
        #expect(toRomaji("んよ んあ んゆ") == "n'yo n'a n'yu")
        #expect(toRomaji("シンヨ") == "shin'yo")
    }
}
