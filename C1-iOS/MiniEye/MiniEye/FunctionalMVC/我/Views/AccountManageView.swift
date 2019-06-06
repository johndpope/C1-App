//
//  AccountManageView.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/8.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit



class AccountInputView: BasicView {
    
    
    enum ViewType {
        case phoneNumber(prefix:String,placeHolder:String)
        case passwordNumber(placeHolder:String)
        case vertifyNumber(placeHolder:String,subfix:String)
    }
    
    var type:ViewType
    
    lazy var verticalSeperatorView:BasicView = {
        let view = BasicView.init()
        view.backgroundColor = UIColor.init(white: 0.5, alpha: 0.6)
        
        return view
    }()
    
    lazy var underlineView:BasicView = {
        
        let view = BasicView.init()
        view.backgroundColor = UIColor.init(white: 0.5, alpha: 0.6)
        
        return view
    }()
    
    lazy var textField:BasicTextField = {
        
        let field = BasicTextField.init()
        
        return field
    }()
    
    lazy var prefixButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setTitleColor(CommonColor.black, for: UIControl.State.normal)
//        button.setViewDescribe(string: MyTableViewHeader.ViewDescribe.登录.rawValue)
//        button.addTarget(self, action: #selector(buttonIsTapped(button:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    lazy var subfixButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setTitleColor(CommonColor.black, for: UIControl.State.normal)
        //        button.setViewDescribe(string: MyTableViewHeader.ViewDescribe.登录.rawValue)
        //        button.addTarget(self, action: #selector(buttonIsTapped(button:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    
    init(viewType:ViewType,frame:CGRect) {
        self.type = viewType
        super.init(frame: frame)
        
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() -> () {
        addSubview(textField)
        addSubview(underlineView)
        

//        }
//

        
    }
    
    
}


class AccountManageView: BasicView {
    
    let view = AccountInputView.init(viewType: AccountInputView.ViewType.passwordNumber(placeHolder: "hehe"), frame: CGRect.zero)
    

}
