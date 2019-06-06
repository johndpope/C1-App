//
//  MyTableViewCell.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/8.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

let  commonInfoTableViewCellID = "commonInfoTableViewCellID"

class CommonInfoTableViewCell: UITableViewCell {
    
    let elementMargin:CGFloat = 12
    let horizalMargin:CGFloat = 28
    let verticalMargin:CGFloat = 15
    let rightContentImageViewHeight:CGFloat = 60
    
    
    
    lazy var leftImageView:BasicImageView = {
        let imageV = BasicImageView.init()
        
        return imageV
    }()
    
    lazy var rightSwitch:UISwitch = {
        let switchView = UISwitch.init()
        switchView.onTintColor = UIColor.colorWithHex(hex: 0x333C4F)
        switchView.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.valueChanged)
        switchView.isHidden = true
        
        return switchView
    }()
    
    
    lazy var rightImageView:BasicImageView = {
        let imageV = BasicImageView.init()
        
        return imageV
    }()
    
    lazy var rightContentImageView:BasicImageView = {
        let imageV = BasicImageView.init()
        imageV.cornerRadius(rightContentImageViewHeight/2)
        return imageV
    }()
    
    lazy var titleLabel:BasicLabel  = {
        let label = BasicLabel.initWith(text: "testText", textAlignment: .left )
        return label
    }()
    
    lazy var contentLabel:BasicLabel  = {
        let label = BasicLabel.initWith(text: nil, font: CommonFont.bdge, textColor: CommonColor.black)
        label.font = CommonFont.detail
        
        return label
    }()
    
    var model:CommonInfoModel?{
        didSet{
            guard let trModel = model else {
                return
            }
            configureSubviews(with:trModel)
        }
    }
    
    var switchChangeBlock:viewClicked?
    
    
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
        addSubview(leftImageView)
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(rightImageView)
        addSubview(rightSwitch)
        addSubview(rightContentImageView)
        
    }
    
    func configureSubviews(with model:CommonInfoModel) -> () {
        var lelftBasicView:UIView = self
        var rightBasicView:UIView = self
        
        if let imageInfo = model.leftImageInfo {
            CommonInfoModel.setImageFor(imageView: leftImageView, with: imageInfo)
            lelftBasicView = leftImageView
            leftImageView.isHidden = false

            leftImageView.sizeToFit()
            leftImageView.mas_makeConstraints { (make) in
                make?.centerY.equalTo()(self)
                make?.left.equalTo()(self)?.offset()(self.horizalMargin)
                make?.top.greaterThanOrEqualTo()(self)?.offset()(self.verticalMargin)
                make?.bottom.lessThanOrEqualTo()(self)?.offset()(-self.verticalMargin)
            }
            
        }else{
            leftImageView.isHidden = true
        }
        
        if  let title = model.titile {
            titleLabel.text = title
            titleLabel.sizeToFit()
            
            var leftMargin:CGFloat = self.horizalMargin
            
            if  lelftBasicView == leftImageView {
                leftMargin = elementMargin + (leftImageView.image?.size.width)!
            }
            
            titleLabel.mas_makeConstraints { (make) in
                make?.centerY.equalTo()(self)
                make?.left.equalTo()(lelftBasicView)?.offset()(leftMargin)
                make?.top.greaterThanOrEqualTo()(self)?.offset()(self.verticalMargin)
                make?.bottom.lessThanOrEqualTo()(self)?.offset()(-self.verticalMargin)
            }
        }
        
        
        if let imageInfo = model.rightImageInfo {
            CommonInfoModel.setImageFor(imageView: rightImageView, with: imageInfo)
            rightBasicView = rightImageView
            rightImageView.isHidden = false
            rightSwitch.isHidden = true
            
        }else {
            rightImageView.isHidden = true
            
            if model.hasRightSwitch {
                rightBasicView = rightSwitch
                rightSwitch.isHidden = false
            }else{
                rightSwitch.isHidden = true
                
                if let content = model.content {
                    contentLabel.text = content
                    rightBasicView = contentLabel
                    contentLabel.isHidden = false
                }else{
                    contentLabel.isHidden = true
                }
            }
        }
        
        if rightBasicView != self {
            rightBasicView.sizeToFit()
            rightBasicView.mas_makeConstraints { (make) in
                make?.centerY.equalTo()(self)
                make?.right.equalTo()(self)?.offset()(-self.horizalMargin)
                make?.top.greaterThanOrEqualTo()(self)?.offset()(self.verticalMargin)
                make?.bottom.lessThanOrEqualTo()(self)?.offset()(-self.verticalMargin)
            }
        }
        
        
        if rightBasicView == rightImageView {
            if let content = model.content {
                contentLabel.text = content
                contentLabel.isHidden = false
                contentLabel.sizeToFit()
                
                contentLabel.mas_makeConstraints { (make) in
                    make?.centerY.equalTo()(self)
                    make?.right.equalTo()(self.rightImageView.mas_left)?.offset()(-self.elementMargin)
                    make?.top.greaterThanOrEqualTo()(self)?.offset()(self.verticalMargin)
                    make?.bottom.lessThanOrEqualTo()(self)?.offset()(-self.verticalMargin)
                }
            }else{
                contentLabel.isHidden = true
                
               if let imageInfo = model.rightContentImageInfo {
                    CommonInfoModel.setImageFor(imageView: rightContentImageView, with:imageInfo)
                    rightContentImageView.isHidden = false
                
                rightContentImageView.mas_makeConstraints { (make) in
                    make?.centerY.equalTo()(self)
                    make?.right.equalTo()(self.rightImageView.mas_left)?.offset()(-self.elementMargin)
                    make?.top.greaterThanOrEqualTo()(self)?.offset()(self.verticalMargin)
                    make?.bottom.lessThanOrEqualTo()(self)?.offset()(-self.verticalMargin)
                }
                
               }else{
                    rightContentImageView.isHidden = true

                }
            }
        }
        
    }
    
    
    @objc func viewIsTapped(sender:NSObject) {
        if let trChangebloc = switchChangeBlock {
            trChangebloc(sender as! UISwitch,UIControl.Event.valueChanged)
        }
        print_Debug(message: "viewDebug is tapped", prlogLevel: LogLevel.testClose)
    }
    
    
}
