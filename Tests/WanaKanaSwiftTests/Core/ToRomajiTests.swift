import Testing
@testable import WanaKanaSwift

@Suite("ToRomajiTests")
final class ToRomajiTests {
    @Test("sane defaults") func saneDefaults() async throws {
        #expect(WanaKana.toRomaji() == "")
        #expect(WanaKana.toRomaji("") == "")
    }

    @Test("Convert katakana to romaji") func katakanaToRomaji() async throws {
        #expect(WanaKana.toRomaji("ワニカニ　ガ　スゴイ　ダ") == "wanikani ga sugoi da")
    }

    @Test("Convert hiragana to romaji") func hiraganaToRomaji() async throws {
        #expect(WanaKana.toRomaji("わにかに　が　すごい　だ") == "wanikani ga sugoi da")
    }

    @Test("Convert mixed kana to romaji") func mixedKanaToRomaji() async throws {
        #expect(WanaKana.toRomaji("ワニカニ　が　すごい　だ") == "wanikani ga sugoi da")
    }

    @Test("Will convert punctuation and full-width spaces") func punctuationAndSpaces() async throws {
        #expect(WanaKana.toRomaji("！？。：・、〜ー「」『』［］（）｛｝") == "!?.:/,~-\"\"\"\"[](){}")
    }

    @Test("Use the upcaseKatakana flag to preserve casing for katakana") func upcaseKatakanaFlag() async throws {
        #expect(WanaKana.toRomaji("ワニカニ", options: ToRomajiOptions(upcaseKatakana: true)) == "WANIKANI")
    }

    @Test("Use the upcaseKatakana flag to preserve casing for mixed kana") func upcaseKatakanaMixed() async throws {
        #expect(WanaKana.toRomaji("ワニカニ　が　すごい　だ", options: ToRomajiOptions(upcaseKatakana: true)) == "WANIKANI ga sugoi da")
    }

    @Test("Converts long dash 'ー' in hiragana to hyphen") func longDashToHyphen() async throws {
        #expect(WanaKana.toRomaji("ばつげーむ") == "batsuge-mu")
    }

    @Test("Doesn't confuse '一' (one kanji) for long dash 'ー'") func oneKanjiVsLongDash() async throws {
        #expect(WanaKana.toRomaji("一抹げーむ") == "一抹ge-mu")
    }

    @Test("Converts long dash 'ー' (chōonpu) in katakana to long vowel") func longDashToLongVowel() async throws {
        #expect(WanaKana.toRomaji("スーパー") == "suupaa")
    }

    @Test("Doesn't convert オー to 'ou' which occurs with hiragana") func katakanaOLongDash() async throws {
        #expect(WanaKana.toRomaji("缶コーヒー") == "缶koohii")
    }

    @Test("Spaces must be manually entered") func manualSpaces() async throws {
        #expect(WanaKana.toRomaji("わにかにがすごいだ") != "wanikani ga sugoi da")
    }

    @Test("Double and single n") func doubleAndSingleN() async throws {
        #expect(WanaKana.toRomaji("きんにくまん") == "kinnikuman")
    }

    @Test("N extravaganza") func nExtravaganza() async throws {
        #expect(WanaKana.toRomaji("んんにんにんにゃんやん") == "nnninninnyan'yan")
    }

    @Test("Double consonants") func doubleConsonants() async throws {
        #expect(WanaKana.toRomaji("かっぱ　たった　しゅっしゅ ちゃっちゃ　やっつ") == "kappa tatta shusshu chatcha yattsu")
    }

    @Test("Small kana") func smallKana() async throws {
        #expect(WanaKana.toRomaji("っ") == "")
        #expect(WanaKana.toRomaji("ヶ") == "ヶ")
        #expect(WanaKana.toRomaji("ヵ") == "ヵ")
        #expect(WanaKana.toRomaji("ゃ") == "ya")
        #expect(WanaKana.toRomaji("ゅ") == "yu")
        #expect(WanaKana.toRomaji("ょ") == "yo")
        #expect(WanaKana.toRomaji("ぁ") == "a")
        #expect(WanaKana.toRomaji("ぃ") == "i")
        #expect(WanaKana.toRomaji("ぅ") == "u")
        #expect(WanaKana.toRomaji("ぇ") == "e")
        #expect(WanaKana.toRomaji("ぉ") == "o")
    }

    @Test("Apostrophes in ambiguous consonant vowel combos") func apostrophes() async throws {
        #expect(WanaKana.toRomaji("おんよみ") == "on'yomi")
        #expect(WanaKana.toRomaji("んよ んあ んゆ") == "n'yo n'a n'yu")
        #expect(WanaKana.toRomaji("シンヨ") == "shin'yo")
    }
}
