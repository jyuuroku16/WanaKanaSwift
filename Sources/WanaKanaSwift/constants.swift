import Foundation

// Version
let VERSION = "5.3.1"

// Conversion Methods
enum TO_KANA_METHODS {
    static let HIRAGANA = "toHiragana"
    static let KATAKANA = "toKatakana"
}

enum ROMANIZATIONS {
    static let HEPBURN = "hepburn"
}

/**
 * Default config for WanaKana, user passed options will be merged with these
 * @type {DefaultOptions}
 * @name DefaultOptions
 * @property {Boolean} [useObsoleteKana=false] - Set to true to use obsolete characters, such as ゐ and ゑ.
 * @example
 * toHiragana('we', { useObsoleteKana: true })
 * // => 'ゑ'
 * @property {Boolean} [passRomaji=false] - Set to true to pass romaji when using mixed syllabaries with toKatakana() or toHiragana()
 * @example
 * toHiragana('only convert the katakana: ヒラガナ', { passRomaji: true })
 * // => "only convert the katakana: ひらがな"
 * @property {Boolean} [convertLongVowelMark=true] - Set to false to prevent conversions of 'ー' to extended vowels with toHiragana()
 * @example
 * toHiragana('ラーメン', { convertLongVowelMark: false });
 * // => 'らーめん
 * @property {Boolean} [upcaseKatakana=false] - Set to true to convert katakana to uppercase using toRomaji()
 * @example
 * toRomaji('ひらがな カタカナ', { upcaseKatakana: true })
 * // => "hiragana KATAKANA"
 * @property {Boolean | 'toHiragana' | 'toKatakana'} [IMEMode=false] - Set to true, 'toHiragana', or 'toKatakana' to handle conversion while it is being typed.
 * @property {'hepburn'} [romanization='hepburn'] - choose toRomaji() romanization map (currently only 'hepburn')
 * @property {Object.<String, String>} [customKanaMapping] - custom map will be merged with default conversion
 * @example
 * toKana('wanakana', { customKanaMapping: { na: 'に', ka: 'Bana' }) };
 * // => 'わにBanaに'
 * @property {Object.<String, String>} [customRomajiMapping] - custom map will be merged with default conversion
 * @example
 * toRomaji('つじぎり', { customRomajiMapping: { じ: 'zi', つ: 'tu', り: 'li' }) };
 * // => 'tuzigili'
 */
// Default Options
let DEFAULT_OPTIONS: [String: Any] = [
    "useObsoleteKana": false,
    "passRomaji": false,
    "convertLongVowelMark": true,
    "upcaseKatakana": false,
    "IMEMode": false,
    "romanization": ROMANIZATIONS.HEPBURN
]

// Unicode Ranges
// Latin alphabet
let LATIN_LOWERCASE_START = 0x61
let LATIN_LOWERCASE_END = 0x7a
let LATIN_UPPERCASE_START = 0x41
let LATIN_UPPERCASE_END = 0x5a

// Zenkaku Latin
let LOWERCASE_ZENKAKU_START = 0xff41
let LOWERCASE_ZENKAKU_END = 0xff5a
let UPPERCASE_ZENKAKU_START = 0xff21
let UPPERCASE_ZENKAKU_END = 0xff3a

// Japanese characters
let HIRAGANA_START = 0x3041
let HIRAGANA_END = 0x3096
let KATAKANA_START = 0x30a1
let KATAKANA_END = 0x30fc
let KANJI_START = 0x4e00
let KANJI_END = 0x9faf

// Special characters
let KANJI_ITERATION_MARK = 0x3005 // 々
let PROLONGED_SOUND_MARK = 0x30fc // ー
let KANA_SLASH_DOT = 0x30fb // ・

// Range Arrays
let ZENKAKU_NUMBERS = [0xff10, 0xff19]
let ZENKAKU_UPPERCASE = [UPPERCASE_ZENKAKU_START, UPPERCASE_ZENKAKU_END]
let ZENKAKU_LOWERCASE = [LOWERCASE_ZENKAKU_START, LOWERCASE_ZENKAKU_END]
let ZENKAKU_PUNCTUATION_1 = [0xff01, 0xff0f]
let ZENKAKU_PUNCTUATION_2 = [0xff1a, 0xff1f]
let ZENKAKU_PUNCTUATION_3 = [0xff3b, 0xff3f]
let ZENKAKU_PUNCTUATION_4 = [0xff5b, 0xff60]
let ZENKAKU_SYMBOLS_CURRENCY = [0xffe0, 0xffee]

let HIRAGANA_CHARS = [0x3040, 0x309f]
let KATAKANA_CHARS = [0x30a0, 0x30ff]
let HANKAKU_KATAKANA = [0xff66, 0xff9f]
let KATAKANA_PUNCTUATION = [0x30fb, 0x30fc]
let KANA_PUNCTUATION = [0xff61, 0xff65]
let CJK_SYMBOLS_PUNCTUATION = [0x3000, 0x303f]
let COMMON_CJK = [0x4e00, 0x9fff]
let RARE_CJK = [0x3400, 0x4dbf]

// Combined ranges
let KANA_RANGES: [[Int]] = [
    HIRAGANA_CHARS,
    KATAKANA_CHARS,
    KANA_PUNCTUATION,
    HANKAKU_KATAKANA
]

let JA_PUNCTUATION_RANGES: [[Int]] = [
    CJK_SYMBOLS_PUNCTUATION,
    KANA_PUNCTUATION,
    KATAKANA_PUNCTUATION,
    ZENKAKU_PUNCTUATION_1,
    ZENKAKU_PUNCTUATION_2,
    ZENKAKU_PUNCTUATION_3,
    ZENKAKU_PUNCTUATION_4,
    ZENKAKU_SYMBOLS_CURRENCY
]

let JAPANESE_RANGES: [[Int]] = KANA_RANGES + JA_PUNCTUATION_RANGES + [
    ZENKAKU_UPPERCASE,
    ZENKAKU_LOWERCASE,
    ZENKAKU_NUMBERS,
    COMMON_CJK,
    RARE_CJK
]

// Romaji ranges
let MODERN_ENGLISH = [0x0000, 0x007f]
let HEPBURN_MACRON_RANGES: [[Int]] = [
    [0x0100, 0x0101], // Ā ā
    [0x0112, 0x0113], // Ē ē
    [0x012a, 0x012b], // Ī ī
    [0x014c, 0x014d], // Ō ō
    [0x016a, 0x016b]  // Ū ū
]

let SMART_QUOTE_RANGES: [[Int]] = [
    [0x2018, 0x2019], // ' '
    [0x201c, 0x201d]  // " "
]

let ROMAJI_RANGES: [[Int]] = [MODERN_ENGLISH] + HEPBURN_MACRON_RANGES

let EN_PUNCTUATION_RANGES: [[Int]] = [
    [0x20, 0x2f],
    [0x3a, 0x3f],
    [0x5b, 0x60],
    [0x7b, 0x7e]
] + SMART_QUOTE_RANGES
