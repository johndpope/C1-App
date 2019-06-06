//
//  CommonAlumImageCollectionViewCell.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/22.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit


class CommonAlbumImageCollectionViewHeader: UICollectionReusableView {
    
    lazy  var timeLabel:BasicLabel = {
        let label = BasicLabel.initWith(text: "哥就是一个传说")
        label.textAlignment = .left
        label.font = CommonFont.content
        
        return label
    }()
    
    var timeString:String? {
        didSet{
            if let trStr = timeString {
                timeLabel.text = trStr
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() -> () {
        addSubview(timeLabel)
        
        timeLabel.sizeToFit()
        timeLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self)?.offset()(-defaultCellContentHorizitalMargin)
            make?.top.bottom().equalTo()(self)
        }
    }
    
}



class CommonAlumCollectionViewCell: UICollectionViewCell {
    
    lazy var contentImageView:BasicImageView = {
        let imageV = BasicImageView.init()
        imageV.image = CommonImage.size30AvatarPlaceHolder
        imageV.contentMode = UIView.ContentMode.scaleAspectFill
        imageV.clipsToBounds = true
        
        return imageV
    }()
    
    lazy var selectButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setImage(UIImage.init(named: "arrow_right")!, for: UIControl.State.normal)
        button.isHidden = true
        //        button.setViewDescribe(string: MyTableViewHeader.ViewDescribe.跳转.rawValue)
        //        button.addTarget(self, action: #selector(viewIsTapped(button:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model:CommonAlbumItemModel? {
        didSet{
            if let trModel = model {
               selectButton.isHidden = !trModel.isChosenStyle
               selectButton.isSelected  = trModel.isSelected && !selectButton.isHidden
                contentImageView.image = trModel.image
            }
        }
    }
    
    
    func configureSubviews() -> () {
        addSubview(contentImageView)
        addSubview(selectButton)
        
        contentImageView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self)
        }
        
        selectButton.sizeToFit()
        selectButton.mas_makeConstraints { (make) in
            make?.right.bottom()?.equalTo()(self.contentImageView)
        }
    }
    
}
