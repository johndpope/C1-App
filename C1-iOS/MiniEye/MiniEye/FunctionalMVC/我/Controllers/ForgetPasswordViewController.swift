//
//  ForgetPasswordViewController.swift
//  MiniEye
//
//  Created by danhui.quan on 2019/6/12.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: BasicViewController {
    
    let textFieldHeight:CGFloat = defaultButtonHeight
    let smallButtonHeight:CGFloat = 30
    let viewWidth:CGFloat = 60
    let viewMargin:CGFloat = 40
    let codeTimeInterval:Int = 10
    
    var codeTime:Int
    
    var codeTimer:Timer?
    
    
    enum type:Int {
        case verifiSMCode
        case setPassword
    }
    
    var vcType:type
    
    lazy var welcomeLabel:BasicLabel =  {
        let label = BasicLabel.initWith(text: "输入验证码")
        label.font = CommonFont.title
        return label;
    }()
    
    lazy var tipLabel:BasicLabel = {
        let label = BasicLabel.initWith(text: "设置新密码，需验证手机号")
        label.font = CommonFont.detail
        label.textColor = CommonColor.grayText
        return label
    }()
    
    lazy var seperatorView1:BasicView = {
        
        let view = BasicView.init()
        view.backgroundColor = CommonColor.seperatorLine
        
        return view
    }()
    
    lazy var firstTextField:AccountTextField = {
        let textF = AccountTextField.init()
        textF.delegate = self
        textF.placeholder = "请输入新密码"
        textF.font = CommonFont.detail
        return textF
    }()
    
    lazy var codeView:CodeView = {
        let view:CodeView = CodeView(frame: CGRect(x: defaultCellContentHorizitalMargin, y: 0, width: ScreenW - defaultCellContentHorizitalMargin*2, height: self.textFieldHeight))
        //Change Basic Attributes
        
        view.Base.changeViewBasicAttributes(lineColor: CommonColor.seperatorLine, lineInputColor: UIColor.black, cursorColor: UIColor.blue, errorColor: UIColor.red, fontNum: UIFont.systemFont(ofSize: 20), textColor: UIColor.black)
        view.Base.changeInputNum(num: 4)
        view.callBacktext = { str in
            print("code :\(str)")
            if str == "1234" {
                self.navigationController?.pushViewController(ForgetPasswordViewController(vcType: ForgetPasswordViewController.type.setPassword), animated: true)
            } else {
                view.clearnText(error: "error")
            }
        }
        
        return view
    }()

    lazy var excuteButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.backgroundColor = CommonColor.buttonBG
        button.cornerRadius(defaultButtonHeight/2)
        button.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    lazy var codeTipLabel:BasicLabel = {
        let label:BasicLabel = BasicLabel.initWith(text: "\(codeTimeInterval)秒后重新获取验证码")
        label.font = CommonFont.detail
        label.textColor = CommonColor.grayText
        label.isHidden = true
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    init(vcType:type) {
        self.vcType = vcType
        self.codeTime = self.codeTimeInterval
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func configureSubviews() {

        super.configureSubviews()
        
        view.backgroundColor = .white
        
        view.addSubview(welcomeLabel)
        view.addSubview(tipLabel)
        view.addSubview(firstTextField)
        view.addSubview(codeView)
        view.addSubview(seperatorView1)
        view.addSubview(excuteButton)
        view.addSubview(codeTipLabel)

        switch self.vcType {
        case .setPassword:
            title = "重置密码"
            self.welcomeLabel.text = "设置新密码"
            self.tipLabel.text = "密码必须6-12位数字、字母"
            self.excuteButton.setTitle("完成", for: UIControl.State.normal)
            self.codeView.isHidden = true
            self.firstTextField.isHidden = false
            self.seperatorView1.isHidden = false
            
        default:
            title = "设置新密码"
            self.welcomeLabel.text = "输入验证码"
            self.tipLabel.text = "设置新密码，需要验证手机号"
            self.excuteButton.setTitle("重新获得验证码", for: UIControl.State.normal)
            self.codeView.isHidden = false
            self.firstTextField.isHidden = true
            self.seperatorView1.isHidden = true
        }
        
        welcomeLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.top.equalTo()(self.mas_topLayoutGuideBottom)?.offset()(ScreenH * 0.1)
            make?.height.equalTo()(35)
        }
        
        tipLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.welcomeLabel)
            make?.top.equalTo()(self.welcomeLabel.mas_bottom)
            make?.height.equalTo()(20)
        }
        
        firstTextField.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.top.equalTo()(self.welcomeLabel.mas_bottom)?.offset()(defaultCellContentHorizitalMargin)
            make?.height.mas_equalTo()(self.textFieldHeight)
        }
        
        codeView.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.top.equalTo()(self.welcomeLabel.mas_bottom)?.offset()(defaultCellContentHorizitalMargin)
            make?.height.mas_equalTo()(self.textFieldHeight)
        }
        
        seperatorView1.mas_makeConstraints { (make) in
            make?.centerY.equalTo()(self.firstTextField.mas_bottom)
            make?.left.right()?.equalTo()(self.firstTextField)
            make?.height.mas_equalTo()(CommonDimension.seperatorheight)
        }
        
        excuteButton.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.height.mas_equalTo()(defaultButtonHeight)
            make?.top.equalTo()(self.firstTextField.mas_bottom)?.offset()(defaultCellContentHorizitalMargin)
        }
        
        codeTipLabel.sizeToFit()
        codeTipLabel.mas_makeConstraints { (make) in
            make?.center.equalTo()(self.excuteButton)
        }

    }
    
    @objc func buttonAction(sender:UIButton) {
        if self.vcType == .setPassword {
            
        } else {
            
            self.codeTime = codeTimeInterval
            self.excuteButton.isHidden = true
            self.codeTipLabel.isHidden = false
            self.codeTimer = Timer.init(timeInterval: 1, target: self, selector: #selector(codeTimerAction), userInfo: nil, repeats: true)
            self.codeTimer!.fireDate = Date.init()
            self.codeTimer!.fire()
            RunLoop.current.add(self.codeTimer!, forMode: .common)
        }

    }
    
    @objc func codeTimerAction() {
        if self.codeTime > 0 {
            self.codeTipLabel.text = "\(self.codeTime)秒后重新获取验证码"
            self.codeTime -= 1
        } else {
            self.codeTipLabel.isHidden = true
            self.excuteButton.isHidden = false
            self.codeTimer?.invalidate()
            self.codeTime = codeTimeInterval
        }
    }
    

}


extension ForgetPasswordViewController : UITextFieldDelegate {
    
    
}
