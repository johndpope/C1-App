//
//  HelpDeviceTableViewCell.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/21.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit


class HelpDeviceTableViewCell: UITableViewCell {
    
    lazy  var deviceTitleLabel:BasicLabel = {
        let label = BasicLabel.initWith(text: "哥就是一个传说")
        label.textAlignment = .left
        label.font = CommonFont.content
        
        return label
    }()
    
    lazy var leftImageView:BasicImageView = {
        let imageV = BasicImageView.init()
        
        return imageV
    }()
    lazy var containerView:BasicView = {
        
        let view = BasicView.init()
        view.backgroundColor = UIColor.init(white: 1, alpha: 0.6)
        
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupSubviews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupSubviews() {
        backgroundColor = UIColor.white
        addSubview(containerView)
        containerView.addSubview(leftImageView)
        containerView.addSubview(deviceTitleLabel)
        
        containerView.mas_makeConstraints { (make) in
            make?.left.equalTo()(self)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self)?.offset()(-defaultCellContentHorizitalMargin)
            make?.top.equalTo()(self)?.offset()(5)
            make?.bottom.equalTo()(self)?.offset()(-5)
        }
        
        leftImageView.sizeToFit()
        leftImageView.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.containerView)?.offset()(15)
            make?.bottom.equalTo()(self.containerView)?.offset()(-5)
            make?.top.equalTo()(self.containerView)?.offset()(5)
        }
        
        deviceTitleLabel.sizeToFit()
        deviceTitleLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.leftImageView.mas_right)?.offset()(20)
            make?.centerY.equalTo()(self.containerView)
        }
        
    }
    
    
    
}
