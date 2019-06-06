//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//protocol moduleManager:NSObject {
//    associatedtype managerType
//}

//无法实现，因为extension中，返回初始化方法会失败，不确定初始化方法会存在；non-nominal type 'Self.managerType' does not support explicit initialization
//extension moduleManager {
//    static func shared() -> managerType {
//        return managerType()
//    }
//}
//
//class TestModel:NSObject, moduleManager {
//    typealias managerType = TestModel
//
//}
//
// let model = TestModel.shared()

extension String {
    
    func toRange(_ range: NSRange) -> Range<String.Index>? {
        
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex) else { return nil }
        guard let to16 = utf16.index(from16, offsetBy: range.length, limitedBy:    utf16.endIndex) else { return nil }
        guard let fromIndex = String.Index(from16, within: self) else { return nil }
        guard let toIndex = String.Index(to16, within: self) else { return nil }
        //        直接崩溃，显示fromIndex是UInt64数字 131328;toIndex是65792；
        //        let fromIndex = index(startIndex, offsetBy: range.location, limitedBy: endIndex)
        //        let toIndex = index(startIndex, offsetBy: range.length, limitedBy: endIndex)
        print("from16=\(from16),to16=\(to16),fromIndex=\(fromIndex),toIndex=\(toIndex)")
        return fromIndex..<toIndex
    }
}


//str.toRange(NSRange.init(location: 0, length: 10))

let endIndex = str.index(before: str.endIndex)

str = str.replacingCharacters(in: str.startIndex..<endIndex, with: "133")
print("str=\(str)")
