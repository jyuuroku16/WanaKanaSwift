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
    ".": "。", ",": "、", ":": "：", "/": "・",
    "!": "！", "?": "？", "~": "〜", "-": "ー",
    "\u{2018}": "「", "\u{2019}": "」",  // 左右单引号
    "\u{201C}": "『", "\u{201D}": "』",  // 左右双引号
    "[": "［", "]": "］", "(": "（", ")": "）",
    "{": "｛", "}": "｝"
]

let CONSONANTS: [String: String] = [
    "k": "き", "s": "し", "t": "ち", "n": "に",
    "h": "ひ", "m": "み", "r": "り", "g": "ぎ",
    "z": "じ", "d": "ぢ", "b": "び", "p": "ぴ",
    "v": "ゔ", "q": "く", "f": "ふ"
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
    
    // Helper function for getting subtree
    func subtreeOf(_ string: String) -> [String: Any] {
        return getSubTreeOf(kanaTree, string)
    }
    
    // add tya, sya, etc.
    for (consonant, yKana) in CONSONANTS {
        for (roma, kana) in SMALL_Y {
            var subtree = subtreeOf(consonant + roma)
            subtree[""] = yKana + kana
        }
    }
    
    // add special symbols
    for (symbol, jSymbol) in SPECIAL_SYMBOLS {
        var subtree = subtreeOf(symbol)
        subtree[""] = jSymbol
    }
    
    // things like うぃ, くぃ, etc.
    for (consonant, aiueoKana) in AIUEO_CONSTRUCTIONS {
        for (vowel, kana) in SMALL_VOWELS {
            var subtree = subtreeOf(consonant + vowel)
            subtree[""] = aiueoKana + kana
        }
    }
    
    // different ways to write ん
    for nChar in ["n", "n'", "xn"] {
        var subtree = subtreeOf(nChar)
        subtree[""] = "ん"
    }
    
    // c is equivalent to k, but not for chi, cha, etc.
    if let kTree = kanaTree["k"] as? [String: Any] {
        kanaTree["c"] = kTree.deepCopy()
    }
    
    // Handle aliases
    for (string, alternative) in ALIASES {
        let allExceptLast = String(string.dropLast())
        let last = String(string.last!)
        var parentTree = subtreeOf(allExceptLast)
        let altTree = subtreeOf(alternative)
        parentTree[last] = altTree.deepCopy()
    }
    
    // Helper function for getting alternatives
    func getAlternatives(_ string: String) -> [String] {
        var alternatives: [String] = []
        
        // Add alternatives from ALIASES
        for (alt, roma) in ALIASES where string.hasPrefix(roma) {
            alternatives.append(string.replacingOccurrences(of: roma, with: alt))
        }
        
        // Add c->k alternative
        if string.hasPrefix("k") {
            alternatives.append(string.replacingOccurrences(of: "k", with: "c"))
        }
        
        return alternatives
    }
    
    // Handle small letters
    for (kunreiRoma, kana) in SMALL_LETTERS {
        let xRoma = "x\(kunreiRoma)"
        var xSubtree = subtreeOf(xRoma)
        xSubtree[""] = kana
        
        let allExceptLast = String(kunreiRoma.dropLast())
        let last = String(kunreiRoma.last!)
        
        // ltu -> xtu -> っ
        var parentTree = subtreeOf("l\(allExceptLast)")
        parentTree[last] = xSubtree
        
        // ltsu -> ltu -> っ
        for altRoma in getAlternatives(kunreiRoma) {
            for prefix in ["l", "x"] {
                var altParentTree = subtreeOf("\(prefix)\(String(altRoma.dropLast()))")
                altParentTree[String(altRoma.last!)] = subtreeOf("\(prefix)\(kunreiRoma)")
            }
        }
    }
    
    // Handle special cases
    for (string, kana) in SPECIAL_CASES {
        var subtree = subtreeOf(string)
        subtree[""] = kana
    }
    
    // Helper function to add っ
    func addTsu(_ tree: [String: Any]) -> [String: Any] {
        var tsuTree: [String: Any] = [:]
        for (key, value) in tree {
            if key.isEmpty {
                tsuTree[key] = "っ\(value)"
            } else if let subTree = value as? [String: Any] {
                tsuTree[key] = addTsu(subTree)
            }
        }
        return tsuTree
    }
    
    // add kka, tta, etc.
    let consonantsToProcess = Array(CONSONANTS.keys) + ["c", "y", "w", "j"]
    for consonant in consonantsToProcess {
        if var subtree = kanaTree[consonant] as? [String: Any] {
            subtree[consonant] = addTsu(subtree)
            kanaTree[consonant] = subtree
        }
    }
    
    // nn should not be っん
    if var nTree = kanaTree["n"] as? [String: Any] {
        nTree["n"] = nil
        kanaTree["n"] = nTree
    }
    
    // Return immutable copy
    return kanaTree.deepCopy()
}

// Helper extension for deep copying dictionaries
extension Dictionary {
    func deepCopy() -> [Key: Value] {
        var copy: [Key: Value] = [:]
        for (key, value) in self {
            if let value = value as? NSCopying {
                copy[key] = value.copy() as? Value
            } else if let value = value as? [String: Any] {
                copy[key] = value.deepCopy() as? Value
            } else {
                copy[key] = value
            }
        }
        return copy
    }
}

@MainActor var romajiToKanaMap: [String: Any]?

@MainActor func getRomajiToKanaTree() -> [String: Any] {
    if romajiToKanaMap == nil {
        romajiToKanaMap = createRomajiToKanaMap()
    }
    return romajiToKanaMap!
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
