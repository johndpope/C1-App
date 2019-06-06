//
//  ThirdPartyShareView.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/23.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class ThirdPartyShareView: BasicView {
    
    enum buttonName:String {
        case 分享
        case 删除
        case QQ
        case 微信
        case 微博
    }
    
    
    static let elementSpacing:CGFloat = 10
    static let chooseBGViewHeight:CGFloat = SafeBottomMargin + elementSpacing + defaultButtonHeight + elementSpacing*2
    let shareButtonEdgeWidth:CGFloat = 50
    let shareButtonVerticalSpace:CGFloat = 20
    var shareViewHeight:CGFloat {
        get{
            return shareButtonEdgeWidth + shareButtonVerticalSpace * 2
        }
    }
        
        private static var chooseView:ThirdPartyShareView?
    
        lazy var chooseBackgroundView:BasicView = {
        
        let view = BasicView.init()
        view.backgroundColor = UIColor.white
        
        return view
        }()
        
        lazy var shareView:BasicView = {
        
        let view = BasicView.init()
        view.backgroundColor = UIColor.white
        
        return view
        }()
        
        lazy var shareBottonBGView:BasicView = {
        
        let view = BasicView.init()
        view.backgroundColor = UIColor.init(white: 1, alpha: 0.8)
        
        return view
        }()
        
        
        lazy var shareButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setTitle(buttonName.分享.rawValue, for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.backgroundColor = CommonColor.buttonBG
        button.cornerRadius(defaultButtonCornerRadius)
        
        button.setViewDescribe(string: buttonName.分享.rawValue)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        return button
        }()
        
        lazy var deleteButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setTitle(buttonName.删除.rawValue, for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.backgroundColor = CommonColor.buttonBG
        button.cornerRadius(defaultButtonCornerRadius)
        button.setViewDescribe(string: buttonName.删除.rawValue)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
        }()
        
        lazy var buttonArray:[BasicButton] = {
        let titileArr = [buttonName.QQ,buttonName.微信,buttonName.微博]
        var btArray = [BasicButton]()
        
        for i in 0..<titileArr.count  {
            let button = BasicButton.init(type: UIButton.ButtonType.custom)
            //            button.setTitleColor(defaultBlackColor, for: UIControl.State.normal)
            button.setImage(CommonImage.size30AvatarPlaceHolder, for: UIControl.State.normal)
            button.cornerRadius(shareButtonEdgeWidth/2)
            button.setViewDescribe(string: titileArr[i].rawValue)
            button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
            btArray.append(button)
           }
          return btArray
        }()
        
        var shareButtonTappedBlock:viewClicked?
    
        
        override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        
        }
        
        required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        }
        
        func configureSubviews() -> () {
        
        backgroundColor = .blue
        addSubview(chooseBackgroundView)
        addSubview(shareButton)
        addSubview(deleteButton)
        
        chooseBackgroundView.mas_makeConstraints { (make) in
        make?.left.right()?.bottom().equalTo()(self)
        make?.height.mas_equalTo()(ThirdPartyShareView.chooseBGViewHeight)
        }
        
        shareButton.mas_makeConstraints { (make) in
        make?.bottom.equalTo()(self)?.offset()(-ThirdPartyShareView.elementSpacing*2-SafeBottomMargin)
        make?.left.equalTo()(self)?.offset()(defaultCellContentHorizitalMargin)
        make?.width.equalTo()(self.deleteButton)
        make?.height.mas_equalTo()(defaultButtonHeight)
        }
        
        deleteButton.mas_makeConstraints { (make) in
        make?.height.centerY().equalTo()(self.shareButton)
        make?.left.equalTo()(self.shareButton.mas_right)?.offset()(defaultCellContentHorizitalMargin)
        make?.right.equalTo()(self)?.offset()(-defaultCellContentHorizitalMargin)
        }
        
        
        }
        
        @discardableResult
        static func  show(On view:UIView = keyWindow) -> ThirdPartyShareView{
        
        let showView = ThirdPartyShareView.init(frame: CGRect.init(x: 0, y: ScreenH, width: ScreenW, height:ThirdPartyShareView.chooseBGViewHeight ))
        view.addSubview(showView)
        view.bringSubviewToFront(showView)
        
        UIView.animate(withDuration: 0.25) {
        showView.frame = showView.frame.addPrperty(CGRect.property.y, value: -showView.frame.height)
        }
        chooseView = showView
        return showView
    }
        
        static func hide(On view:UIView = keyWindow) {
        
        UIView.animate(withDuration: 0.25, animations: {
        if let trView = chooseView {
        trView.frame = trView.frame.addPrperty(CGRect.property.y, value: trView.frame.height)
        }
        }) { (success) in
        if success{
        chooseView?.removeFromSuperview()
        chooseView = nil
           }
         }
        }
        
    }
    
    extension ThirdPartyShareView {
        
        @objc func viewIsTapped(sender:UIButton) -> () {
            if sender == shareButton {
                sender.isSelected = !sender.isSelected
                if sender.isSelected {
                    showShareView()
                }else{
                    hideShareView()
                }
            } else {
                if let trBlock = shareButtonTappedBlock {
                    trBlock(sender, UIControl.Event.touchUpInside)
                }
            }
            print_Debug(message: "button is tapped")
        }
        
        func showShareView() -> () {
            
            addSubview(shareView)
            sendSubviewToBack(shareView)
            shareView.addSubview(shareBottonBGView)
            
            
            let spacing = (ScreenW - ThirdPartyShareView.elementSpacing * 2 - CGFloat(buttonArray.count) * shareButtonEdgeWidth)/CGFloat(buttonArray.count + 1)
            shareView.frame = CGRect.init(x: 0,y: 0, width: ScreenW, height:shareViewHeight)
            
            shareBottonBGView.mas_makeConstraints { (make) in
                make?.center.equalTo()(self.shareView)
                make?.left.top()?.equalTo()(self.shareView)?.offset()(ThirdPartyShareView.elementSpacing)
            }
            
            for i in 0..<buttonArray.count {
                
                let button = buttonArray[i]
                
                shareBottonBGView.addSubview(button)
                button.mas_makeConstraints { (make) in
                    make?.centerY.equalTo()(self.shareBottonBGView)
                    make?.left.equalTo()(self.shareBottonBGView)?.offset()(spacing*CGFloat(i+1) + self.shareButtonEdgeWidth * CGFloat(i))
                }
            }
            
            
//            如果没有这句话，shareView的autolayout关系（子视图和父视图之间的距离和尺寸等）会执行一个重新创建的动画中，和其他的动画合并一起执行；
//            执行了这句话之后，会先将shareview的autolayout（各种视图布局）转化为frame设置好；动画的时候，执行layoutIfNeeded，autolayout关系也会执行，但是不会出现重新创建的动画
            layoutIfNeeded()
            
            UIView.animate(withDuration: 0.25, animations: {
                self.frame = self.frame.addPrperty(CGRect.property.height, value: self.shareViewHeight).addPrperty(CGRect.property.y, value: -self.shareViewHeight)
                self.layoutIfNeeded()
            }) { (success) in
                
            }
        }
        
        func hideShareView() -> () {
            
            UIView.animate(withDuration: 0.25, animations: {
                self.frame = self.frame.addPrperty(CGRect.property.height, value: -self.shareViewHeight).addPrperty(CGRect.property.y, value: self.shareViewHeight)
                self.layoutIfNeeded()
            }) { (success) in
            }
        }
}
