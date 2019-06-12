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
    let smallButtonHeight:CGFloat = 30

//    enum type {
//        case register
//        case forgetPassword
//    }
//
//    var vcType:type
    
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
    
    lazy var thirdSeperatorView:BasicView = {
        
        let view = BasicView.init()
        view.backgroundColor = CommonColor.seperatorLine
        
        return view
    }()

    
    lazy var firstTextField:AccountTextField = {
        let textF = AccountTextField.init()
        textF.placeholder = "原密码"
        textF.delegate = self
        textF.font = CommonFont.detail
        return textF
    }()
    
    
    
    lazy var secondTextField:AccountTextField = {
        let textF = AccountTextField.init()
        textF.placeholder = "新密码"
        textF.delegate = self
        textF.font = CommonFont.detail
        return textF
    }()
    
    lazy var rightPromptButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setTitle("忘记密码", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        button.setTitleColor(CommonColor.black, for: UIControl.State.normal)
        button.titleLabel?.font = CommonFont.content
        
        return button
    }()
    
    lazy var rightBarButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setTitle("保存", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        button.setTitleColor(CommonColor.black, for: UIControl.State.normal)
        button.titleLabel?.font = CommonFont.title
        
        return button
    }()
    
//    lazy var codeView:CodeView = {
//        let view:CodeView = CodeView(frame: CGRect(x: defaultCellContentHorizitalMargin, y: 0, width: ScreenW - defaultCellContentHorizitalMargin*2, height: self.textFieldHeight))
//        //Change Basic Attributes
//
//        view.Base.changeViewBasicAttributes(lineColor: CommonColor.seperatorLine, lineInputColor: UIColor.black, cursorColor: UIColor.blue, errorColor: UIColor.red, fontNum: UIFont.systemFont(ofSize: 20), textColor: UIColor.black)
//        view.Base.changeInputNum(num: 4)
//        view.callBacktext = { str in
//            print("code :\(str)")
//            if str == "1234" {
//
//            } else {
//                view.clearnText(error: "error")
//            }
//        }
//        return view
//    }()

    
    lazy var thirdTextField:AccountTextField = {
        let textF = AccountTextField.init()
        textF.placeholder = "确认新密码"
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
    
//    lazy var getVertifyNumButton:RoundRectButton = {
//
//        let button = RoundRectButton.init(type: UIButton.ButtonType.custom)
//        button.boardColor(CommonColor.black,width:1).cornerRadius(10)
//        button.setTitle("获取验证码", for: UIControl.State.normal)
//        button.setTitleColor(CommonColor.black, for: UIControl.State.normal)
//        button.titleLabel?.font = CommonFont.detail
//        button.cornerRadius(5.0)
//        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
//
//        return button
//    }()
    
//    init(vcType:type) {
//        self.vcType = vcType
//        super.init(nibName: nil, bundle: nil)
//    }

    init() {
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        
        view.addSubview(firstTextField)
        view.addSubview(secondTextField)
        view.addSubview(thirdTextField)
        view.addSubview(firstSeperatorView)
        view.addSubview(secondSeperatorView)
        view.addSubview(thirdSeperatorView)
        view.addSubview(rightPromptButton)
        view.addSubview(excuteButton)
//        view.addSubview(getVertifyNumButton)
        
//        switch vcType {
//        case .register:
//            title = "新用户注册"
//            thirdTextField.placeholder = "设置密码"
//        default:
//            title = "忘记密码"
//            thirdTextField.placeholder = "设置新密码"
//        }
        title = "修改密码"
        
        firstTextField.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.top.equalTo()(self.view)?.offset()(100 + NavigationBarH + SafeStatusBarHeight)
            make?.height.mas_equalTo()(self.textFieldHeight)
        }
        
        secondTextField.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.top.equalTo()(self.firstTextField.mas_bottom)?.offset()(10)
            make?.height.mas_equalTo()(self.textFieldHeight)
        }
        
        thirdTextField.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.top.equalTo()(self.secondTextField.mas_bottom)?.offset()(10)
            make?.height.mas_equalTo()(self.textFieldHeight)
        }
        
        firstSeperatorView.mas_makeConstraints { (make) in
            make?.centerY.equalTo()(self.firstTextField.mas_bottom)
            make?.left.right()?.equalTo()(self.firstTextField)
            make?.height.mas_equalTo()(CommonDimension.seperatorheight)
        }
        
        secondSeperatorView.mas_makeConstraints { (make) in
            make?.centerY.equalTo()(self.secondTextField.mas_bottom)
            make?.left.right()?.equalTo()(self.firstTextField)
            make?.height.mas_equalTo()(CommonDimension.seperatorheight)
        }
        
        thirdSeperatorView.mas_makeConstraints { (make) in
            make?.centerY.equalTo()(self.thirdTextField.mas_bottom)
            make?.left.right()?.equalTo()(self.firstTextField)
            make?.height.mas_equalTo()(CommonDimension.seperatorheight)
        }
        
        rightPromptButton.mas_makeConstraints { (make) in
            make?.right.equalTo()(self.thirdSeperatorView)
            make?.top.equalTo()(self.thirdSeperatorView.mas_bottom)?.offset()(10)
            make?.height.mas_equalTo()(self.smallButtonHeight)
        }
        
        excuteButton.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.height.mas_equalTo()(defaultButtonHeight)
            make?.top.equalTo()(self.thirdTextField.mas_bottom)?.offset()(100)
        }
        
//        getVertifyNumButton.sizeToFit()
//        getVertifyNumButton.mas_makeConstraints { (make) in
//            make?.centerY.equalTo()(self.firstTextField)
//            make?.right.equalTo()(self.firstTextField)?.offset()(-5)
//            make?.size.mas_equalTo()(self.getVertifyNumButton.bounds.size)
//        }
    }
    
    
    @objc func viewIsTapped(sender:NSObject) {
        
        if sender == rightPromptButton{
            navigationController?.pushViewController(ForgetPasswordViewController.init(vcType: ForgetPasswordViewController.type.verifiSMCode), animated: true)
            print_Debug(message: "修改密码 忘记密码")
        } else if sender == rightBarButton {
            print_Debug(message: "修改密码 保存")
        }

        print_Debug(message: "viewDebug is tapped", prlogLevel: LogLevel.testClose)
    }
}



extension AccountModifyViewController:UITextFieldDelegate {
    
    
}
