//
//  AccountModifyViewController.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/30.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class AccountModifyViewController: BasicViewController {

    let textFieldHeight:CGFloat = defaultButtonHeight

    enum type {
        case register
        case forgetPassword
    }
    
    var vcType:type
    
    lazy  var errorLabel:BasicLabel = {
        let label = BasicLabel.initWith(text: "")
        label.textAlignment = .left
        label.font = CommonFont.content
        label.textColor = .red
        
        return label
    }()
    
    lazy var bgBoardView:BasicView = {
        
        let view = BasicView.init()
        view.boardColor(CommonColor.seperatorLine,width:CommonDimension.seperatorheight).cornerRadius(5)
        return view
    }()
    
    lazy var firstSeperatorView:BasicView = {
        
        let view = BasicView.init()
        view.backgroundColor = CommonColor.seperatorLine
        
        return view
    }()
    
    lazy var secondSeperatorView:BasicView = {
        
        let view = BasicView.init()
        view.backgroundColor = CommonColor.seperatorLine
        
        return view
    }()
    
    lazy var firstTextField:AccountTextField = {
        let textF = AccountTextField.init()
        textF.placeholder = "手机号"
        textF.delegate = self
        textF.font = CommonFont.detail
        return textF
    }()
    
    lazy var secondTextField:AccountTextField = {
        let textF = AccountTextField.init()
        textF.placeholder = "请输入验证码"
        textF.delegate = self
        textF.font = CommonFont.detail
        return textF
    }()
    
    lazy var thirdTextField:AccountTextField = {
        let textF = AccountTextField.init()
        textF.delegate = self
        textF.font = CommonFont.detail
        return textF
    }()
    
    lazy var excuteButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.backgroundColor = CommonColor.buttonBG
        button.setTitle("完成", for: UIControl.State.normal)
        button.cornerRadius(defaultButtonHeight/2)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    lazy var getVertifyNumButton:RoundRectButton = {
        
        let button = RoundRectButton.init(type: UIButton.ButtonType.custom)
        button.boardColor(CommonColor.black,width:1).cornerRadius(5)
        button.setTitle("获取验证码", for: UIControl.State.normal)
        button.setTitleColor(CommonColor.black, for: UIControl.State.normal)
        button.titleLabel?.font = CommonFont.detail
        button.cornerRadius(5.0)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    init(vcType:type) {
        self.vcType = vcType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureSubviews() {
        super.configureSubviews()
     
        
        view.backgroundColor = .white
        
        view.addSubview(bgBoardView)
        view.addSubview(firstTextField)
        view.addSubview(secondTextField)
        view.addSubview(thirdTextField)
        view.addSubview(firstSeperatorView)
        view.addSubview(secondSeperatorView)
        view.addSubview(excuteButton)
        view.addSubview(getVertifyNumButton)
        
        switch vcType {
        case .register:
            title = "新用户注册"
            thirdTextField.placeholder = "设置密码"
        default:
            title = "忘记密码"
            thirdTextField.placeholder = "设置新密码"
        }
        
        
        firstTextField.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.top.equalTo()(self.view)?.offset()(100 + NavigationBarH + SafeStatusBarHeight)
            make?.height.mas_equalTo()(self.textFieldHeight)
        }
        secondTextField.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.top.equalTo()(self.firstTextField.mas_bottom)
            make?.height.mas_equalTo()(self.textFieldHeight)
        }
        
        thirdTextField.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.top.equalTo()(self.secondTextField.mas_bottom)
            make?.height.mas_equalTo()(self.textFieldHeight)
        }
        
        bgBoardView.mas_makeConstraints { (make) in
            make?.left.right()?.top()?.equalTo()(self.firstTextField)
            make?.bottom.equalTo()(self.thirdTextField)
        }
        
        firstSeperatorView.mas_makeConstraints { (make) in
            make?.centerY.equalTo()(self.secondTextField.mas_top)
            make?.left.right()?.equalTo()(self.firstTextField)
            make?.height.mas_equalTo()(CommonDimension.seperatorheight)
        }
        
        secondSeperatorView.mas_makeConstraints { (make) in
            make?.centerY.equalTo()(self.thirdTextField.mas_top)
            make?.left.right()?.equalTo()(self.firstTextField)
            make?.height.mas_equalTo()(CommonDimension.seperatorheight)
        }
        
        excuteButton.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.height.mas_equalTo()(defaultButtonHeight)
            make?.top.equalTo()(self.thirdTextField.mas_bottom)?.offset()(100)
        }
        
        getVertifyNumButton.sizeToFit()
        getVertifyNumButton.mas_makeConstraints { (make) in
            make?.centerY.equalTo()(self.secondTextField)
            make?.right.equalTo()(self.secondTextField)?.offset()(-5)
            make?.size.mas_equalTo()(self.getVertifyNumButton.bounds.size)
        }
    }
    
    
    @objc func viewIsTapped(sender:NSObject) {
        
       
        print_Debug(message: "viewDebug is tapped", prlogLevel: LogLevel.testClose)
    }
}



extension AccountModifyViewController:UITextFieldDelegate {
    
    
}
