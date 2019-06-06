//
//  BasicTool.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/29.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit


enum authorizationError:Error {
    case notDeterminedToRefuse
    case alreadyRefuse
    case systemReason
    case userNotDetermin
    case otherUnkownReason
}

class BasicTool: NSObject {
    
    static let standard = BasicTool()
    
    func openWiFiSetting() -> () {
        
        let url = URL.init(string: "App-Prefs:root=WIFI")
        if let url = url, UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],completionHandler: {
                    (success) in
                })
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func openSettingURL() -> () {
        
        let url = URL(string: UIApplication.openSettingsURLString)
        if let url = url, UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],completionHandler: {
                    (success) in
                })
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
}

