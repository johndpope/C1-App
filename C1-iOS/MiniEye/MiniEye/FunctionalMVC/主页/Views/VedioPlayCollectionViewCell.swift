//
//  VedioPlayCollectionViewCell.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/25.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class VedioPlayCollectionViewCell: UICollectionViewCell {
    
    let avatarEdgeLength:CGFloat = 20
    
    
    lazy var playerContainImageView:BasicImageView = {
        let imageV = BasicImageView.init()
        imageV.backgroundColor = UIColor.init(white: 0, alpha: 0.8)
        imageV.cornerRadius(5)
        return imageV
    }()
    
    lazy  var vedioBriefLabel:BasicLabel = {
        let label = BasicLabel.initWith(text: "惊现司机开车不开灯！！！！！")
        label.textAlignment = .left
        label.textColor = .white
        label.font = CommonFont.detail
        label.numberOfLines = 0
        
        return label
    }()
    
    
    lazy var likeButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setTitle(" 100", for: UIControl.State.normal)
        button.titleLabel?.font = CommonFont.detail
        button.setTitleColor(CommonColor.grayText, for: UIControl.State.normal)
        button.setImage(UIImage.init(named: "赞"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    lazy var watchedButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setTitle(" 3000", for: UIControl.State.normal)
        button.titleLabel?.font = CommonFont.detail
        button.setTitleColor(CommonColor.grayText, for: UIControl.State.normal)
        button.setImage(UIImage.init(named: "眼睛"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    lazy var avatarButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.cornerRadius(avatarEdgeLength/2)
        button.setImage(CommonImage.size30AvatarPlaceHolder, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureSubviews() -> () {
        addSubview(playerContainImageView)
        addSubview(vedioBriefLabel)
        addSubview(likeButton)
        addSubview(watchedButton)
        addSubview(avatarButton)
        
        playerContainImageView.mas_makeConstraints { (make) in
            make?.left.right()?.top()?.equalTo()(self)
            make?.height.mas_equalTo()(vedioPlayerHeight)
        }
        
        vedioBriefLabel.sizeToFit()
        vedioBriefLabel.mas_makeConstraints { (make) in
            make?.left.top()?.equalTo()(self.playerContainImageView)
            make?.width.mas_equalTo()(vedioPlayerWidth * 0.5)
        }
        
        likeButton.mas_makeConstraints { (make) in
            make?.right.equalTo()(self)?.offset()(-5)
            make?.top.equalTo()(self.playerContainImageView.mas_bottom)?.offset()(5)
            make?.height.mas_equalTo()(25)
        }
        
        watchedButton.mas_makeConstraints { (make) in
            make?.centerY.equalTo()(self.likeButton)
            make?.centerX.equalTo()(self.playerContainImageView)
            make?.height.mas_equalTo()(25)
        }
        
        avatarButton.mas_makeConstraints { (make) in
            make?.centerY.equalTo()(self.likeButton)
            make?.left.equalTo()(self)?.offset()(5)
            make?.size.mas_equalTo()(CGSize.init(width: self.avatarEdgeLength, height: self.avatarEdgeLength))
        }
        
        
        
    }
    
    
}

extension  VedioPlayCollectionViewCell {
    
    @objc func viewIsTapped(sender:NSObject) {
        print_Debug(message: "viewDebug is tapped", prlogLevel: LogLevel.testClose)
    }
    
}
