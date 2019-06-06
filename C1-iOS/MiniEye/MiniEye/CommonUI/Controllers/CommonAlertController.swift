//
//  CommonAlertController.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/22.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit



class CommonAlertController: UIAlertController {
    
    struct actionInfo {
        var title:String
        var style:UIAlertAction.Style
        var handler:((_ action:UIAlertAction) -> Void)?
    }
    
    static func presentedActionSheetStyle(in vc:UIViewController,animated:Bool,title:String? = nil,
                                        message:String? = nil,actionInfos:[actionInfo],completion:(() -> Void)? = nil)->(){
        
        let alertController = CommonAlertController(
            title: title,
            message: message,
            preferredStyle: .actionSheet)
        
        for actionInfo in actionInfos {
            let action = UIAlertAction.init(title: actionInfo.title, style: actionInfo.style, handler: actionInfo.handler)
            alertController.addAction(action)
        }
        
        vc.present(alertController, animated: animated, completion: completion)
    }

    static func presentAlert(in vc:UIViewController,animated:Bool,title:String?,
                          message:String?,actionInfos:[actionInfo],completion:(() -> Void)? = nil)->(){
        
        let alertController = CommonAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        for actionInfo in actionInfos {
            let action = UIAlertAction.init(title: actionInfo.title, style: actionInfo.style, handler: actionInfo.handler)
            alertController.addAction(action)
        }
        
        vc.present(alertController, animated: animated, completion: completion)
    }
    
    static func presentAlertConfirm(in vc:UIViewController,animated:Bool,title:String?,
                                    message:String?,confirmTitle:String,confirmHandler:((_ action:UIAlertAction) -> Void)?,completion:(() -> Void)? = nil)->() {
        let cancelActionInfo:CommonAlertController.actionInfo = CommonAlertController.actionInfo.init(title:"取消",style:UIAlertAction.Style.cancel,handler: nil)
        let confirmActionInfo:CommonAlertController.actionInfo = CommonAlertController.actionInfo.init(title:confirmTitle,style:UIAlertAction.Style.default,handler: confirmHandler)
        presentAlert(in: vc, animated: animated, title: title, message: message, actionInfos: [cancelActionInfo,confirmActionInfo], completion: completion)
    }
    
    
}
