import Testing
@testable import WanaKanaSwift

@Suite("ConversionsTests")
final class ConversionsTests {
    @Test("test every conversion table char - toKana") func testToKanaConversions() async throws {
        for item in ROMA_TO_HIRA_KATA {
            let romaji = item[0]
            let hiragana = item[1]
            let katakana = item[2]

            let lower = toKana(romaji)
            let upper = toKana(romaji.uppercased())

            #expect(lower == hiragana)
            #expect(upper == katakana)
        }
    }

    @Test("test every conversion table char - toHiragana") func testToHiraganaConversions() async throws {
        for item in ROMA_TO_HIRA_KATA {
            let romaji = item[0]
            let hiragana = item[1]

            let lower = toHiragana(romaji)
            let upper = toHiragana(romaji.uppercased())

            #expect(lower == hiragana)
            #expect(upper == hiragana)
        }
    }

    @Test("test every conversion table char - toKatakana") func testToKatakanaConversions() async throws {
        for item in ROMA_TO_HIRA_KATA {
            let romaji = item[0]
            let katakana = item[2]

            let lower = toKatakana(romaji)
            let upper = toKatakana(romaji.uppercased())

            #expect(lower == katakana)
            #expect(upper == katakana)
        }
    }

    @Test("test every conversion table char - Hiragana input toRomaji") func testHiraganaToRomajiConversions() async throws {
        for item in HIRA_KATA_TO_ROMA {
            let hiragana = item[0]
            let romaji = item[2]

            if !hiragana.isEmpty {
                let result = toRomaji(hiragana)
                #expect(result == romaji)
            }
        }
    }

    @Test("test every conversion table char - Katakana input toRomaji") func testKatakanaToRomajiConversions() async throws {
        for item in HIRA_KATA_TO_ROMA {
            let katakana = item[1]
            let romaji = item[2]

            if !katakana.isEmpty {
                let result = toRomaji(katakana)
                #expect(result == romaji)
            }
        }
    }

    @Test("Converting kana to kana") func testKanaToKanaConversions() async throws {
        // k -> h
        #expect(toHiragana("バケル") == "ばける")
        // h -> k
        #expect(toKatakana("ばける") == "バケル")

        // It survives only katakana toKatakana
        #expect(toKatakana("スタイル") == "スタイル")
        // It survives only hiragana toHiragana
        #expect(toHiragana("すたーいる") == "すたーいる")
        // Mixed kana converts every char k -> h
        #expect(toKatakana("アメリカじん") == "アメリカジン")
        // Mixed kana converts every char h -> k
        #expect(toHiragana("アメリカじん") == "あめりかじん")
    }

    @Test("Converting kana to kana - long vowels") func testKanaToKanaLongVowels() async throws {
        // Converts long vowels correctly from k -> h
        #expect(toHiragana("バツゴー") == "ばつごう")
        // Preserves long dash from h -> k
        #expect(toKatakana("ばつゲーム") == "バツゲーム")
        // Preserves long dash from h -> h
        #expect(toHiragana("ばつげーむ") == "ばつげーむ")
        // Preserves long dash from k -> k
        #expect(toKatakana("バツゲーム") == "バツゲーム")
        // Preserves long dash from mixed -> k
        #expect(toKatakana("バツゲーム") == "バツゲーム")
        #expect(toKatakana("テスーと") == "テスート")
        // Preserves long dash from mixed -> h
        #expect(toHiragana("てすート") == "てすーと")
        #expect(toHiragana("てすー戸") == "てすー戸")
        #expect(toHiragana("手巣ート") == "手巣ーと")
        #expect(toHiragana("tesート") == "てsーと")
        #expect(toHiragana("ートtesu") == "ーとてす")
    }

    @Test("Converting kana to kana - Mixed syllabaries") func testKanaToKanaMixedSyllabaries() async throws {
        // It passes non-katakana through when passRomaji is true k -> h
        #expect(toHiragana("座禅'zazen'スタイル", options: ToHiraganaOptions(passRomaji: true)) == "座禅'zazen'すたいる")

        // It passes non-hiragana through when passRomaji is true h -> k
        #expect(toKatakana("座禅'zazen'すたいる", options: ToKatakanaOptions(passRomaji: true)) == "座禅'zazen'スタイル")

        // It converts non-katakana when passRomaji is false k -> h
        #expect(toHiragana("座禅'zazen'スタイル") == "座禅「ざぜん」すたいる")

        // It converts non-hiragana when passRomaji is false h -> k
        #expect(toKatakana("座禅'zazen'すたいる") == "座禅「ザゼン」スタイル")
    }

    @Test("Case sensitivity") func testCaseSensitivity() async throws {
        // Case doesn't matter for toHiragana()
        #expect(toHiragana("aiueo") == toHiragana("AIUEO"))
        // Case doesn't matter for toKatakana()
        #expect(toKatakana("aiueo") == toKatakana("AIUEO"))
        // Case DOES matter for toKana()
        #expect(toKana("aiueo") != toKana("AIUEO"))
    }

    @Test("N edge cases") func testNEdgeCases() async throws {
        // Solo N
        #expect(toKana("n") == "ん")
        // double N
        #expect(toKana("onn") == "おんん")
        // N followed by N* syllable
        #expect(toKana("onna") == "おんな")
        // Triple N
        #expect(toKana("nnn") == "んんん")
        // Triple N followed by N* syllable
        #expect(toKana("onnna") == "おんんな")
        // Quadruple N
        #expect(toKana("nnnn") == "んんんん")
        // nya -> にゃ
        #expect(toKana("nyan") == "にゃん")
        // nnya -> んにゃ
        #expect(toKana("nnyann") == "んにゃんん")
        // nnnya -> んにゃ
        #expect(toKana("nnnyannn") == "んんにゃんんん")
        // n'ya -> んや
        #expect(toKana("n'ya") == "んや")
        // kin'ya -> きんや
        #expect(toKana("kin'ya") == "きんや")
        // shin'ya -> しんや
        #expect(toKana("shin'ya") == "しんや")
        // kinyou -> きにょう
        #expect(toKana("kinyou") == "きにょう")
        // kin'you -> きんよう
        #expect(toKana("kin'you") == "きんよう")
        // kin'yu -> きんゆ
        #expect(toKana("kin'yu") == "きんゆ")
        // Properly add space after "n[space]"
        #expect(toKana("ichiban warui") == "いちばん わるい")
    }

    @Test("Bogus 4 character sequences") func testBogusSequences() async throws {
        // Non bogus sequences work
        #expect(toKana("chya") == "ちゃ")
        // Bogus sequences do not work
        #expect(toKana("chyx") == "chyx")
        #expect(toKana("shyp") == "shyp")
        #expect(toKana("ltsb") == "ltsb")
    }
}
