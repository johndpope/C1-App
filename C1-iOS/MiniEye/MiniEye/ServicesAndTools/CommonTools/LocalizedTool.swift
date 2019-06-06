//
//  CountryAndRegionManager.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/28.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

typealias countryInfo = (countryName:String,countryCode:String)

class LocalizedTool: BasicTool {
    
    static let shared = LocalizedTool()
    
    var currentLocal:NSLocale {
        return NSLocale.init(localeIdentifier: Locale.current.identifier)
    }
    
    var currentCountryName:String? {
        return currentLocal.displayName(forKey: NSLocale.Key.countryCode, value:currentLocal.countryCode)
    }
    
    func chinaName() -> String {
        return currentLocal.displayName(forKey: NSLocale.Key.countryCode, value:chinaCode())!
    }
    
    func chinaCode() -> String {
        return "CN"
    }
    
    func isChina(_ code:String) -> Bool {
        return chinaCode() == code
    }
    
    func chinaCityNames() -> [String] {
        
        var cityNames = [String]()
        
        if let namesDic = LocalFileTool.shared.fetchInfoInBundle(fromPlist:"cityData"),namesDic.count > 0 {
            for (key,_) in namesDic {
                cityNames.append(key as! String)
            }
        }
        
        return cityNames
    }
    
    func chinaDistrictName(for cityName:String) -> [String] {
        var cityAreaNames = [String]()
        
        if let namesDic = LocalFileTool.shared.fetchInfoInBundle(fromPlist:"cityData"),namesDic.count > 0 {
            for (key,value) in namesDic {
                if key as! String == cityName {
                    cityAreaNames = value as! [String]
                }
            }
        }
        
        
        return cityAreaNames
    }
    
    
    func getAllCountryInfos() -> [countryInfo] {
        
        var countryNames = [countryInfo]()
        
        let countryCodes = NSLocale.isoCountryCodes
        
        for countryCode in countryCodes {
            let countryName  = currentLocal.displayName(forKey: NSLocale.Key.countryCode, value: countryCode)
            countryNames.append((countryName!,countryCode))
            print("countryCode=\(countryCode),countryName=\(String(describing: countryName))")
        }
        
       return countryNames
    }
    

}
