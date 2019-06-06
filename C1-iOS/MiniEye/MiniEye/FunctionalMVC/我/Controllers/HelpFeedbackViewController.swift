//
//  HelpFeedbackViewController.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/23.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class HelpFeedbackViewController: BasicViewController {
    
    let textFieldHeight:CGFloat = 40
    let textFieldSpacing:CGFloat = 30
        
    lazy var contactTextField:BasicTextField = {
       let textF = BasicTextField.init()
        textF.delegate = self
        textF.font = UIFont.systemFont(ofSize: 16)
        textF.placeholder = " 联系人"
        textF.boardColor(CommonColor.grayText,width:1).cornerRadius(5)
        return textF
    }()
    
    lazy var telephoneTextField:BasicTextField = {
        let textF = BasicTextField.init()
        textF.delegate = self
        textF.placeholder = " 联系电话"
        textF.font = UIFont.systemFont(ofSize: 16)
        textF.boardColor(CommonColor.grayText,width:1).cornerRadius(5)
        return textF
    }()
    
    lazy var questionTextView:BasicTextView = {
        let textV = BasicTextView.init()
        textV.text = "问题描述"
        textV.textColor = CommonColor.grayText
        textV.font = UIFont.systemFont(ofSize: 16)
        textV.delegate = self
        textV.boardColor(CommonColor.grayText,width:1).cornerRadius(5)
        return textV
    }()
    
    lazy  var submitLabel:BasicLabel = {
        let label = BasicLabel.initWith(text: "提交日志")
        label.textAlignment = .left
        label.font = CommonFont.content
        
        return label
    }()
    
    lazy var submitButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.backgroundColor = CommonColor.buttonBG
        button.setTitle("提交", for: UIControl.State.normal)
        button.cornerRadius(defaultButtonHeight/2)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureSubviews() {
        super.configureSubviews()
        
        title = "问题反馈"
        view.addSubview(contactTextField)
        view.addSubview(telephoneTextField)
        view.addSubview(questionTextView)
        view.addSubview(submitLabel)
        view.addSubview(submitButton)
        
        contactTextField.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.top.equalTo()(self.view)?.offset()(20 + NavigationBarH + SafeStatusBarHeight)
            make?.height.mas_equalTo()(self.textFieldHeight)
        }
        
        telephoneTextField.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.top.equalTo()(self.contactTextField.mas_bottom)?.offset()(self.textFieldSpacing)
            make?.height.mas_equalTo()(self.textFieldHeight)
        }
        
        questionTextView.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.top.equalTo()(self.telephoneTextField.mas_bottom)?.offset()(self.textFieldSpacing)
            make?.height.mas_equalTo()(300)
        }
        
        submitLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.top.equalTo()(self.questionTextView.mas_bottom)?.offset()(self.textFieldSpacing)
            make?.height.mas_equalTo()(30)
        }

        submitButton.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.height.mas_equalTo()(defaultButtonHeight)
            make?.bottom.equalTo()(self.view)?.offset()(-SafeBottomMargin - 15 - 50)
        }
    }
    
    @objc  func viewIsTapped(sender:UIButton) -> () {
        
    }

}


extension HelpFeedbackViewController:UITextFieldDelegate {
    
    
}

extension HelpFeedbackViewController:UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == "问题描述",textView.textColor == CommonColor.grayText {
            textView.textColor = CommonColor.black
            textView.text = nil
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        let textWithoutBlank = textView.text.replacingOccurrences(of: " ", with: "")
        
        if textWithoutBlank.count == 0 {
            textView.text = "问题描述"
            textView.textColor = CommonColor.grayText
        }
        
        return true
    }
    
}
