## WanaKana Swift

### ワナカナ <--> WanaKana <--> わなかな

Utility library for checking and converting between Japanese characters - Hiragana, Katakana - and Romaji (Ported from https://github.com/WaniKani/WanaKana V4.0.2)

#### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/jyuuroku16/WanaKanaSwift", from: "1.0.0")
]
```

#### CocoaPods

Add the following to your Podfile:

```ruby
pod 'WanaKanaSwift'
```

Then run:

```bash
pod install
```

## Documentation

[Extended API reference](http://www.WanaKana.com/docs/global.html)

## Performance

Release-ready comparison of the Swift-native rewrite versus `37cd80f`: method, environment, averaged results, raw CSVs, and the benchmark harness.

See [docs/performance/README.md](docs/performance/README.md).

## Quick Reference

```Swift
import WanaKanaSwift

/*** TEXT CHECKING UTILITIES ***/
WanaKanaSwift.isJapanese("泣き虫。！〜２￥ｚｅｎｋａｋｕ")
// => true

WanaKanaSwift.isKana("あーア")
// => true

WanaKanaSwift.isHiragana("すげー")
// => true

WanaKanaSwift.isKatakana("ゲーム")
// => true

WanaKanaSwift.isKanji("切腹")
// => true
WanaKanaSwift.isKanji("勢い")
// => false

WanaKanaSwift.isRomaji("Tōkyō and Ōsaka")
// => true

WanaKanaSwift.toKana("ONAJI buttsuuji")
// => "オナジ ぶっつうじ"
WanaKanaSwift.toKana("座禅'zazen'スタイル")
// => "座禅「ざぜん」スタイル"
WanaKanaSwift.toKana("batsuge-mu")
// => "ばつげーむ"
WanaKanaSwift.toKana("WanaKana", options: Options(customKanaMapping: ["na": "に", "ka": "bana"]))
// => "わにbanaに"
WanaKanaSwift.toKana("WanaKana", options: ["customKanaMapping": [ "na": "に", "ka": "bana" ]])
// => "わにbanaに"

WanaKanaSwift.toHiragana("toukyou, オオサカ")
// => "とうきょう、 おおさか"
WanaKanaSwift.toHiragana("only カナ", options: Options(passRomaji: true))
// => "only かな"
WanaKanaSwift.toHiragana("wi", options: Options(useObsoleteKana: true))
// => "ゐ"

WanaKanaSwift.toKatakana("toukyou, おおさか")
// => "トウキョウ、 オオサカ"
WanaKanaSwift.toKatakana("only かな", options: Options(passRomaji: true))
// => "only カナ"
WanaKanaSwift.toKatakana("wi", options: Options(useObsoleteKana: true))
// => "ヰ"

WanaKanaSwift.toRomaji("ひらがな　カタカナ")
// => "hiragana katakana"
WanaKanaSwift.toRomaji("ひらがな　カタカナ", options: Options(upcaseKatakana: true))
// => "hiragana KATAKANA"
WanaKanaSwift.toRomaji("つじぎり", options: Options(customRomajiMapping: ["じ": "zi", "つ": "tu", "り": "li"]))
// => "tuzigili"

/*** EXTRA UTILITIES ***/
WanaKanaSwift.stripOkurigana("お祝い")
// => "お祝"
WanaKanaSwift.stripOkurigana("踏み込む")
// => "踏み込"
WanaKanaSwift.stripOkurigana("お腹", options: Options(leading: true))
// => "腹"
WanaKanaSwift.stripOkurigana("ふみこむ", options: Options(matchKanji: "踏み込む"))
// => "ふみこ"
WanaKanaSwift.stripOkurigana("おみまい", options: Options(matchKanji: "お祝い", leading: true))
// => "みまい"

WanaKanaSwift.tokens("ふふフフ")
// => ["ふふ", "フフ"]
WanaKanaSwift.detailedTokens("hello 田中さん")
// => [Token(en, "hello"), Token(space, " "), Token(kanji, "田中"), Token(hiragana, "さん")]
WanaKanaSwift.tokenize("I said 私はすごく悲しい", options: TokenizeOptions(compact: true))
// => [ "I said ", "私はすごく悲しい"]
WanaKanaSwift.tokenize("I said 私はすごく悲しい", options: ["compact": true])
// => [ "I said ", "私はすごく悲しい"]
```

## Optional Swift API

Dictionary options from the original JS-style port still work. The typed forms below are optional and equivalent.

```swift
// Typed options
WanaKanaSwift.toKana("wi", options: Options(useObsoleteKana: true))
WanaKanaSwift.toKana("ONAJI", options: Options(imeMode: .toHiragana))
WanaKanaSwift.toHiragana("only カナ", options: Options(passRomaji: true))
WanaKanaSwift.toRomaji("ひらがな　カタカナ", options: Options(upcaseKatakana: true))
WanaKanaSwift.isMixed("お腹A", options: Options(passKanji: false))
WanaKanaSwift.stripOkurigana("お腹", options: Options(leading: true))
WanaKanaSwift.tokenize("ふふフフ", options: TokenizeOptions(detailed: true))

// Same calls with the original dictionaries
WanaKanaSwift.toKana("wi", options: ["useObsoleteKana": true])
WanaKanaSwift.toKana("ONAJI", options: ["IMEMode": "toHiragana"])
WanaKanaSwift.toHiragana("only カナ", options: ["passRomaji": true])
WanaKanaSwift.toRomaji("ひらがな　カタカナ", options: ["upcaseKatakana": true])
WanaKanaSwift.isMixed("お腹A", options: ["passKanji": false])
WanaKanaSwift.stripOkurigana("お腹", options: ["leading": true])
WanaKanaSwift.tokenize("ふふフフ", options: ["detailed": true])

// Typed tokenize helpers
WanaKanaSwift.tokens("ふふフフ")
// => ["ふふ", "フフ"]
WanaKanaSwift.detailedTokens("hello 田中さん")
// => [Token(type: .en, value: "hello"), ...]
```
