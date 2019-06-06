//
//  UserInfoModel.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/20.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import Foundation


class UserAccountData: NSObject {
    
    enum Gender:String,Codable {
        case male
        case female
    }
    
    @objc var avatarImageUrl:URL?
    @objc var avatarImage:UIImage?
    
    @objc var userName:String?
    @objc var gender:String?
    @objc var region:String?
    @objc var signature:String?
    
    @objc var password:String?
    @objc var telephone:String?

    func isLogin() -> Bool {
        return telephone != nil
    }
    
}

