//
//  DeviceViewController.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/8.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class DeviceHomePageViewController: BasicViewController {
    
    lazy var deviceButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setImage(UIImage.init(named: "添加"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    lazy  var addDeviceLabel:BasicLabel = {
        let label = BasicLabel.initWith(text: "添加新设备")
        label.textAlignment = .center
        label.font = CommonFont.content
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func configureSubviews() -> () {
        super.configureSubviews()
        
        view.backgroundColor = UIColor.white

        view.addSubview(deviceButton)
        view.addSubview(addDeviceLabel)
        
        deviceButton.sizeToFit()
        deviceButton.mas_makeConstraints { (make) in
            make?.center.equalTo()(self.view)
        }
        
        addDeviceLabel.mas_makeConstraints { (make) in
            make?.centerX.equalTo()(self.view)
            make?.top.equalTo()(self.deviceButton.mas_bottom)?.offset()(15)
        }
        
    }
    
    @objc func viewIsTapped(sender:NSObject) {
        
//        if DeviceManager.shared.isCollectedToWifi{
//
//        } else {
//            present(WifiConnectGuidanceViewController.init(), animated: true, completion: nil)
//        }
        self.navigationController?.pushViewController(DeviceAdjustViewController(), animated: true)

//        UIView.animate(withDuration: 0.25, animations: {
//            self.deviceButton.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
//        }) { (success) in
//            if success {
//                UIView.animate(withDuration: 0.25, animations: {
//                    self.deviceButton.transform = CGAffineTransform.identity
//                }){(success) in
//                    if success {
//                        self.navigationController?.pushViewController(DeviceAdjustViewController(), animated: true)
//                    }
//                }
//            }
//        }
        
        
        
        print_Debug(message: "viewDebug is tapped", prlogLevel: LogLevel.testClose)
    }
    
    

}
