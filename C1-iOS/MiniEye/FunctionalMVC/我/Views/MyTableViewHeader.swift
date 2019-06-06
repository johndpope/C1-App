//
//  MyTableViewHeader.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/8.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit
import Masonry

class MyTableViewHeader: BasicView {
    
    let viewHeight:CGFloat = 45
    let viewWidth:CGFloat = 25
    let viewMargin:CGFloat = 60
    
    
    let avatarHeight:CGFloat = 60
    let edgeMarigin:CGFloat = 20
    
    
    
    enum ViewDescribe:String {
        case 头像
        case 登录
        case 跳转
        case 用户
        case 分享
        case 关注
        case 好友
    }
    
    
    lazy var avatarButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setImage(UIImage.init(named: "头像")!, for: UIControl.State.normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        //        button.setViewDescribe(string: MyTableViewHeader.ViewDescribe.头像.rawValue)
        //        button.addTarget(self, action: #selector(viewIsTapped(button:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    
    
    lazy var loginButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setTitle("登录/注册", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(CommonColor.black, for: UIControl.State.normal)
        //        button.setViewDescribe(string: MyTableViewHeader.ViewDescribe.登录.rawValue)
        //        button.addTarget(self, action: #selector(viewIsTapped(button:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    lazy var jumpButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setImage(UIImage.init(named: "arrow_right")!, for: UIControl.State.normal)
        //        button.setViewDescribe(string: MyTableViewHeader.ViewDescribe.跳转.rawValue)
        //        button.addTarget(self, action: #selector(viewIsTapped(button:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    
    lazy var shareViewArray:[BasicView] = {
        let titileArr = ["分享","关注","好友"]
        var btArray = [BasicView]()
        
        for i in 0..<titileArr.count {
            let view = BasicView()
            
            let button = BasicButton.init(type: UIButton.ButtonType.custom)
            button.setImage(UIImage.init(named: titileArr[i]), for: UIControl.State.normal)
            button.setViewDescribe(string: titileArr[i])
            button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
            
            let label = BasicLabel.initWith(text: titileArr[i], font: UIFont.systemFont(ofSize: 14), textColor: CommonColor.grayText, textAlignment: NSTextAlignment.center)
            
            view.addSubview(button)
            view.addSubview(label)
            
            button.mas_makeConstraints { (make) in
                make?.top.equalTo()(view)
                make?.centerX.equalTo()(view)
            }
            
            label.mas_makeConstraints { (make) in
                make?.bottom.equalTo()(view)
                make?.centerX.equalTo()(view)
            }
            
            btArray.append(view)
        }
        return btArray
    }()
    
    class ContainerView: BasicView {
        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            return self
        }
    }
    
    lazy var userInfoContainView:ContainerView = {
        let view = ContainerView.init()
        view.isUserInteractionEnabled = true
        view.setViewDescribe(string: MyTableViewHeader.ViewDescribe.用户.rawValue)
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(viewIsTapped(sender:))))
        
        return view
    }()
    
    lazy  var userNameLabel:BasicLabel = {
        let label = BasicLabel.initWith(text: "大哥")
        label.textAlignment = .left
        label.font = CommonFont.content
        label.isHidden = true
        
        return label
    }()
    
    lazy  var userProfileLabel:BasicLabel = {
        let label = BasicLabel.initWith(text: "哥就是一个传说")
        label.textAlignment = .left
        label.font = CommonFont.content
        label.isHidden = true
        
        return label
    }()
    
    lazy var seperatorView:BasicView = {
        
        let view = BasicView.init()
        view.backgroundColor = CommonColor.seperatorLine
        
        return view
    }()
    
    var viewTappedBlock:viewClicked?
    
    var model:UserAccountData? {
        didSet{
            guard let trUserAccount = model else {
                return
            }
            
            if trUserAccount.isLogin() {
                loginButton.isHidden = true
                userProfileLabel.isHidden = false
                userNameLabel.isHidden = false
                userNameLabel.text = trUserAccount.userName ?? "你还没名字呢"
                userProfileLabel.text = trUserAccount.signature ?? "这家伙什么都没留下"
                configureSubviews()
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
        addSubview(seperatorView)
        addSubview(userInfoContainView)
        
        
        seperatorView.mas_makeConstraints { (make) in
            make?.centerY.equalTo()(self.mas_bottom)?.offset()(-40)
            make?.left.right().equalTo()(self)?.offset()
            make?.height.mas_equalTo()(1)
        }
        
        for i in 0..<shareViewArray.count {
            let view = shareViewArray[i]
            
            addSubview(view)
            let spacing = (ScreenW - viewWidth * CGFloat(shareViewArray.count) - 2 * viewMargin)/CGFloat(shareViewArray.count - 1)
            let leftMargin = viewMargin + CGFloat(i) * (viewWidth + spacing)
            
            view.mas_makeConstraints { (make) in
                make?.centerY.equalTo()(self.seperatorView.mas_bottom)?.offset()(-self.viewHeight/2-15)
                make?.left.equalTo()(self)?.offset()(leftMargin)
                make?.size.mas_equalTo()(CGSize.init(width: self.viewWidth, height: self.viewHeight))
            }
        }
        
        userInfoContainView.mas_makeConstraints { (make) in
            make?.bottom.equalTo()(self.shareViewArray[0].mas_top)?.offset()(-25)
            make?.left.right()?.top().equalTo()(self)
        }
        
        userInfoContainView.addSubview(avatarButton)
        userInfoContainView.addSubview(jumpButton)
        userInfoContainView.addSubview(userNameLabel)
        userInfoContainView.addSubview(userProfileLabel)
        userInfoContainView.addSubview(loginButton)
        
        avatarButton.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.userInfoContainView)?.offset()(30)
            make?.bottom.equalTo()(self.userInfoContainView)
            make?.size.mas_equalTo()(CGSize.init(width: self.avatarHeight, height: self.avatarHeight))
        }
        
        loginButton.sizeToFit()
        loginButton.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.avatarButton.mas_right)?.offset()(self.edgeMarigin)
            make?.centerY.equalTo()(self.avatarButton)
        }
        
        userNameLabel.sizeToFit()
        userNameLabel.mas_makeConstraints { (make) in
            make?.bottom.equalTo()(self.avatarButton.mas_centerY)?.offset()(-5)
            make?.left.equalTo()(self.avatarButton.mas_right)?.offset()(self.edgeMarigin)
        }
        
        userProfileLabel.sizeToFit()
        userProfileLabel.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.avatarButton.mas_centerY)?.offset()(5)
            make?.left.equalTo()(self.avatarButton.mas_right)?.offset()(self.edgeMarigin)
        }
        
        jumpButton.sizeToFit()
        jumpButton.mas_makeConstraints { (make) in
            make?.centerY.equalTo()(self.avatarButton)
            make?.right.equalTo()(self.userInfoContainView)?.offset()(-self.edgeMarigin)
        }
    }
    
}


extension MyTableViewHeader {
    
    @objc func viewIsTapped(sender:NSObject) -> () {
        if let trViewTappedBlock = viewTappedBlock {
            if sender.isKind(of: UIControl.self) {
                trViewTappedBlock(sender as! UIView,UIControl.Event.touchUpInside)
            }else if sender.isKind(of: UIGestureRecognizer.self){
                trViewTappedBlock((sender as! UIGestureRecognizer).view!,UIControl.Event.touchUpInside)
            }
        }
    }
    
}
