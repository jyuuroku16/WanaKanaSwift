import Foundation

// NOTE: not exactly kunrei shiki, for example ぢゃ -> dya instead of zya, to avoid name clashing
let BASIC_KUNREI: [String: Any] = [
    "a": "あ", "i": "い", "u": "う", "e": "え", "o": "お",
    "k": ["a": "か", "i": "き", "u": "く", "e": "け", "o": "こ"],
    "s": ["a": "さ", "i": "し", "u": "す", "e": "せ", "o": "そ"],
    "t": ["a": "た", "i": "ち", "u": "つ", "e": "て", "o": "と"],
    "n": ["a": "な", "i": "に", "u": "ぬ", "e": "ね", "o": "の"],
    "h": ["a": "は", "i": "ひ", "u": "ふ", "e": "へ", "o": "ほ"],
    "m": ["a": "ま", "i": "み", "u": "む", "e": "め", "o": "も"],
    "y": ["a": "や", "u": "ゆ", "o": "よ"],
    "r": ["a": "ら", "i": "り", "u": "る", "e": "れ", "o": "ろ"],
    "w": ["a": "わ", "i": "ゐ", "e": "ゑ", "o": "を"],
    "g": ["a": "が", "i": "ぎ", "u": "ぐ", "e": "げ", "o": "ご"],
    "z": ["a": "ざ", "i": "じ", "u": "ず", "e": "ぜ", "o": "ぞ"],
    "d": ["a": "だ", "i": "ぢ", "u": "づ", "e": "で", "o": "ど"],
    "b": ["a": "ば", "i": "び", "u": "ぶ", "e": "べ", "o": "ぼ"],
    "p": ["a": "ぱ", "i": "ぴ", "u": "ぷ", "e": "ぺ", "o": "ぽ"],
    "v": ["a": "ゔぁ", "i": "ゔぃ", "u": "ゔ", "e": "ゔぇ", "o": "ゔぉ"]
]

let SPECIAL_SYMBOLS: [String: String] = [
    ".": "。", ",": "、", ":": "：", "/": "・",
    "!": "！", "?": "？", "~": "〜", "-": "ー",
    "'": "「", "'": "」", """: "『", """: "』",
    "[": "［", "]": "］", "(": "（", ")": "）",
    "{": "｛", "}": "｝"
]

let CONSONANTS: [String: String] = [
    "k": "き", "s": "し", "t": "ち", "n": "に",
    "h": "ひ", "m": "み", "r": "り", "g": "ぎ",
    "z": "じ", "d": "ぢ", "b": "び", "p": "ぴ",
    "v": "ゔ", "q": "く", "f": "ふ"
]

let SMALL_Y: [String: String] = [
    "ya": "ゃ", "yi": "ぃ", "yu": "ゅ", "ye": "ぇ", "yo": "ょ"
]

let SMALL_VOWELS: [String: String] = [
    "a": "ぁ", "i": "ぃ", "u": "ぅ", "e": "ぇ", "o": "ぉ"
]

let ALIASES: [String: String] = [
    "sh": "sy",  // sha -> sya
    "ch": "ty",  // cho -> tyo
    "cy": "ty",  // cyo -> tyo
    "chy": "ty", // chyu -> tyu
    "shy": "sy", // shya -> sya
    "j": "zy",   // ja -> zya
    "jy": "zy",  // jye -> zye
    
    // exceptions to above rules
    "shi": "si",
    "chi": "ti",
    "tsu": "tu",
    "ji": "zi",
    "fu": "hu"
]

// xtu -> っ
let SMALL_LETTERS: [String: String] = [
    "tu": "っ",
    "wa": "ゎ",
    "ka": "ヵ",
    "ke": "ヶ",
    "a": "ぁ", "i": "ぃ", "u": "ぅ", "e": "ぇ", "o": "ぉ",
    "ya": "ゃ", "yi": "ぃ", "yu": "ゅ", "ye": "ぇ", "yo": "ょ"
]

let SPECIAL_CASES: [String: String] = [
    "yi": "い",
    "wu": "う",
    "ye": "いぇ",
    "wi": "うぃ",
    "we": "うぇ",
    "kwa": "くぁ",
    "whu": "う",
    "tha": "てゃ",
    "thu": "てゅ",
    "tho": "てょ",
    "dha": "でゃ",
    "dhu": "でゅ",
    "dho": "でょ"
]

let AIUEO_CONSTRUCTIONS: [String: String] = [
    "wh": "う",
    "kw": "く",
    "qw": "く",
    "q": "く",
    "gw": "ぐ",
    "sw": "す",
    "ts": "つ",
    "th": "て",
    "tw": "と",
    "dh": "で",
    "dw": "ど",
    "fw": "ふ",
    "f": "ふ"
]

private var romajiToKanaMap: [String: Any]?

func transform(_ mapping: [String: Any]) -> [String: Any] {
    var result: [String: Any] = [:]
    
    for (key, value) in mapping {
        if let stringValue = value as? String {
            result[key] = ["": stringValue]
        } else if let dictValue = value as? [String: Any] {
            result[key] = transform(dictValue)
        }
    }
    
    return result
}

func getSubTreeOf(tree: [String: Any], path: String) -> [String: Any]? {
    var currentTree: Any = tree
    
    for char in path {
        guard let dict = currentTree as? [String: Any],
              let nextTree = dict[String(char)] else {
            return nil
        }
        currentTree = nextTree
    }
    
    return currentTree as? [String: Any]
}

func createRomajiToKanaMap() -> [String: Any] {
    var kanaTree = transform(BASIC_KUNREI)
    
    // add tya, sya, etc.
    for (consonant, yKana) in CONSONANTS {
        for (roma, kana) in SMALL_Y {
            if var subtree = getSubTreeOf(tree: kanaTree, path: consonant + roma) {
                subtree[""] = yKana + kana
            }
        }
    }
    
    // add special symbols
    for (symbol, jSymbol) in SPECIAL_SYMBOLS {
        if var subtree = getSubTreeOf(tree: kanaTree, path: symbol) {
            subtree[""] = jSymbol
        }
    }
    
    // things like うぃ, くぃ, etc.
    for (consonant, aiueoKana) in AIUEO_CONSTRUCTIONS {
        for (vowel, kana) in SMALL_VOWELS {
            if var subtree = getSubTreeOf(tree: kanaTree, path: consonant + vowel) {
                subtree[""] = aiueoKana + kana
            }
        }
    }
    
    // different ways to write ん
    for nChar in ["n", "n'", "xn"] {
        if var subtree = getSubTreeOf(tree: kanaTree, path: nChar) {
            subtree[""] = "ん"
        }
    }
    
    // c is equivalent to k, but not for chi, cha, etc.
    if let kTree = kanaTree["k"] {
        kanaTree["c"] = kTree
    }
    
    // Handle aliases
    for (string, alternative) in ALIASES {
        let allExceptLast = String(string.dropLast())
        let last = String(string.last!)
        if var parentTree = getSubTreeOf(tree: kanaTree, path: allExceptLast),
           let altTree = getSubTreeOf(tree: kanaTree, path: alternative) {
            parentTree[last] = altTree
        }
    }
    
    // Handle special cases
    for (string, kana) in SPECIAL_CASES {
        if var subtree = getSubTreeOf(tree: kanaTree, path: string) {
            subtree[""] = kana
        }
    }
    
    return kanaTree
}

func getRomajiToKanaTree() -> [String: Any] {
    if romajiToKanaMap == nil {
        romajiToKanaMap = createRomajiToKanaMap()
    }
    return romajiToKanaMap!
}

func createCustomMapping() -> [String: String] {
    return [
        "wi": "ゐ",
        "we": "ゑ"
    ]
}

func IME_MODE_MAP(_ map: [String: Any]) -> [String: Any] {
    var mapCopy = map
    if var nMap = mapCopy["n"] as? [String: Any] {
        nMap["n"] = ["": "ん"]
        nMap[" "] = ["": "ん"]
        mapCopy["n"] = nMap
    }
    return mapCopy
}
