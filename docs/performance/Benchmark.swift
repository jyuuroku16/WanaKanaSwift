import Foundation
import WanaKanaSwift

struct Stats {
    let name: String
    let iterations: Int
    let totalNs: UInt64
    let minNs: UInt64
    let maxNs: UInt64

    var meanNs: Double { Double(totalNs) / Double(iterations) }
    var meanUs: Double { meanNs / 1_000 }
    var meanMs: Double { meanNs / 1_000_000 }
}

@inline(never)
func blackHole<T>(_ value: T) {
    withExtendedLifetime(value) {}
}

func measure(_ name: String, warmup: Int, iterations: Int, run: () -> Void) -> Stats {
    for _ in 0..<warmup { run() }

    var total: UInt64 = 0
    var minNs = UInt64.max
    var maxNs: UInt64 = 0
    for _ in 0..<iterations {
        let start = DispatchTime.now().uptimeNanoseconds
        run()
        let elapsed = DispatchTime.now().uptimeNanoseconds - start
        total += elapsed
        if elapsed < minNs { minNs = elapsed }
        if elapsed > maxNs { maxNs = elapsed }
    }
    return Stats(name: name, iterations: iterations, totalNs: total, minNs: minNs, maxNs: maxNs)
}

let shortRomaji = "aiueosashisusesonaninunenokakikukeko"
let shortRomajiUpper = "AIUEOSASHISUSESONANINUNENOKAKIKUKEKO"
let shortHira = "あいうえおさしすせそなにぬねのかきくけこ"
let shortKata = "アイウエオサシスセソナニヌネノカキクケコ"
let mixedShort = "座禅‘zazen’スタイル #22 オオサカ"
let tokenizeSample = "5romaji here...!?人々漢字ひらがなカタ　カナ４「ＳＨＩＯ」。！ لنذهب"

let longRomaji = String(repeating: "konnichiwa watashi wa wanakana desu. ", count: 80)
let longHira = String(repeating: "こんにちはわたしはわなかなです。", count: 80)
let longKata = String(repeating: "コンニチハワタシハワナカナデス。", count: 80)
let longMixed = String(repeating: "hello 田中さん 123 カタカナひらがな ", count: 80)
let longJapaneseCheck = String(repeating: "泣き虫。！〜２￥ｚｅｎｋａｋｕ漢字ひらがなカタカナ", count: 40)

// Prime maps once so first-call tree construction is not mixed into steady-state numbers.
blackHole(WanaKanaSwift.toKana("ka"))
blackHole(WanaKanaSwift.toRomaji("か"))

var cases: [(String, Int, Int, () -> Void)] = [
    ("toKana short hiragana", 50, 2000, { blackHole(WanaKanaSwift.toKana(shortRomaji)) }),
    ("toKana short katakana", 50, 2000, { blackHole(WanaKanaSwift.toKana(shortRomajiUpper)) }),
    ("toHiragana short romaji", 50, 2000, { blackHole(WanaKanaSwift.toHiragana(shortRomaji)) }),
    ("toHiragana short katakana", 50, 2000, { blackHole(WanaKanaSwift.toHiragana(shortKata)) }),
    ("toKatakana short romaji", 50, 2000, { blackHole(WanaKanaSwift.toKatakana(shortRomaji)) }),
    ("toKatakana short hiragana", 50, 2000, { blackHole(WanaKanaSwift.toKatakana(shortHira)) }),
    ("toRomaji short hiragana", 50, 2000, { blackHole(WanaKanaSwift.toRomaji(shortHira)) }),
    ("toRomaji short katakana", 50, 2000, { blackHole(WanaKanaSwift.toRomaji(shortKata)) }),
    ("toKana mixed short", 50, 2000, { blackHole(WanaKanaSwift.toKana(mixedShort)) }),
    ("isJapanese short", 50, 5000, { blackHole(WanaKanaSwift.isJapanese("泣き虫。！〜２￥ｚｅｎｋａｋｕ")) }),
    ("isMixed short", 50, 5000, { blackHole(WanaKanaSwift.isMixed("お腹A")) }),
    ("tokenize mixed short", 50, 3000, { blackHole(WanaKanaSwift.tokenize(tokenizeSample)) }),
    ("toKana long romaji", 20, 200, { blackHole(WanaKanaSwift.toKana(longRomaji)) }),
    ("toRomaji long hiragana", 20, 200, { blackHole(WanaKanaSwift.toRomaji(longHira)) }),
    ("toRomaji long katakana", 20, 200, { blackHole(WanaKanaSwift.toRomaji(longKata)) }),
    ("toHiragana long katakana", 20, 200, { blackHole(WanaKanaSwift.toHiragana(longKata)) }),
    ("isJapanese long", 20, 400, { blackHole(WanaKanaSwift.isJapanese(longJapaneseCheck)) }),
    ("tokenize long mixed", 20, 200, { blackHole(WanaKanaSwift.tokenize(longMixed)) }),
    ("stripOkurigana", 50, 3000, { blackHole(WanaKanaSwift.stripOkurigana("踏み込む")) }),
]

print("label,iterations,mean_us,min_us,max_us")
for (name, warmup, iterations, run) in cases {
    let stats = measure(name, warmup: warmup, iterations: iterations, run: run)
    let row = String(
        format: "%@,%d,%.3f,%.3f,%.3f",
        stats.name,
        stats.iterations,
        stats.meanUs,
        Double(stats.minNs) / 1_000,
        Double(stats.maxNs) / 1_000
    )
    print(row)
}
