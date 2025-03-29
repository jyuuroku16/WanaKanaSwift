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
import WanaKana

/*** TEXT CHECKING UTILITIES ***/
WanaKana.isJapanese("泣き虫。！〜２￥ｚｅｎｋａｋｕ")
// => true

WanaKana.isKana("あーア")
// => true

WanaKana.isHiragana("すげー")
// => true

WanaKana.isKatakana("ゲーム")
// => true

WanaKana.isKanji("切腹")
// => true
WanaKana.isKanji("勢い")
// => false

WanaKana.isRomaji("Tōkyō and Ōsaka")
// => true

WanaKana.toKana("ONAJI buttsuuji")
// => "オナジ ぶっつうじ"
WanaKana.toKana("座禅'zazen'スタイル")
// => "座禅「ざぜん」スタイル"
WanaKana.toKana("batsuge-mu")
// => "ばつげーむ"
WanaKana.toKana("WanaKana", options: ["customKanaMapping": [ "na": "に", "ka": "bana" ]]);
// => "わにbanaに"

WanaKana.toHiragana("toukyou, オオサカ")
// => "とうきょう、 おおさか"
WanaKana.toHiragana("only カナ", options: ["passRomaji": true])
// => "only かな"
WanaKana.toHiragana("wi", options: ["useObsoleteKana": true])
// => "ゐ"

WanaKana.toKatakana("toukyou, おおさか")
// => "トウキョウ、 オオサカ"
WanaKana.toKatakana("only かな", options: ["passRomaji": true])
// => "only カナ"
WanaKana.toKatakana("wi", options: ["useObsoleteKana": true])
// => "ヰ"

WanaKana.toRomaji("ひらがな　カタカナ")
// => "hiragana katakana"
WanaKana.toRomaji("ひらがな　カタカナ", options: ["upcaseKatakana": true])
// => "hiragana KATAKANA"
WanaKana.toRomaji("つじぎり", options: ["customRomajiMapping": ["じ": "zi", "つ": "tu", "り": "li" ]]);
// => "tuzigili"

/*** EXTRA UTILITIES ***/
WanaKana.stripOkurigana("お祝い")
// => "お祝"
WanaKana.stripOkurigana("踏み込む")
// => "踏み込"
WanaKana.stripOkurigana("お腹", options: ["leading": true]);
// => "腹"
WanaKana.stripOkurigana("ふみこむ", options: ["matchKanji": "踏み込む"]);
// => "ふみこ"
WanaKana.stripOkurigana("おみまい", options: ["matchKanji": "お祝い", "leading": true ]);
// => "みまい"

WanaKana.tokenize("ふふフフ")
// => ["ふふ", "フフ"]
WanaKana.tokenize("hello 田中さん")
// => ["hello", " ", "田中", "さん"]
WanaKana.tokenize("I said 私はすごく悲しい", options: [compact: true])
// => [ "I said ", "私はすごく悲しい"]
```
