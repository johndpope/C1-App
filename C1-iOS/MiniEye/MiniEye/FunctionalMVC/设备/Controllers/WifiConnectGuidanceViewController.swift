//
//  WifiConnectGuidanceViewController.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/30.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class WifiConnectGuidanceViewController: BasicViewController {

    lazy var confirmButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.backgroundColor = CommonColor.buttonBG
        button.setTitle("连接WIFI", for: UIControl.State.normal)
        button.cornerRadius(defaultButtonHeight/2)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    lazy var cancelButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setTitle("取消", for: UIControl.State.normal)
        button.setTitleColor(CommonColor.grayText, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    
    lazy var promptImageView:BasicImageView = {
        let imageV = BasicImageView.init()
        imageV.image = UIImage.init(named: "wifiConnect")
        imageV.contentMode = UIView.ContentMode.scaleAspectFit
        return imageV
    }()
    
    lazy  var promptLabel:BasicLabel = {
        var attributeStr = NSMutableAttributedString.init(string: "请连接手机WI-FI至\"C1\"")
        attributeStr.addAttributes([NSAttributedString.Key.foregroundColor : CommonColor.grayText,NSAttributedString.Key.font : CommonFont.content,], range: NSRange.init(location: 0, length: "请连接手机WI-FI至".count  ))
         attributeStr.addAttributes([NSAttributedString.Key.foregroundColor : CommonColor.black,NSAttributedString.Key.font : CommonFont.content,], range: NSRange.init(location: "请连接手机WI-FI至".count, length: "\"C1\"".count))
        
        let label = BasicLabel()
        label.textAlignment = .center
        label.attributedText = attributeStr
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configureSubviews() {
        super.configureSubviews()
        view.addSubview(cancelButton)
        view.addSubview(promptImageView)
        view.addSubview(promptLabel)
        view.addSubview(confirmButton)
        
        cancelButton.sizeToFit()
        cancelButton.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.centerY.equalTo()(self.view.mas_top)?.offset()(SafeStatusBarHeight + NavigationBarH/2)
        }
        
        let ratio = (promptImageView.image?.size.height)! / (promptImageView.image?.size.width)!
        promptImageView.mas_makeConstraints { (make) in
            make?.top.greaterThanOrEqualTo()(self.cancelButton.mas_bottom)?.offset()(30)
            make?.width.mas_lessThanOrEqualTo()(ScreenW - 2 * defaultCellContentHorizitalMargin)
            make?.centerX.equalTo()(self.view)
            make?.height.equalTo()(self.promptImageView.mas_width)?.multipliedBy()(ratio)
            make?.bottom.lessThanOrEqualTo()(self.promptLabel.mas_top)?.offset()(-30)
        }
        
        confirmButton.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.bottom.equalTo()(self.view)?.offset()(-SafeBottomMargin - TabBarH)
            make?.height.mas_equalTo()(defaultButtonHeight)
        }
        
        promptLabel.sizeToFit()
        promptLabel.mas_makeConstraints { (make) in
            make?.left.right().equalTo()(self.view)
            make?.centerY.lessThanOrEqualTo()(self.confirmButton.mas_top)?.offset()(-30)
        }
        
        
        
    }
    
    @objc func viewIsTapped(sender:NSObject) {
        if sender == cancelButton {
            dismiss(animated: true, completion: nil)
        } else {
//            BasicTool.standard.openWiFiSetting()
            
        }
        print_Debug(message: "viewDebug is tapped", prlogLevel: LogLevel.testClose)
    }
    

}
