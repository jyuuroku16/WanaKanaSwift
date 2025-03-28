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
    // 1. Create basic tree
    var kanaTree = transform(BASIC_KUNREI)
    
    // 2. Add combinations like tya, sya etc.
    for (consonant, yKana) in CONSONANTS {
        for (roma, kana) in SMALL_Y {
            // for example kyo -> き + ょ
            kanaTree = setSubTreeValue(kanaTree, consonant + roma, ["": yKana + kana])
        }
    }
    
    // 3. Add special symbols
    for (symbol, jSymbol) in SPECIAL_SYMBOLS {
        kanaTree = setSubTreeValue(kanaTree, symbol, ["": jSymbol])
    }
    
    // 4. Add combinations like うぃ, くぃ etc.
    for (consonant, aiueoKana) in AIUEO_CONSTRUCTIONS {
        for (vowel, kana) in SMALL_VOWELS {
            kanaTree = setSubTreeValue(kanaTree, consonant + vowel, ["": aiueoKana + kana])
        }
    }
    
    // 5. Handle different ways to write ん
    for nChar in ["n", "n'", "xn"] {
        kanaTree = setSubTreeValue(kanaTree, nChar, ["": "ん"])
    }
    
    // 6. Copy k to c (needs deep copy)
    if let kTree = kanaTree["k"] as? [String: Any] {
        // Create deep copy
        let kTreeData = try? JSONSerialization.data(withJSONObject: kTree)
        if let kTreeData = kTreeData,
           let cTree = try? JSONSerialization.jsonObject(with: kTreeData) as? [String: Any] {
            kanaTree["c"] = cTree
        }
    }
    
    // Helper function to merge trees
    func mergeTrees(_ target: inout [String: Any], _ source: [String: Any]) {
        for (key, value) in source {
            if var targetDict = target[key] as? [String: Any] {
                if let sourceDict = value as? [String: Any] {
                    // If source is empty dictionary but target has empty string key, keep target
                    if sourceDict.isEmpty && targetDict[""] != nil {
                        continue
                    }
                    // If target is empty dictionary and source has empty string key, use source
                    if targetDict.isEmpty && sourceDict[""] != nil {
                        target[key] = sourceDict
                        continue
                    }
                    mergeTrees(&targetDict, sourceDict)
                    target[key] = targetDict
                }
            } else {
                // If we're setting a new dictionary and it's empty, make sure it has empty string key
                if let sourceDict = value as? [String: Any], sourceDict.isEmpty {
                    target[key] = ["": ""]
                } else {
                    target[key] = value
                }
            }
        }
    }
    
    // 7. Handle alias mappings
    let regularAliases = ALIASES.filter { !["shi", "chi", "tsu", "ji", "fu"].contains($0.key) }
    for (string, alternative) in regularAliases {
        let allExceptLast = String(string.dropLast())
        let last = String(string.suffix(1))
        
        // Get the full alternative subtree
        let altTree = getSubTreeOf(kanaTree, alternative)
        
        // Create a deep copy of the alternative subtree
        if let altTreeData = try? JSONSerialization.data(withJSONObject: altTree),
           let altTreeCopy = try? JSONSerialization.jsonObject(with: altTreeData) as? [String: Any] {
            
            // Get parent tree
            var parentTree = getSubTreeOf(kanaTree, allExceptLast)
            
            // If there's an existing subtree at the target location, merge them
            if var existingSubtree = parentTree[last] as? [String: Any] {
                mergeTrees(&existingSubtree, altTreeCopy)
                parentTree[last] = existingSubtree
            } else {
                parentTree[last] = altTreeCopy
            }
            
            // Update the main tree
            kanaTree = setSubTreeValue(kanaTree, allExceptLast, parentTree)
        }
    }
    
    // 7. Handle special alias mappings
    let specialAliases = ALIASES.filter { ["shi", "chi", "tsu", "ji", "fu"].contains($0.key) }
    for (string, alternative) in specialAliases {
        let allExceptLast = String(string.dropLast())
        let last = String(string.suffix(1))
        
        // Get the full alternative subtree
        let altTree = getSubTreeOf(kanaTree, alternative)
        
        // Create a deep copy of the alternative subtree
        if let altTreeData = try? JSONSerialization.data(withJSONObject: altTree),
           let altTreeCopy = try? JSONSerialization.jsonObject(with: altTreeData) as? [String: Any] {
            
            // Get parent tree
            var parentTree = getSubTreeOf(kanaTree, allExceptLast)
            
            parentTree[last] = altTreeCopy
            
            // Update the main tree
            kanaTree = setSubTreeValue(kanaTree, allExceptLast, parentTree)
        }
    }
    
    // Helper function to get alternatives
    func getAlternatives(_ string: String) -> [String] {
        var alternatives: [String] = []
        for (alt, roma) in ALIASES {
            if string.starts(with: roma) {
                alternatives.append(string.replacingOccurrences(of: roma, with: alt))
            }
        }
        if string.starts(with: "k") {
            alternatives.append(string.replacingOccurrences(of: "k", with: "c"))
        }
        return alternatives
    }
    
    // 8. Handle small letters
    for (kunreiRoma, kana) in SMALL_LETTERS {
        let last = { (char: String) -> String in
            return String(char.suffix(1))
        }
        let allExceptLast = { (chars: String) -> String in
            return String(chars.dropLast())
        }
        
        let xRoma = "x\(kunreiRoma)"
        var xSubtree = getSubTreeOf(kanaTree, xRoma)
        xSubtree[""] = kana
        kanaTree = setSubTreeValue(kanaTree, xRoma, xSubtree)
        
        // ltu -> xtu -> っ
        var parentTree = getSubTreeOf(kanaTree, "l\(allExceptLast(kunreiRoma))")
        parentTree[last(kunreiRoma)] = xSubtree
        kanaTree = setSubTreeValue(kanaTree, "l\(allExceptLast(kunreiRoma))", parentTree)
        
        // ltsu -> ltu -> っ
        for altRoma in getAlternatives(kunreiRoma) {
            for prefix in ["l", "x"] {
                var altParentTree = getSubTreeOf(kanaTree, prefix + allExceptLast(altRoma))
                altParentTree[last(altRoma)] = getSubTreeOf(kanaTree, prefix + kunreiRoma)
                kanaTree = setSubTreeValue(kanaTree, prefix + allExceptLast(altRoma), altParentTree)
            }
        }
    }
    
    // 9. Handle special cases
    for (string, kana) in SPECIAL_CASES {
        kanaTree = setSubTreeValue(kanaTree, string, ["": kana])
    }
    
    // 10. Add sokuon (っ)
    func addTsu(_ tree: [String: Any]) -> [String: Any] {
        var tsuTree: [String: Any] = [:]
        for (key, value) in tree {
            if key.isEmpty {
                if let strValue = value as? String {
                    tsuTree[key] = "っ" + strValue
                }
            } else {
                if let subTree = value as? [String: Any] {
                    tsuTree[key] = addTsu(subTree)
                }
            }
        }
        return tsuTree
    }
    
    let consonantsToProcess = Array(CONSONANTS.keys) + ["c", "y", "w", "j"]
    for consonant in consonantsToProcess {
        if var subtree = kanaTree[consonant] as? [String: Any] {
            subtree[consonant] = addTsu(subtree)
            kanaTree[consonant] = subtree
        }
    }
    
    // 11. Remove nn -> っん
    if var nTree = kanaTree["n"] as? [String: Any] {
        nTree["n"] = nil
        kanaTree["n"] = nTree
    }
    
    // 12. Create final immutable copy
    let finalTreeData = try? JSONSerialization.data(withJSONObject: kanaTree)
    if let finalTreeData = finalTreeData,
       let finalTree = try? JSONSerialization.jsonObject(with: finalTreeData) as? [String: Any] {
        return finalTree
    }
    
    return kanaTree
}

fileprivate func setSubTreeValue(_ tree: [String: Any], _ path: String, _ value: Any) -> [String: Any] {
    var newTree = tree
    
    if path.isEmpty {
        if let dictValue = value as? [String: Any] {
            for (key, val) in dictValue {
                newTree[key] = val
            }
        }
        return newTree
    }
    
    let firstChar = String(path.first!)
    let restPath = String(path.dropFirst())
    
    if newTree[firstChar] == nil {
        newTree[firstChar] = [String: Any]()
    }
    
    if var subTree = newTree[firstChar] as? [String: Any] {
        subTree = setSubTreeValue(subTree, restPath, value)
        newTree[firstChar] = subTree
    }
    
    return newTree
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
