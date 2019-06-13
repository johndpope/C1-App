//
//  ChooseVehicleTypeViewController.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/6/13.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class ChooseVehicleTypeViewController: BasicViewController {

    lazy var saloonCarButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setTitle("轿车", for: UIControl.State.normal)
        button.cornerRadius(CommonDimension.buttonHeight/2).boardColor(CommonColor.buttonBG, width: 1)
        button.setTitleColor(CommonColor.buttonBG, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    
    lazy var SUVCarButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setTitle("SUV", for: UIControl.State.normal)
        button.cornerRadius(CommonDimension.buttonHeight/2).boardColor(CommonColor.buttonBG, width: 1)
        button.setTitleColor(CommonColor.buttonBG, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    lazy  var explainLabel:BasicLabel = {
        let label = BasicLabel()
        let originText = "XXX\n\n使用车型数据建立您的ADAS环境模型，选择对应车型帮助您实现更精准优质的安全体验"
        var attributeStr = NSMutableAttributedString.init(string: originText)
        attributeStr.addAttributes([NSAttributedString.Key.font : CommonFont.bigTitle,NSAttributedString.Key.foregroundColor:CommonColor.black], range: NSRange.init(location: 0, length: "XXX".count))
        attributeStr.addAttributes([NSAttributedString.Key.font : CommonFont.detail,NSMutableAttributedString.Key.foregroundColor : UIColor.init(red: 51/255, green: 60/255, blue: 79/255, alpha: 1)],
                                   range: originText.nsRange(from: originText.range(of: "使用车型数据建立您的ADAS环境模型，选择对应车型帮助您实现更精准优质的安全体验")!))
        label.textAlignment = .left
        label.attributedText = attributeStr
        label.numberOfLines = 0
        
        return label
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureSubviews() {
        super.configureSubviews()
        
        title = "选择车型"
        view.addSubview(explainLabel)
        view.addSubview(saloonCarButton)
        view.addSubview(SUVCarButton)
        
        explainLabel.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.view)?.offset()(StatusBarH + NavigationBarH + 40)
            make?.left.equalTo()(self.view)?.offset()(CommonDimension.cellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-CommonDimension.cellContentHorizitalMargin)
            make?.bottom.lessThanOrEqualTo()(self.saloonCarButton.mas_top)?.offset()(-50)
        }
        
        saloonCarButton.mas_makeConstraints { (make) in
            make?.left.right()?.equalTo()(self.explainLabel)
            make?.height.mas_equalTo()(CommonDimension.buttonHeight)
            make?.bottom.equalTo()(self.SUVCarButton.mas_top)?.offset()(-CommonDimension.buttonHeight)
        }
        
        SUVCarButton.mas_makeConstraints { (make) in
            make?.left.right()?.equalTo()(self.explainLabel)
            make?.height.mas_equalTo()(CommonDimension.buttonHeight)
            make?.bottom.lessThanOrEqualTo()(self.view)?.offset()(-SafeBottomMargin-200)
        }
        
        
    }
    
    
    
    @objc func viewIsTapped(sender:NSObject) {
        print_Debug(message: "viewDebug is tapped", prlogLevel: LogLevel.testClose)
        navigationController?.pushViewController(DeviceAdjustViewController(), animated: true)
    }
    

}
