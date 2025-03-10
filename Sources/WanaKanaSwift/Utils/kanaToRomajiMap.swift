import Foundation

// MARK: - Constants

@MainActor var kanaToHepburnMap: [String: Any]? = nil

// prettier-ignore
private let BASIC_ROMAJI: [String: String] = [
    "あ": "a",    "い": "i",   "う": "u",   "え": "e",    "お": "o",
    "か": "ka",   "き": "ki",  "く": "ku",  "け": "ke",   "こ": "ko",
    "さ": "sa",   "し": "shi", "す": "su",  "せ": "se",   "そ": "so",
    "た": "ta",   "ち": "chi", "つ": "tsu", "て": "te",   "と": "to",
    "な": "na",   "に": "ni",  "ぬ": "nu",  "ね": "ne",   "の": "no",
    "は": "ha",   "ひ": "hi",  "ふ": "fu",  "へ": "he",   "ほ": "ho",
    "ま": "ma",   "み": "mi",  "む": "mu",  "め": "me",   "も": "mo",
    "ら": "ra",   "り": "ri",  "る": "ru",  "れ": "re",   "ろ": "ro",
    "や": "ya",   "ゆ": "yu",  "よ": "yo",
    "わ": "wa",   "ゐ": "wi",  "ゑ": "we",  "を": "wo",
    "ん": "n",
    "が": "ga",   "ぎ": "gi",  "ぐ": "gu",  "げ": "ge",   "ご": "go",
    "ざ": "za",   "じ": "ji",  "ず": "zu",  "ぜ": "ze",   "ぞ": "zo",
    "だ": "da",   "ぢ": "ji",  "づ": "zu",  "で": "de",   "ど": "do",
    "ば": "ba",   "び": "bi",  "ぶ": "bu",  "べ": "be",   "ぼ": "bo",
    "ぱ": "pa",   "ぴ": "pi",  "ぷ": "pu",  "ぺ": "pe",   "ぽ": "po",
    "ゔぁ": "va", "ゔぃ": "vi", "ゔ": "vu",  "ゔぇ": "ve", "ゔぉ": "vo"
]

fileprivate let SPECIAL_SYMBOLS: [String: String] = [
    "。": ".",
    "、": ",",
    "：": ":",
    "・": "/",
    "！": "!",
    "？": "?",
    "〜": "~",
    "ー": "-",
    "「": "'",
    "」": "'",
    "『": "\"",
    "』": "\"",
    "［": "[",
    "］": "]",
    "（": "(",
    "）": ")",
    "｛": "{",
    "｝": "}",
    "　": " "
]

// んい -> n'i
private let AMBIGUOUS_VOWELS = ["あ", "い", "う", "え", "お", "や", "ゆ", "よ"]
fileprivate let SMALL_Y = ["ゃ": "ya", "ゅ": "yu", "ょ": "yo"]
private let SMALL_Y_EXTRA = ["ぃ": "yi", "ぇ": "ye"]
private let SMALL_AIUEO = [
    "ぁ": "a",
    "ぃ": "i",
    "ぅ": "u",
    "ぇ": "e",
    "ぉ": "o"
]
private let YOON_KANA = [
    "き", "に", "ひ", "み", "り",
    "ぎ", "び", "ぴ", "ゔ", "く", "ふ"
]
private let YOON_EXCEPTIONS = [
    "し": "sh",
    "ち": "ch",
    "じ": "j",
    "ぢ": "j"
]
private let SMALL_KANA = [
    "っ": "",
    "ゃ": "ya",
    "ゅ": "yu",
    "ょ": "yo",
    "ぁ": "a",
    "ぃ": "i",
    "ぅ": "u",
    "ぇ": "e",
    "ぉ": "o"
]

private let SOKUON_WHITELIST = [
    "b": "b", "c": "t", "d": "d", "f": "f",
    "g": "g", "h": "h", "j": "j", "k": "k",
    "m": "m", "p": "p", "q": "q", "r": "r",
    "s": "s", "t": "t", "v": "v", "w": "w",
    "x": "x", "z": "z"
]

// MARK: - Public Functions

@MainActor func getKanaToRomajiTree(romanization: String) -> [String: Any] {
    switch romanization {
    case ROMANIZATIONS.HEPBURN:
        return getKanaToHepburnTree()
    default:
        return [:]
    }
}

// MARK: - Private Functions

@MainActor private func getKanaToHepburnTree() -> [String: Any] {
    if kanaToHepburnMap == nil {
        kanaToHepburnMap = createKanaToHepburnMap()
    }
    return kanaToHepburnMap ?? [:]
}

private func createKanaToHepburnMap() -> [String: Any] {
    var romajiTree = transform(BASIC_ROMAJI)

    func subtreeOf(_ string: String) -> [String: Any] {
        return getSubTreeOf(romajiTree, string)
    }

    let setTrans = { (string: String, transliteration: String) in
        var subtree = subtreeOf(string)
        subtree[""] = transliteration
    }

    // Add special symbols
    for (jsymbol, symbol) in SPECIAL_SYMBOLS {
        var subtree = subtreeOf(jsymbol)
        subtree[""] = symbol
    }

    // Add small y and aiueo
    for (roma, kana) in SMALL_Y.merging(SMALL_AIUEO, uniquingKeysWith: { key, _ in key }) {
        setTrans(roma, kana)
    }

    // きゃ -> kya
    for kana in YOON_KANA {
        let firstRomajiChar = (subtreeOf(kana)[""] as? String)?.first?.description ?? ""

        for (yKana, yRoma) in SMALL_Y {
            setTrans(kana + yKana, firstRomajiChar + yRoma)
        }

        // きぃ -> kyi
        for (yKana, yRoma) in SMALL_Y_EXTRA {
            setTrans(kana + yKana, firstRomajiChar + yRoma)
        }
    }

    // Handle exceptions
    for (kana, roma) in YOON_EXCEPTIONS {
        // じゃ -> ja
        for (yKana, yRoma) in SMALL_Y {
            setTrans(kana + yKana, roma + String(yRoma.dropFirst()))
        }
        // じぃ -> jyi, じぇ -> je
        setTrans("\(kana)ぃ", "\(roma)yi")
        setTrans("\(kana)ぇ", "\(roma)e")
    }

    romajiTree["っ"] = resolveTsu(romajiTree)

    // Add small kana
    for (kana, roma) in SMALL_KANA {
        setTrans(kana, roma)
    }

    // Handle ambiguous vowels
    for kana in AMBIGUOUS_VOWELS {
        setTrans("ん\(kana)", "n'\(subtreeOf(kana)[""] ?? "")")
    }

    return romajiTree
}

private func resolveTsu(_ tree: [String: Any]) -> [String: Any] {
    var tsuTree: [String: Any] = [:]

    for (key, value) in tree {
        if key.isEmpty {
            if let valueStr = value as? String {
                let consonant = String(valueStr.prefix(1))
                tsuTree[key] = SOKUON_WHITELIST.keys.contains(consonant) ?
                    SOKUON_WHITELIST[consonant]! + valueStr :
                    valueStr
            }
        } else {
            if let subTree = value as? [String: Any] {
                tsuTree[key] = resolveTsu(subTree)
            }
        }
    }

    return tsuTree
} 
