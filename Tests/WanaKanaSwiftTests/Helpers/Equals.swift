import Foundation
import WanaKanaSwift

func areDictionariesEqual(_ dict1: [String: Any], _ dict2: [String: Any]) -> Bool {
    do {
        let data1 = try JSONSerialization.data(withJSONObject: dict1, options: .sortedKeys)
        let data2 = try JSONSerialization.data(withJSONObject: dict2, options: .sortedKeys)
        return data1 == data2
    } catch {
        return false
    }
}

func areTupleArraysEqual(_ array1: [(Int, Int, String?)], _ array2: [(Int, Int, String)]) -> Bool {
    guard array1.count == array2.count else { return false }
    
    for (tuple1, tuple2) in zip(array1, array2) {
        guard tuple1.0 == tuple2.0 else { return false }
        
        guard tuple1.1 == tuple2.1 else { return false }
        
        guard let string1 = tuple1.2 else { return false }
        
        guard string1 == tuple2.2 else { return false }
    }
    
    return true
}

func areArraysEqual(_ array1: [Any], _ array2: [Any]) -> Bool {
    do {
        let data1 = try JSONSerialization.data(withJSONObject: array1, options: .sortedKeys)
        let data2 = try JSONSerialization.data(withJSONObject: array2, options: .sortedKeys)
        return data1 == data2
    } catch {
        return false
    }
}

func areTokenArraysEqual(_ array1: [Any], _ array2: [Any]) -> Bool {
    guard array1.count == array2.count else { return false }
    
    for (element1, element2) in zip(array1, array2) {
        switch (element1, element2) {
        case let (str1 as String, str2 as String):
            if str1 != str2 { return false }
        case let (token1 as Token, token2 as Token):
            if token1 != token2 { return false }
        default:
            return false
        }
    }
    return true
}
