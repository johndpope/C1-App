//
//  LocalFileManager.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/16.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit


//protocol DataConvert {
//
//    func toStringValue() -> String
//    func toDataValue() -> Data
//
//}
//
//extension String:DataConvert {
//
//    func toStringValue() -> String {
//         return self
//    }
//
//    func toDataValue() -> Data {
//        return  data(using: self)
//    }
//
//}
//
//extension Data:DataConvert {
//
//    func toStringValue() -> String {
//        return String.init(self)
//    }
//
//    func toDataValue() -> Data {
//        return self
//    }
//
//}


class LocalFileTool: BasicTool {
    
    static let shared = LocalFileTool.init()
    
    private let documentRootPath =  FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)[0]
    private let libaryCacheRootPath =  FileManager.default.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)[0]

    
    func fetchLocalDataWith(dataKey:String) -> String {
        if let data = FileManager.default.contents(atPath: contentPathWith(key: dataKey)){
            
            return "data"
        }else{
            return ""
        }
    }
    
    func fetchInfoInBundle(fromPlist name:String) -> NSDictionary? {
        let plist = Bundle.main.path(forResource: name, ofType:"plist" )
        return NSDictionary.init(contentsOfFile: plist ?? "")
    }
    
    private func contentPathWith(key:String) -> String {
        
        return ""
    }
    
    
    
    func storeLocalDataWith(dataKey:String) -> () {
        if FileManager.default.fileExists(atPath: contentPathWith(key: dataKey)) {
            
        } else {
            
        }
        
    }
    
    
    func getUserAccountInfo(complete:commonCompleteBlock?) -> () {
        
    }

}


