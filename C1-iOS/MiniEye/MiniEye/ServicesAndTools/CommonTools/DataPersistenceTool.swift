//
//  CacheManager.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/16.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class DataPersistenceTool: BasicTool {
    
    static let shared = DataPersistenceTool()
    private let defaults = UserDefaults.standard
    
    
    func fetchObjectFromPerference(objectType:NSObject.Type) -> NSObject {
        
        let object = objectType.init()
        
        let placeMirror = Mirror.init(reflecting: object)
        
        for case (let originName,_) in placeMirror.children {
            let storeName = String.init(describing: type(of: object).self) + "." +  originName!
            let cacheValue = defaults.object(forKey: storeName)
            print_Debug(message: "fetch from perference  originName=%@,storeName=\(storeName),cacheValue=\(String(describing: cacheValue))\n")
            
            switch cacheValue {
            case Optional<Any>.none:
                print("originValue=\(String(describing: cacheValue))")
            default:
                object.setValue(cacheValue, forKey: originName!)
                print("originValue != nil.originValue=\(String(describing: cacheValue))")
                
            }
        }
        
        return object
    }
    
    
    func set(objectIntoPerference object:NSObject) -> () {
        
        let placeMirror = Mirror.init(reflecting: object)
        
        for case  (let originName,let originValue) in placeMirror.children {
            let storeName = String.init(describing: type(of: object).self) + "." +  originName!
            print_Debug(message:"store in perference originName=\(originName!),storeName=\(storeName),originValue=\(originValue)\n")
            
            switch originValue {
            case Optional<Any>.none:
                print("originValue=\(originValue)")
            default:
                defaults.setValue(originValue, forKey: storeName)
                print("originValue != nil.originValue=\(originValue)")
                
            }
        }
        
    }

	
    func fetchFromDataBase(dataKey:String) -> Any {
        return ""
    }
    
    

}
