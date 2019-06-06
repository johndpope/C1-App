//
//  AboutAppHeader.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/21.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class AboutAppHeader: BasicView {
    
    lazy var centerImageView:BasicImageView = {
        let imageV = BasicImageView.init()
        imageV.image = UIImage.init(named: "appIcon")
        imageV.cornerRadius(10)
        
        return imageV
    }()
    
    
    lazy  var verionLabel:BasicLabel = {
        let label = BasicLabel.initWith(text: "1.0.1")
        label.textAlignment = .center
        label.font = CommonFont.content
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() -> () {
        addSubview(centerImageView)
        addSubview(verionLabel)
  
        centerImageView.mas_makeConstraints { (make) in
            make?.centerX.equalTo()(self)
            make?.top.equalTo()(self)?.offset()(50)
            make?.size.mas_equalTo()(CGSize.init(width: 60, height: 60))
        }
        
        verionLabel.sizeToFit()
        verionLabel.mas_makeConstraints { (make) in
            make?.centerX.equalTo()(self)
            make?.top.equalTo()(self.centerImageView.mas_bottom)?.offset()(5)
        }
    
    }
    
}

