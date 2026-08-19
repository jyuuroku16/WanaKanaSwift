# Performance Comparison

This report is the release-ready record of the Swift-native rewrite versus `37cd80f` (`feat: support Cocoapods`).

Use it as-is in GitHub Release notes, or copy the **Results** and **How to reproduce** sections.

## Summary

The rewrite is faster on character classification, tokenization, and kana-to-kana conversion. Romaji conversion of long strings is unchanged, because that path is still dominated by the shared `[String: Any]` mapping tree.

Highlights from the averaged Release runs:

- `tokenize` mixed text: **7.6x–8.1x**
- `isMixed` / `stripOkurigana`: **6.7x–7.5x**
- `isJapanese`: **3.4x–3.8x**
- hiragana/katakana conversion: **2.6x–2.9x**
- short romaji conversion: **1.1x–1.3x**
- long romaji conversion: **~1.0x**

## Environment

| Item | Value |
| --- | --- |
| Baseline commit | `37cd80f` (`feat: support Cocoapods`) |
| Comparison | working tree after the Swift-native rewrite |
| Machine | Apple Silicon Mac (`arm64`) |
| OS | macOS 14 |
| Swift | 6.0 toolchain used by `swift build` |
| Configuration | `swift build -c release --product WanaKanaBench` |
| Timer | `DispatchTime.now().uptimeNanoseconds` |
| Runs | 2 independent process runs per revision; means below are the average of those two means |

The mapping trees were primed once per process (`toKana("ka")` and `toRomaji("か")`) so first-call tree construction is not mixed into the steady-state numbers.

## Workloads

Short inputs match the existing `PerformanceTests` samples. Long inputs are repeated strings, roughly 3–6 KB.

| Case | Input |
| --- | --- |
| `toKana` short hiragana | `aiueosashisusesonaninunenokakikukeko` |
| `toKana` short katakana | uppercase form of the same romaji |
| `toHiragana` / `toKatakana` / `toRomaji` short | the same 21-mora samples in romaji, hiragana, or katakana |
| mixed short | `座禅‘zazen’スタイル #22 オオサカ` |
| `isJapanese` short | `泣き虫。！〜２￥ｚｅｎｋａｋｕ` |
| `isMixed` short | `お腹A` |
| `tokenize` mixed short | `5romaji here...!?人々漢字ひらがなカタ　カナ４「ＳＨＩＯ」。！ لنذهب` |
| `stripOkurigana` | `踏み込む` |
| long romaji | `"konnichiwa watashi wa wanakana desu. "` repeated 80 times |
| long hiragana / katakana | `"こんにちはわたしはわなかなです。"` / `"コンニチハワタシハワナカナデス。"` repeated 80 times |
| long mixed tokenize | `"hello 田中さん 123 カタカナひらがな "` repeated 80 times |
| long `isJapanese` | `"泣き虫。！〜２￥ｚｅｎｋａｋｕ漢字ひらがなカタカナ"` repeated 40 times |

Iteration counts:

- short conversion: warmup 50, measure 2000
- short classify: warmup 50, measure 3000–5000
- long conversion / tokenize: warmup 20, measure 200
- long `isJapanese`: warmup 20, measure 400

Each measured call is wrapped in `blackHole` / `withExtendedLifetime` so the compiler cannot dead-strip the result.

## Results

Times are **mean microseconds per call**. Lower is better. Speedup is `before / after`.

### Classification and tokenization

| Case | Before (us) | After (us) | Speedup |
| --- | ---: | ---: | ---: |
| `isMixed` short | 0.656 | 0.087 | 7.50x |
| `tokenize` mixed short | 44.248 | 5.843 | 7.57x |
| `tokenize` long mixed | 1732.215 | 213.894 | 8.10x |
| `stripOkurigana` | 7.152 | 1.071 | 6.68x |
| `isJapanese` short | 1.413 | 0.372 | 3.79x |
| `isJapanese` long | 73.168 | 21.265 | 3.44x |

### Kana-to-kana conversion

| Case | Before (us) | After (us) | Speedup |
| --- | ---: | ---: | ---: |
| `toKatakana` short hiragana | 5.096 | 1.782 | 2.86x |
| `toHiragana` short katakana | 6.432 | 2.263 | 2.84x |
| `toHiragana` long katakana | 351.506 | 134.471 | 2.61x |

### Romaji conversion

| Case | Before (us) | After (us) | Speedup |
| --- | ---: | ---: | ---: |
| `toHiragana` short romaji | 45.822 | 35.428 | 1.29x |
| `toKatakana` short romaji | 44.637 | 36.647 | 1.22x |
| `toKana` mixed short | 19.822 | 16.543 | 1.20x |
| `toRomaji` short katakana | 21.767 | 18.462 | 1.18x |
| `toKana` short katakana | 43.670 | 37.300 | 1.17x |
| `toRomaji` short hiragana | 21.443 | 18.407 | 1.16x |
| `toKana` short hiragana | 43.772 | 40.689 | 1.08x |
| `toRomaji` long katakana | 23287.810 | 22794.332 | 1.02x |
| `toKana` long romaji | 39971.885 | 39875.048 | 1.00x |
| `toRomaji` long hiragana | 23350.044 | 23397.324 | 1.00x |

## What changed in the fast paths

- Character checks now take `Character` instead of allocating a one-character `String` on every scalar.
- Digit / consonant / vowel tests no longer compile regular expressions.
- `tokenize` walks characters once and emits `[String]` or `[Token]` without `[Any]` boxing on the typed helpers.
- `stripOkurigana` uses prefix/suffix string ops instead of `NSRegularExpression`.
- Common romaji-to-kana trees are cached for the default, IME, and obsolete-kana combinations.

The remaining long-romaji cost is the mapping-tree walk (`applyMapping` over `[String: Any]`). That is still shared with the original JS-style algorithm.

## How to reproduce

The executable used for this report is checked in as [`Benchmark.swift`](Benchmark.swift). Raw process output is in [`raw/`](raw/).

From a clean checkout of each revision:

```bash
# 1. Copy docs/performance/Benchmark.swift into a temporary executable target
#    named WanaKanaBench that depends on the WanaKanaSwift library.
# 2. Build and run in Release:

swift build -c release --product WanaKanaBench
./.build/release/WanaKanaBench
```

Expected stdout:

```text
label,iterations,mean_us,min_us,max_us
toKana short hiragana,2000,...
```

Run the binary twice per revision and average the `mean_us` columns. Do not mix Debug and Release numbers. Do not include the first mapping-tree build in the comparison; the harness already primes it.

To add the temporary target without keeping it in `Package.swift`:

```swift
.executable(name: "WanaKanaBench", targets: ["WanaKanaBench"])
// ...
.executableTarget(name: "WanaKanaBench", dependencies: ["WanaKanaSwift"])
```

Place `Benchmark.swift` at `Sources/WanaKanaBench/Benchmark.swift`, run the measurements, then remove the target before publishing source.

## Release notes snippet

```markdown
### Performance

Compared with 37cd80f on an Apple Silicon Mac, Release:

- Tokenization and mixed-script checks are about 7–8x faster.
- `isJapanese` is about 3.4–3.8x faster.
- Hiragana/katakana conversion is about 2.6–2.9x faster.
- Short romaji conversion is about 1.1–1.3x faster.
- Long romaji conversion is unchanged.

See docs/performance/README.md for method, raw CSVs, and the benchmark harness.
```

## Raw data

| File | Revision | Run |
| --- | --- | --- |
| [raw/before.csv](raw/before.csv) | `37cd80f` | 1 |
| [raw/before2.csv](raw/before2.csv) | `37cd80f` | 2 |
| [raw/after.csv](raw/after.csv) | rewrite | 1 |
| [raw/after2.csv](raw/after2.csv) | rewrite | 2 |
