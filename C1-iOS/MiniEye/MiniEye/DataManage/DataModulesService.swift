//
//  DataModulesService.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/16.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit



class DataModulesService: NSObject {
    
    static let shared = DataModulesService.init()
    
    func initDataModules() -> UserAccountManager.accountFetchResult {
        LogTool.logLevel = LogLevel.debug
        //  1.  hook manager start hook
        //  2. log manager set log level
        //  3.  check if is first enter ,if is the window rootVC should  show guide Page
        //  4.  check login type,(vertify number,password login,thirdParty login)
        //  5.  if thirdParty login, should check login Info (还有个人数据)
        //  6. if login and device is Setted, update device installInfo in background; if need updated , notify MainTabbarController the top controller show alertVC to alert user update
        return UserAccountManager.shared.fetchUserAccountInfo()
    }
    
    func loadGlobalImages() -> () {
        
    }
    
}
