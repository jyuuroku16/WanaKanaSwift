import Testing
@testable import WanaKanaSwift

@Suite("ConversionsTests")
final class ConversionsTests {
    @Test("test every conversion table char - toKana") func testToKanaConversions() async throws {
        for item in ROMA_TO_HIRA_KATA {
            let romaji = item[0]
            let hiragana = item[1]
            let katakana = item[2]

            let lower = WanaKanaSwift.toKana(romaji)
            let upper = WanaKanaSwift.toKana(romaji.uppercased())

            #expect(lower == hiragana)
            #expect(upper == katakana)
        }
    }

    @Test("test every conversion table char - toHiragana") func testToHiraganaConversions() async throws {
        for item in ROMA_TO_HIRA_KATA {
            let romaji = item[0]
            let hiragana = item[1]

            let lower = WanaKanaSwift.toHiragana(romaji)
            let upper = WanaKanaSwift.toHiragana(romaji.uppercased())

            #expect(lower == hiragana)
            #expect(upper == hiragana)
        }
    }

    @Test("test every conversion table char - toKatakana") func testToKatakanaConversions() async throws {
        for item in ROMA_TO_HIRA_KATA {
            let romaji = item[0]
            let katakana = item[2]

            let lower = WanaKanaSwift.toKatakana(romaji)
            let upper = WanaKanaSwift.toKatakana(romaji.uppercased())

            #expect(lower == katakana)
            #expect(upper == katakana)
        }
    }

    @Test("test every conversion table char - Hiragana input toRomaji") func testHiraganaToRomajiConversions() async throws {
        for item in HIRA_KATA_TO_ROMA {
            let hiragana = item[0]
            let romaji = item[2]

            if !hiragana.isEmpty {
                let result = WanaKanaSwift.toRomaji(hiragana)
                #expect(result == romaji)
            }
        }
    }

    @Test("test every conversion table char - Katakana input toRomaji") func testKatakanaToRomajiConversions() async throws {
        for item in HIRA_KATA_TO_ROMA {
            let katakana = item[1]
            let romaji = item[2]

            if !katakana.isEmpty {
                let result = WanaKanaSwift.toRomaji(katakana)
                #expect(result == romaji)
            }
        }
    }

    @Test("Converting kana to kana") func testKanaToKanaConversions() async throws {
        // k -> h
        #expect(WanaKanaSwift.toHiragana("バケル") == "ばける")
        // h -> k
        #expect(WanaKanaSwift.toKatakana("ばける") == "バケル")

        // It survives only katakana toKatakana
        #expect(WanaKanaSwift.toKatakana("スタイル") == "スタイル")
        // It survives only hiragana toHiragana
        #expect(WanaKanaSwift.toHiragana("すたーいる") == "すたーいる")
        // Mixed kana converts every char k -> h
        #expect(WanaKanaSwift.toKatakana("アメリカじん") == "アメリカジン")
        // Mixed kana converts every char h -> k
        #expect(WanaKanaSwift.toHiragana("アメリカじん") == "あめりかじん")
    }

    @Test("Converting kana to kana - long vowels") func testKanaToKanaLongVowels() async throws {
        // Converts long vowels correctly from k -> h
        #expect(WanaKanaSwift.toHiragana("バツゴー") == "ばつごう")
        // Preserves long dash from h -> k
        #expect(WanaKanaSwift.toKatakana("ばつゲーム") == "バツゲーム")
        // Preserves long dash from h -> h
        #expect(WanaKanaSwift.toHiragana("ばつげーむ") == "ばつげーむ")
        // Preserves long dash from k -> k
        #expect(WanaKanaSwift.toKatakana("バツゲーム") == "バツゲーム")
        // Preserves long dash from mixed -> k
        #expect(WanaKanaSwift.toKatakana("バツゲーム") == "バツゲーム")
        #expect(WanaKanaSwift.toKatakana("テスーと") == "テスート")
        // Preserves long dash from mixed -> h
        #expect(WanaKanaSwift.toHiragana("てすート") == "てすーと")
        #expect(WanaKanaSwift.toHiragana("てすー戸") == "てすー戸")
        #expect(WanaKanaSwift.toHiragana("手巣ート") == "手巣ーと")
        #expect(WanaKanaSwift.toHiragana("tesート") == "てsーと")
        #expect(WanaKanaSwift.toHiragana("ートtesu") == "ーとてす")
    }

    @Test("Converting kana to kana - Mixed syllabaries") func testKanaToKanaMixedSyllabaries() async throws {
        // It passes non-katakana through when passRomaji is true k -> h
        #expect(WanaKanaSwift.toHiragana("座禅‘zazen’スタイル", options: ["passRomaji": true]) == "座禅‘zazen’すたいる")

        // It passes non-hiragana through when passRomaji is true h -> k
        #expect(WanaKanaSwift.toKatakana("座禅‘zazen’すたいる", options: ["passRomaji": true]) == "座禅‘zazen’スタイル")

        // It converts non-katakana when passRomaji is false k -> h
        #expect(WanaKanaSwift.toHiragana("座禅‘zazen’スタイル") == "座禅「ざぜん」すたいる")

        // It converts non-hiragana when passRomaji is false h -> k
        #expect(WanaKanaSwift.toKatakana("座禅‘zazen’すたいる") == "座禅「ザゼン」スタイル")
    }

    @Test("Case sensitivity") func testCaseSensitivity() async throws {
        // Case doesn't matter for toHiragana()
        #expect(WanaKanaSwift.toHiragana("aiueo") == WanaKanaSwift.toHiragana("AIUEO"))
        // Case doesn't matter for toKatakana()
        #expect(WanaKanaSwift.toKatakana("aiueo") == WanaKanaSwift.toKatakana("AIUEO"))
        // Case DOES matter for toKana()
        #expect(WanaKanaSwift.toKana("aiueo") != WanaKanaSwift.toKana("AIUEO"))
    }

    @Test("N edge cases") func testNEdgeCases() async throws {
        // Solo N
        #expect(WanaKanaSwift.toKana("n") == "ん")
        // double N
        #expect(WanaKanaSwift.toKana("onn") == "おんん")
        // N followed by N* syllable
        #expect(WanaKanaSwift.toKana("onna") == "おんな")
        // Triple N
        #expect(WanaKanaSwift.toKana("nnn") == "んんん")
        // Triple N followed by N* syllable
        #expect(WanaKanaSwift.toKana("onnna") == "おんんな")
        // Quadruple N
        #expect(WanaKanaSwift.toKana("nnnn") == "んんんん")
        // nya -> にゃ
        #expect(WanaKanaSwift.toKana("nyan") == "にゃん")
        // nnya -> んにゃ
        #expect(WanaKanaSwift.toKana("nnyann") == "んにゃんん")
        // nnnya -> んにゃ
        #expect(WanaKanaSwift.toKana("nnnyannn") == "んんにゃんんん")
        // n'ya -> んや
        #expect(WanaKanaSwift.toKana("n'ya") == "んや")
        // kin'ya -> きんや
        #expect(WanaKanaSwift.toKana("kin'ya") == "きんや")
        // shin'ya -> しんや
        #expect(WanaKanaSwift.toKana("shin'ya") == "しんや")
        // kinyou -> きにょう
        #expect(WanaKanaSwift.toKana("kinyou") == "きにょう")
        // kin'you -> きんよう
        #expect(WanaKanaSwift.toKana("kin'you") == "きんよう")
        // kin'yu -> きんゆ
        #expect(WanaKanaSwift.toKana("kin'yu") == "きんゆ")
        // Properly add space after "n[space]"
        #expect(WanaKanaSwift.toKana("ichiban warui") == "いちばん わるい")
    }

    @Test("Bogus 4 character sequences") func testBogusSequences() async throws {
        // Non bogus sequences work
        #expect(WanaKanaSwift.toKana("chya") == "ちゃ")
        // Bogus sequences do not work
        #expect(WanaKanaSwift.toKana("chyx") == "chyx")
        #expect(WanaKanaSwift.toKana("shyp") == "shyp")
        #expect(WanaKanaSwift.toKana("ltsb") == "ltsb")
    }
}
