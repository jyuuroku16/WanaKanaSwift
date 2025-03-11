import Foundation

/**
 * Apply mapping to convert string using a mapping tree
 * - Parameters:
 *   - string: Input string
 *   - mapping: Mapping tree
 *   - convertEnding: Whether to convert the ending
 * - Returns: Array of tuples containing start index, end index, and converted string
 */
func applyMapping(_ string: String, map mapping: [String: Any], optimize convertEnding: Bool) -> [(Int, Int, String?)] {
    let root = mapping

    func nextSubtree(_ tree: [String: Any], nextChar: String) -> [String: Any]? {
        guard let subtree = tree[nextChar] as? [String: Any] else { return nil }
        var result = subtree
        if let nodeValue = tree[""] as? String {
            result[""] = nodeValue + nextChar
        }
        return result
    }

    func newChunk(_ remaining: String, currentCursor: Int) -> [(Int, Int, String?)] {
        guard let firstChar = remaining.first else { return [] }
        let firstCharString = String(firstChar)

        var initialTree: [String: Any] = [:]
        if let subtree = root[firstCharString] as? [String: Any] {
            initialTree = subtree
        }
        initialTree[""] = firstCharString

        return parse(
            initialTree,
            remaining: String(remaining.dropFirst()),
            lastCursor: currentCursor,
            currentCursor: currentCursor + 1
        ) as! [(Int, Int, String?)]
    }

    func parse(_ tree: [String: Any], remaining: String, lastCursor: Int, currentCursor: Int) -> [(Int, Int, Any)] {
        if remaining.isEmpty {
            if convertEnding || tree.count == 1 {
                if let nodeValue = tree[""] as? String {
                    return [[lastCursor, currentCursor, nodeValue]] as! [(Int, Int, Any)]
                }
                return []
            }
            return [[lastCursor, currentCursor, nil]] as! [(Int, Int, Any)]
        }

        if tree.count == 1 {
            let nodeValue = tree[""] as? String ?? ""
            return ([[lastCursor, currentCursor, nodeValue]] + newChunk(remaining, currentCursor: currentCursor)) as! [(Int, Int, Any)]
        }

        guard let firstChar = remaining.first else { return [] }
        let firstCharString = String(firstChar)

        if let subtree = nextSubtree(tree, nextChar: firstCharString) {
            return parse(
                subtree,
                remaining: String(remaining.dropFirst()),
                lastCursor: lastCursor,
                currentCursor: currentCursor + 1
            )
        }

        return ([[lastCursor, currentCursor, tree[""]]] + newChunk(remaining, currentCursor: currentCursor)) as! [(Int, Int, Any)]
    }

    return newChunk(string, currentCursor: 0)
}

/**
 * Transform a tree structure
 * - Parameter tree: Input tree
 * - Returns: Transformed tree
 */
func transform(_ tree: [String: Any]) -> [String: Any] {
    var map: [String: Any] = [:]

    for (char, subtree) in tree {
        if let stringValue = subtree as? String {
            map[char] = ["": stringValue]
        } else if let dictValue = subtree as? [String: Any] {
            map[char] = transform(dictValue)
        }
    }

    return map
}

/**
 * Get subtree from a tree using a string path
 * - Parameters:
 *   - tree: Input tree
 *   - string: Path string
 * - Returns: Subtree at path
 */
func getSubTreeOf(_ tree: [String: Any], _ string: String) -> [String: Any] {
    var currentTree = tree

    for char in string {
        let charString = String(char)
        if currentTree[charString] == nil {
            currentTree[charString] = [String: Any]()
        }
        if let subtree = currentTree[charString] as? [String: Any] {
            currentTree = subtree
        }
    }

    return currentTree
}

/**
 * Create a custom mapping tree
 * - Parameter customMap: Custom mapping dictionary
 * - Returns: Function that merges custom mapping with default mapping
 */
func createCustomMapping(_ customMap: [String: String] = [:]) -> ([String: Any]) -> [String: Any] {
    let customTree: [String: Any] = [:]

    for (roma, kana) in customMap {
        var subTree = customTree

        for char in roma {
            let charString = String(char)
            if subTree[charString] == nil {
                subTree[charString] = [String: Any]()
            }
            if let nextTree = subTree[charString] as? [String: Any] {
                subTree = nextTree
            }
        }

        subTree[""] = kana
    }

    return { map in
        let mapCopy = map // In Swift, dictionaries are value types, so no need for deep copy

        func transformMap(_ mapSubtree: [String: Any]?, _ customSubtree: [String: Any]) -> [String: Any] {
            guard let mapSubtree = mapSubtree else { return customSubtree }

            var newSubtree = mapSubtree
            for (char, subtree) in customSubtree {
                if let customDict = subtree as? [String: Any] {
                    if let mapDict = mapSubtree[char] as? [String: Any] {
                        newSubtree[char] = transformMap(mapDict, customDict)
                    } else {
                        newSubtree[char] = customDict
                    }
                } else {
                    newSubtree[char] = subtree
                }
            }

            return newSubtree
        }

        return transformMap(mapCopy, customTree)
    }
}

/**
 * Merge custom mapping with default mapping
 * - Parameters:
 *   - map: Default mapping
 *   - customMapping: Custom mapping (function or dictionary)
 * - Returns: Merged mapping
 */
func mergeCustomMapping(_ map: [String: Any], _ customMapping: Any?) -> [String: Any] {
    guard let customMapping = customMapping else { return map }

    if let customFunc = customMapping as? ([String: Any]) -> [String: Any] {
        return customFunc(map)
    } else if let customDict = customMapping as? [String: String] {
        return createCustomMapping(customDict)(map)
    }

    return map
}
