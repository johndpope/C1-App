//
//  AcountManageViewController.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/25.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class AccountUsageViewController: BasicViewController {
    
    let textFieldHeight:CGFloat = defaultButtonHeight
    let viewWidth:CGFloat = 60
    let viewMargin:CGFloat = 60
    
    enum type {
        case loginUsePassword
        case loginUseSM
        case bindPhone
    }
    
    var vcType:type
    
    
    lazy  var errorLabel:BasicLabel = {
        let label = BasicLabel.initWith(text: "")
        label.textAlignment = .left
        label.font = CommonFont.content
        label.textColor = .red
        
        return label
    }()
    
//    lazy var bgBoardView:BasicView = {
//
//        let view = BasicView.init()
//        view.boardColor(CommonColor.seperatorLine,width:CommonDimension.seperatorheight).cornerRadius(5)
//        return view
//    }()
    
    lazy var welcomeLabel:BasicLabel =  {
        let label = BasicLabel.initWith(text: "欢迎登录MINIEYE")
        label.font = CommonFont.title
        return label;
    }()
    
    lazy var seperatorView1:BasicView = {
        
        let view = BasicView.init()
        view.backgroundColor = CommonColor.seperatorLine
        
        return view
    }()
    
    lazy var seperatorView2:BasicView = {
        
        let view = BasicView.init()
        view.backgroundColor = CommonColor.seperatorLine
        
        return view
    }()
   
    lazy var firstTextField:AccountTextField = {
        let textF = AccountTextField.init()
        textF.delegate = self
        textF.font = CommonFont.detail
        return textF
    }()
    
    lazy var secondTextField:AccountTextField = {
        let textF = AccountTextField.init()
        textF.delegate = self
        textF.font = CommonFont.detail
        return textF
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
    
    lazy var excuteButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.backgroundColor = CommonColor.buttonBG
        button.setTitle("登录", for: UIControl.State.normal)
        button.cornerRadius(defaultButtonHeight/2)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    
    lazy var loginTypeButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        button.setTitleColor(CommonColor.blue, for: UIControl.State.normal)
        button.titleLabel?.font = CommonFont.content
        
        return button
    }()
    
    lazy var rightPromptButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        button.setTitleColor(CommonColor.black, for: UIControl.State.normal)
        button.titleLabel?.font = CommonFont.content
        
        return button
    }()
    
    lazy var rightBarButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setTitle("注册", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        button.setTitleColor(CommonColor.black, for: UIControl.State.normal)
        button.titleLabel?.font = CommonFont.title
        
        return button
    }()
    
    
    enum buttonName:String {
        case QQ
        case 微信
        case 微博
    }
    
    lazy var buttonArray:[BasicButton] = {
        let titileArr = [buttonName.QQ,buttonName.微信,buttonName.微博]
        var btArray = [BasicButton]()
        
        for i in 0..<titileArr.count {
            let button = BasicButton.init(type: UIButton.ButtonType.custom)
            button.setImage(CommonImage.size30AvatarPlaceHolder, for: UIControl.State.normal)
            button.cornerRadius(viewWidth/2)
            button.setViewDescribe(string: titileArr[i].rawValue)
            button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
            btArray.append(button)
        }
        return btArray
    }()
    
    
    let titles = ["QQ快捷登录","微信快捷登录","微博快捷登录"]
    
    private  lazy var underlyViewArray:[BasicLabel] = {
        var views = [BasicLabel]()
        
        for i in 0..<buttonArray.count {
            let label = BasicLabel.initWith(text: titles[i], font: UIFont.systemFont(ofSize: 12), textColor: CommonColor.grayText, textAlignment: NSTextAlignment.center)
            views.append(label)
        }
        
        return views
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
        
//        view.addSubview(bgBoardView)
        view.addSubview(welcomeLabel)
        view.addSubview(firstTextField)
        view.addSubview(secondTextField)
        view.addSubview(seperatorView1)
        view.addSubview(seperatorView2)
        view.addSubview(excuteButton)
        view.addSubview(loginTypeButton)
        view.addSubview(rightPromptButton)
        view.addSubview(getVertifyNumButton)
        
        switch vcType {
        case .loginUsePassword:
            title = "密码登录"
            firstTextField.placeholder = "+86 手机号"
            secondTextField.placeholder = "6-16位数字/密码"
            loginTypeButton.setTitle("短信登录", for: UIControl.State.normal)
            rightPromptButton.setTitle("忘记密码", for: UIControl.State.normal)
            excuteButton.setTitle("登录", for: UIControl.State.normal)
            navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
         
            getVertifyNumButton.isHidden = true
            createSharedView()
            print_Debug(message: "is loginUsePassword vc")
            
        case .loginUseSM:
            title = "短信登录"
            firstTextField.placeholder = "+86 手机号"
            secondTextField.placeholder = "请输入验证码"
            loginTypeButton.setTitle("密码登录", for: UIControl.State.normal)
            excuteButton.setTitle("登录", for: UIControl.State.normal)
            navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)

            createSharedView()
            print_Debug(message: "is loginUseSM vc")
            
        case .bindPhone:
            title = "绑定手机"
            firstTextField.placeholder = "+86 手机号"
            secondTextField.placeholder = "请输入验证码"
            excuteButton.setTitle("绑定", for: UIControl.State.normal)
            
            loginTypeButton.isHidden = true
            rightPromptButton.isHidden = true
            
            print_Debug(message: "is bindPhone vc")
            
        }
        
        welcomeLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.top.equalTo()(self.mas_topLayoutGuideBottom)?.offset()(ScreenH * 0.1)
            make?.height.equalTo()(40)
        }
        
        firstTextField.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.top.equalTo()(self.welcomeLabel)?.offset()(40)
            make?.height.mas_equalTo()(self.textFieldHeight)
        }
        
        secondTextField.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.top.equalTo()(self.firstTextField.mas_bottom)
            make?.height.mas_equalTo()(self.textFieldHeight)
        }
        
//        bgBoardView.mas_makeConstraints { (make) in
//            make?.left.right()?.top()?.equalTo()(self.firstTextField)
//            make?.bottom.equalTo()(self.secondTextField)
//        }
        
        seperatorView1.mas_makeConstraints { (make) in
            make?.centerY.equalTo()(self.firstTextField.mas_bottom)
            make?.left.right()?.equalTo()(self.firstTextField)
            make?.height.mas_equalTo()(CommonDimension.seperatorheight)
        }
        
        seperatorView2.mas_makeConstraints { (make) in
            make?.centerY.equalTo()(self.secondTextField.mas_bottom)
            make?.left.right()?.equalTo()(self.firstTextField)
            make?.height.mas_equalTo()(CommonDimension.seperatorheight)
        }

        rightPromptButton.sizeToFit()
        rightPromptButton.mas_makeConstraints { (make) in
            make?.right.equalTo()(self.secondTextField)
            make?.top.equalTo()(self.secondTextField.mas_bottom)
            make?.height.mas_equalTo()(self.textFieldHeight)
        }
        
        excuteButton.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.height.mas_equalTo()(defaultButtonHeight)
            make?.top.equalTo()(self.rightPromptButton.mas_bottom)?.offset()(30)
        }
        
        getVertifyNumButton.sizeToFit()
        getVertifyNumButton.mas_makeConstraints { (make) in
            make?.centerY.equalTo()(self.secondTextField)
            make?.right.equalTo()(self.secondTextField)?.offset()(-5)
            make?.size.mas_equalTo()(self.getVertifyNumButton.bounds.size)
        }
        
    }
    
    
    func createSharedView() -> () {
        let tPlaceHolderView = BasicView()
        let bPlaceHolderView = BasicView()
        
        view.addSubview(tPlaceHolderView)
        view.addSubview(bPlaceHolderView)
        
        let seperatorView:BasicView = {
            
            let view = BasicView.init()
            view.backgroundColor = CommonColor.seperatorLine
            return view
        }()
        
        
        let otherLoginLabel:BasicLabel =  {
            let label = BasicLabel.initWith(text: "其他登录方式")
            label.font = CommonFont.bdge
            label.textColor = CommonColor.grayText
            label.backgroundColor = UIColor.white
            return label;
        }()
        
        view.addSubview(seperatorView)
        view.addSubview(otherLoginLabel)
        
        seperatorView.mas_makeConstraints { (make) in
            make?.left.right()?.equalTo()(self.firstTextField)
            make?.height.mas_equalTo()(CommonDimension.seperatorheight)
        }
        
        otherLoginLabel.sizeToFit()
        otherLoginLabel.mas_makeConstraints { (make) in
            make?.center.equalTo()(seperatorView)
            make?.height.equalTo()(20)
        }
        
        loginTypeButton.sizeToFit()
        loginTypeButton.mas_makeConstraints { (make) in
            make?.centerX.equalTo()(otherLoginLabel)
            make?.top.equalTo()(otherLoginLabel.mas_top)?.offset()(15)
            make?.height.mas_equalTo()(self.textFieldHeight)
        }

        
        for i in 0..<buttonArray.count {
            let button = buttonArray[i]
            let underlyLabel = underlyViewArray[i]
            
            view.addSubview(button)
            view.addSubview(underlyLabel)
            
            let spacing = (ScreenW - viewWidth * CGFloat(buttonArray.count) - 2 * viewMargin)/CGFloat(buttonArray.count - 1)
            let centerMargin = viewMargin + viewWidth/2 + CGFloat(i) * (viewWidth + spacing)
            
            button.mas_makeConstraints { (make) in
                make?.top.equalTo()(self.loginTypeButton.mas_bottom)?.offset()(5)
                make?.centerX.equalTo()(self.view.mas_left)?.offset()(centerMargin)
                make?.size.mas_equalTo()(CGSize.init(width: self.viewWidth, height: self.viewWidth))
            }
            
            underlyLabel.sizeToFit()
            underlyLabel.mas_makeConstraints { (make) in
                make?.centerX.equalTo()(button)
                make?.top.equalTo()(button.mas_bottom)?.offset()(10)
                make?.bottom.equalTo()(bPlaceHolderView.mas_top)
            }
        }
        
        tPlaceHolderView.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.excuteButton.mas_bottom)
            make?.height.equalTo()(bPlaceHolderView)
            make?.bottom.equalTo()(self.loginTypeButton.mas_top)
        }
        
        bPlaceHolderView.mas_makeConstraints { (make) in
            make?.bottom.equalTo()(self.mas_bottomLayoutGuideTop)
        }
     
    }
    
    @objc func viewIsTapped(sender:NSObject) {
        
        if sender == loginTypeButton {
            
            if vcType == .loginUsePassword {
            navigationController?.pushViewController(AccountUsageViewController.init(vcType: AccountUsageViewController.type.loginUseSM), animated: true)
                
            }else if vcType == .loginUseSM {
                let currentIndex = navigationController?.children.firstIndex(of: self)
                let forewordVC = navigationController?.children[currentIndex!-1]
                if forewordVC is AccountUsageViewController {
                    navigationController?.popViewController(animated: true)
                }
            }
            
        }else if sender == rightPromptButton{
            
            navigationController?.pushViewController(AccountModifyViewController.init(vcType: AccountModifyViewController.type.forgetPassword), animated: true)
            
        }else if sender == rightBarButton {
            
            navigationController?.pushViewController(AccountModifyViewController.init(vcType: AccountModifyViewController.type.register), animated: true)

        }
        
        print_Debug(message: "viewDebug is tapped", prlogLevel: LogLevel.testClose)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension AccountUsageViewController:UITextFieldDelegate {
    
    
}
