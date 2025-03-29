## WanaKana Swift

### ワナカナ <--> WanaKana <--> わなかな

Utility library for checking and converting between Japanese characters - Hiragana, Katakana - and Romaji (Ported from https://github.com/WaniKani/WanaKana V4.0.2)

#### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/wwzzyying/WanaKanaSwift", from: "1.0.0")
]
```

## Documentation

[Extended API reference](http://www.WanaKana.com/docs/global.html)

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
WanaKanaSwift.toKana("WanaKana", options: ["customKanaMapping": [ "na": "に", "ka": "bana" ]]);
// => "わにbanaに"

WanaKanaSwift.toHiragana("toukyou, オオサカ")
// => "とうきょう、 おおさか"
WanaKanaSwift.toHiragana("only カナ", options: ["passRomaji": true])
// => "only かな"
WanaKanaSwift.toHiragana("wi", options: ["useObsoleteKana": true])
// => "ゐ"

WanaKanaSwift.toKatakana("toukyou, おおさか")
// => "トウキョウ、 オオサカ"
WanaKanaSwift.toKatakana("only かな", options: ["passRomaji": true])
// => "only カナ"
WanaKanaSwift.toKatakana("wi", options: ["useObsoleteKana": true])
// => "ヰ"

WanaKanaSwift.toRomaji("ひらがな　カタカナ")
// => "hiragana katakana"
WanaKanaSwift.toRomaji("ひらがな　カタカナ", options: ["upcaseKatakana": true])
// => "hiragana KATAKANA"
WanaKanaSwift.toRomaji("つじぎり", options: ["customRomajiMapping": ["じ": "zi", "つ": "tu", "り": "li" ]]);
// => "tuzigili"

/*** EXTRA UTILITIES ***/
WanaKanaSwift.stripOkurigana("お祝い")
// => "お祝"
WanaKanaSwift.stripOkurigana("踏み込む")
// => "踏み込"
WanaKanaSwift.stripOkurigana("お腹", options: ["leading": true]);
// => "腹"
WanaKanaSwift.stripOkurigana("ふみこむ", options: ["matchKanji": "踏み込む"]);
// => "ふみこ"
WanaKanaSwift.stripOkurigana("おみまい", options: ["matchKanji": "お祝い", "leading": true ]);
// => "みまい"

WanaKanaSwift.tokenize("ふふフフ")
// => ["ふふ", "フフ"]
WanaKanaSwift.tokenize("hello 田中さん")
// => ["hello", " ", "田中", "さん"]
WanaKanaSwift.tokenize("I said 私はすごく悲しい", options: ["compact": true])
// => [ "I said ", "私はすごく悲しい"]
```
