import Foundation

// NOTE: not exactly kunrei shiki, for example ぢゃ -> dya instead of zya, to avoid name clashing
nonisolated(unsafe) let BASIC_KUNREI: [String: Any] = [
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

fileprivate let SPECIAL_SYMBOLS: [String: String] = [
    ".": "。",
    ",": "、",
    ":": "：",
    "/": "・",
    "!": "！",
    "?": "？",
    "~": "〜",
    "-": "ー",
    "‘": "「",
    "’": "」",
    "“": "『",
    "”": "』",
    "[": "［",
    "]": "］",
    "(": "（",
    ")": "）",
    "{": "｛",
    "}": "｝"
]

let CONSONANTS: [String: String] = [
    "k": "き",
    "s": "し",
    "t": "ち",
    "n": "に",
    "h": "ひ",
    "m": "み",
    "r": "り",
    "g": "ぎ",
    "z": "じ",
    "d": "ぢ",
    "b": "び",
    "p": "ぴ",
    "v": "ゔ",
    "q": "く",
    "f": "ふ"
]

fileprivate let SMALL_Y: [String: String] = [
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
    // because it's not thya for てゃ but tha
    // and tha is not てぁ, but てゃ
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

func createRomajiToKanaMap() -> [String: Any] {
    var kanaTree = transform(BASIC_KUNREI)

    let setTrans = { (string: String, transliteration: String) in
        kanaTree = setSubTreeValue(kanaTree, string, transliteration)
    }

    // add tya, sya, etc.
    for (consonant, yKana) in CONSONANTS {
        for (roma, kana) in SMALL_Y {
            // for example kyo -> き + ょ
            setTrans(consonant + roma, yKana + kana)
        }
    }

    // add special symbols
    for (symbol, jSymbol) in SPECIAL_SYMBOLS {
        setTrans(symbol, jSymbol)
    }

    // things like うぃ, くぃ, etc.
    for (consonant, aiueoKana) in AIUEO_CONSTRUCTIONS {
        for (vowel, kana) in SMALL_VOWELS {
            setTrans(consonant + vowel, aiueoKana + kana)
        }
    }

    // different ways to write ん
    for nChar in ["n", "n'", "xn"] {
        setTrans(nChar, "ん")
    }

    // c is equivalent to k, but not for chi, cha, etc.
    if let kTree = kanaTree["k"] as? [String: Any] {
        kanaTree["c"] = kTree
    }

    // Handle aliases
    for (string, alternative) in ALIASES {
        let allExceptLast = String(string.dropLast())
        let last = String(string.last!)
        
        let altTree = getSubTreeOf(kanaTree, alternative)
        if let value = altTree[""] as? String {
            setTrans(string, value)
        } else {
            for (key, subValue) in altTree {
                if let strValue = (subValue as? [String: Any])?[""] as? String {
                    setTrans(string + key, strValue)
                }
            }
        }
    }

    // Helper function for getting alternatives
    func getAlternatives(_ string: String) -> [String] {
        var alternatives: [String] = []
        let aliasesWithC = Array(ALIASES.map { ($0.key, $0.value) } + [("c", "k")])
        for (alt, roma) in aliasesWithC where string.hasPrefix(roma) {
            alternatives.append(string.replacingOccurrences(of: roma, with: alt))
        }
        return alternatives
    }

    // Handle small letters
    for (kunreiRoma, kana) in SMALL_LETTERS {
        // xtu -> っ
        setTrans("x" + kunreiRoma, kana)
        
        // ltu -> っ
        setTrans("l" + kunreiRoma, kana)

        // ltsu -> ltu -> っ
        for altRoma in getAlternatives(kunreiRoma) {
            for prefix in ["l", "x"] {
                setTrans(prefix + altRoma, kana)
            }
        }
    }

    // Handle special cases
    for (string, kana) in SPECIAL_CASES {
        setTrans(string, kana)
    }

    // add kka, tta, etc.
    let consonantsToProcess = Array(CONSONANTS.keys) + ["c", "y", "w", "j"]
    for consonant in consonantsToProcess {
        if let subtree = kanaTree[consonant] as? [String: Any] {
            for (key, value) in subtree {
                if let strValue = value as? String {
                    setTrans(consonant + consonant + (key.isEmpty ? "" : key), "っ" + strValue)
                }
            }
        }
    }

    // nn should not be っん
    if var nTree = kanaTree["n"] as? [String: Any] {
        nTree["n"] = nil
        kanaTree["n"] = nTree
    }

    return kanaTree
}

private let queue = DispatchQueue(label: "com.wanakana.romajiToKanaMap")
nonisolated(unsafe) var romajiToKanaMap: [String: Any]?

func getRomajiToKanaTree() -> [String: Any] {
    queue.sync {
        if romajiToKanaMap == nil {
            romajiToKanaMap = createRomajiToKanaMap()
        }
        return romajiToKanaMap!
    }
}

nonisolated(unsafe) let USE_OBSOLETE_KANA_MAP = createCustomMapping([
    "wi": "ゐ",
    "we": "ゑ",
]);

func IME_MODE_MAP(_ map: [String: Any]) -> [String: Any] {
    var mapCopy = map
    if var nMap = mapCopy["n"] as? [String: Any] {
        nMap["n"] = ["": "ん"]
        nMap[" "] = ["": "ん"]
        mapCopy["n"] = nMap
    }
    return mapCopy
}
