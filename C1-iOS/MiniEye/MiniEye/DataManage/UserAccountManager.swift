//
//  UserAccountData.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/16.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit



extension String {
    
    func telephoneIsValid() -> Bool {
//        这里要加很多判断语句，暂时没有加
           return self.count == 11
    }
}


class UserAccountManager:NSObject {
    
    typealias accountFetchResult = (isOlderUser:Bool,isLocalLogin:Bool)
    
    static let shared = UserAccountManager.init()
    @objc var isOlderUser:Bool = true
    @objc var isLocalLogin:Bool = true
    
    var userAccountData:UserAccountData?
    
    func saveAvatarImageToLoacal(in controller:UIViewController) -> () {
        PhotosLibraryTool.shared.saveImageToPhotoLibrary(in: controller, imageInfos:[CommonImage.size30AvatarPlaceHolder], albumTitle: "MyTest")
    }

    func fetchUserAccountInfo() -> accountFetchResult {
        
        let isOldUserInPerfrence =  UserDefaults.standard.bool(forKey: String.init(describing: #keyPath(isOlderUser)))
        print_Debug( message: "isOldUserInPerfrence = \(isOldUserInPerfrence)", prlogLevel: LogLevel.debug)
//        此处应该为网络获取个人信息（通过手机号来实现！！有手机号就可以通过网络获取到个人信息，没有的手机号的话就不登陆）
        userAccountData =  DataPersistenceTool.shared.fetchObjectFromPerference(objectType: UserAccountData.self) as! UserAccountData
        
        return (isOldUserInPerfrence,userAccountData!.isLogin())
    }
    
    func loadLocalUserAccountInfoForRegistered() -> Bool {
        
        //        LocalFileManager.shared.getUserAccountInfo { (success, error, userData) in
        //
        //        }
        
        return false
    }
    
    
}


