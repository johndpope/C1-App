//
//  DeviceAdjustViewController.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/30.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class DeviceAdjustViewController: BasicViewController {
    
    
    lazy var confirmButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.backgroundColor = CommonColor.buttonBG
        button.setTitle("连接WIFI", for: UIControl.State.normal)
        button.cornerRadius(defaultButtonHeight/2)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    
    lazy var promptImageView:BasicImageView = {
        let imageV = BasicImageView.init()
        imageV.backgroundColor = CommonColor.systemBGGray
        
        return imageV
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configureSubviews() {
        super.configureSubviews()
        title = "设备调校"
        view.addSubview(confirmButton)
        view.addSubview(promptImageView)
        
        promptImageView.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.view)?.offset()(SafeStatusBarHeight + NavigationBarH + 50)
            make?.left.right()?.equalTo()(self.view)
            make?.height.equalTo()(self.promptImageView.mas_width)?.multipliedBy()(9/16)
        }
        
        confirmButton.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.bottom.equalTo()(self.view)?.offset()(-SafeBottomMargin - TabBarH)
            make?.height.mas_equalTo()(defaultButtonHeight)
        }
    }
    
    @objc func viewIsTapped(sender:NSObject) {
     
        print_Debug(message: "viewDebug is tapped", prlogLevel: LogLevel.testClose)
    }

}
