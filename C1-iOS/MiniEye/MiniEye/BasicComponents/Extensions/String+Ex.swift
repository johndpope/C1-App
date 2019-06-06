//
//  String+Ex.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/20.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import Foundation

extension String{
    
    func localizedString(with comment:String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
}

extension String:ImageConvert {
    
    func isCovertable() -> Bool {
        return UIImage.init(named: self) != nil
    }
    
    func convertToImage() -> UIImage? {
        return UIImage.init(named: self)
    }
    
}


extension String {
    
    func toRange(_ range: NSRange) -> Range<String.Index>? {
        
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex) else { return nil }
        guard let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex) else { return nil }
        guard let fromIndex = String.Index(from16, within: self) else { return nil }
        guard let toIndex = String.Index(to16, within: self) else { return nil }
        //        直接崩溃，显示fromIndex是UInt64数字 131328;toIndex是65792；
//        let fromIndex = index(startIndex, offsetBy: range.location, limitedBy: endIndex)
//        let toIndex = index(startIndex, offsetBy: range.length, limitedBy: endIndex)
        return fromIndex..<toIndex
    }
    
    func indexMoveAfter(_ count:Int) -> String.Index? {
        return index(startIndex, offsetBy: count, limitedBy: endIndex)
    }
    
}


extension String {
    
    
    func hasNoContent() -> Bool {
        let afterRemoveSpacingString = replacingOccurrences(of: " ", with: "")
        return afterRemoveSpacingString.count == 0
    }
}

