import Testing
@testable import WanaKanaSwift

@Suite("ConversionsTests")
final class ConversionsTests {
    @Test("test every conversion table char - toKana") func testToKanaConversions() async throws {
        for item in ROMA_TO_HIRA_KATA {
            let romaji = item[0]
            let hiragana = item[1]
            let katakana = item[2]

            let lower = WanaKana.toKana(romaji)
            let upper = WanaKana.toKana(romaji.uppercased())

            #expect(lower == hiragana)
            #expect(upper == katakana)
        }
    }

    @Test("test every conversion table char - toHiragana") func testToHiraganaConversions() async throws {
        for item in ROMA_TO_HIRA_KATA {
            let romaji = item[0]
            let hiragana = item[1]

            let lower = WanaKana.toHiragana(romaji)
            let upper = WanaKana.toHiragana(romaji.uppercased())

            #expect(lower == hiragana)
            #expect(upper == hiragana)
        }
    }

    @Test("test every conversion table char - toKatakana") func testToKatakanaConversions() async throws {
        for item in ROMA_TO_HIRA_KATA {
            let romaji = item[0]
            let katakana = item[2]

            let lower = WanaKana.toKatakana(romaji)
            let upper = WanaKana.toKatakana(romaji.uppercased())

            #expect(lower == katakana)
            #expect(upper == katakana)
        }
    }

    @Test("test every conversion table char - Hiragana input toRomaji") func testHiraganaToRomajiConversions() async throws {
        for item in HIRA_KATA_TO_ROMA {
            let hiragana = item[0]
            let romaji = item[2]

            if !hiragana.isEmpty {
                let result = WanaKana.toRomaji(hiragana)
                #expect(result == romaji)
            }
        }
    }

    @Test("test every conversion table char - Katakana input toRomaji") func testKatakanaToRomajiConversions() async throws {
        for item in HIRA_KATA_TO_ROMA {
            let katakana = item[1]
            let romaji = item[2]

            if !katakana.isEmpty {
                let result = WanaKana.toRomaji(katakana)
                #expect(result == romaji)
            }
        }
    }

    @Test("Converting kana to kana") func testKanaToKanaConversions() async throws {
        // k -> h
        #expect(WanaKana.toHiragana("バケル") == "ばける")
        // h -> k
        #expect(WanaKana.toKatakana("ばける") == "バケル")

        // It survives only katakana toKatakana
        #expect(WanaKana.toKatakana("スタイル") == "スタイル")
        // It survives only hiragana toHiragana
        #expect(WanaKana.toHiragana("すたーいる") == "すたーいる")
        // Mixed kana converts every char k -> h
        #expect(WanaKana.toKatakana("アメリカじん") == "アメリカジン")
        // Mixed kana converts every char h -> k
        #expect(WanaKana.toHiragana("アメリカじん") == "あめりかじん")
    }

    @Test("Converting kana to kana - long vowels") func testKanaToKanaLongVowels() async throws {
        // Converts long vowels correctly from k -> h
        #expect(WanaKana.toHiragana("バツゴー") == "ばつごう")
        // Preserves long dash from h -> k
        #expect(WanaKana.toKatakana("ばつゲーム") == "バツゲーム")
        // Preserves long dash from h -> h
        #expect(WanaKana.toHiragana("ばつげーむ") == "ばつげーむ")
        // Preserves long dash from k -> k
        #expect(WanaKana.toKatakana("バツゲーム") == "バツゲーム")
        // Preserves long dash from mixed -> k
        #expect(WanaKana.toKatakana("バツゲーム") == "バツゲーム")
        #expect(WanaKana.toKatakana("テスーと") == "テスート")
        // Preserves long dash from mixed -> h
        #expect(WanaKana.toHiragana("てすート") == "てすーと")
        #expect(WanaKana.toHiragana("てすー戸") == "てすー戸")
        #expect(WanaKana.toHiragana("手巣ート") == "手巣ーと")
        #expect(WanaKana.toHiragana("tesート") == "てsーと")
        #expect(WanaKana.toHiragana("ートtesu") == "ーとてす")
    }

    @Test("Converting kana to kana - Mixed syllabaries") func testKanaToKanaMixedSyllabaries() async throws {
        // It passes non-katakana through when passRomaji is true k -> h
        #expect(WanaKana.toHiragana("座禅‘zazen’スタイル", options: ["passRomaji": true]) == "座禅‘zazen’すたいる")

        // It passes non-hiragana through when passRomaji is true h -> k
        #expect(WanaKana.toKatakana("座禅‘zazen’すたいる", options: ["passRomaji": true]) == "座禅‘zazen’スタイル")

        // It converts non-katakana when passRomaji is false k -> h
        #expect(WanaKana.toHiragana("座禅‘zazen’スタイル") == "座禅「ざぜん」すたいる")

        // It converts non-hiragana when passRomaji is false h -> k
        #expect(WanaKana.toKatakana("座禅‘zazen’すたいる") == "座禅「ザゼン」スタイル")
    }

    @Test("Case sensitivity") func testCaseSensitivity() async throws {
        // Case doesn't matter for toHiragana()
        #expect(WanaKana.toHiragana("aiueo") == WanaKana.toHiragana("AIUEO"))
        // Case doesn't matter for toKatakana()
        #expect(WanaKana.toKatakana("aiueo") == WanaKana.toKatakana("AIUEO"))
        // Case DOES matter for toKana()
        #expect(WanaKana.toKana("aiueo") != WanaKana.toKana("AIUEO"))
    }

    @Test("N edge cases") func testNEdgeCases() async throws {
        // Solo N
        #expect(WanaKana.toKana("n") == "ん")
        // double N
        #expect(WanaKana.toKana("onn") == "おんん")
        // N followed by N* syllable
        #expect(WanaKana.toKana("onna") == "おんな")
        // Triple N
        #expect(WanaKana.toKana("nnn") == "んんん")
        // Triple N followed by N* syllable
        #expect(WanaKana.toKana("onnna") == "おんんな")
        // Quadruple N
        #expect(WanaKana.toKana("nnnn") == "んんんん")
        // nya -> にゃ
        #expect(WanaKana.toKana("nyan") == "にゃん")
        // nnya -> んにゃ
        #expect(WanaKana.toKana("nnyann") == "んにゃんん")
        // nnnya -> んにゃ
        #expect(WanaKana.toKana("nnnyannn") == "んんにゃんんん")
        // n'ya -> んや
        #expect(WanaKana.toKana("n'ya") == "んや")
        // kin'ya -> きんや
        #expect(WanaKana.toKana("kin'ya") == "きんや")
        // shin'ya -> しんや
        #expect(WanaKana.toKana("shin'ya") == "しんや")
        // kinyou -> きにょう
        #expect(WanaKana.toKana("kinyou") == "きにょう")
        // kin'you -> きんよう
        #expect(WanaKana.toKana("kin'you") == "きんよう")
        // kin'yu -> きんゆ
        #expect(WanaKana.toKana("kin'yu") == "きんゆ")
        // Properly add space after "n[space]"
        #expect(WanaKana.toKana("ichiban warui") == "いちばん わるい")
    }

    @Test("Bogus 4 character sequences") func testBogusSequences() async throws {
        // Non bogus sequences work
        #expect(WanaKana.toKana("chya") == "ちゃ")
        // Bogus sequences do not work
        #expect(WanaKana.toKana("chyx") == "chyx")
        #expect(WanaKana.toKana("shyp") == "shyp")
        #expect(WanaKana.toKana("ltsb") == "ltsb")
    }
}
