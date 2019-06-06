//
//  HomePageHeader.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/25.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class HomePageHeader: BasicView {
//
//    lazy var discoveryButton:BasicButton = {
//        return setChosenButton(with: "发现")
//    }()
//
//    lazy var activityButton:BasicButton = {
//        return setChosenButton(with: "活动")
//    }()
    
    let viewMargin:CGFloat = 90
    let viewWidth:CGFloat = 60
    
//
   private lazy var addButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setImage(UIImage.init(named: "发布视频"), for: UIControl.State.normal)
        button.setViewDescribe(string: "发布视频")
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    var titles = [String]() {
        didSet{
            setTitles()
        }
    }
    
 private  var buttonArray = [BasicButton]()
    
 private  lazy var underlyViewArray:[UIImageView] = {
            var imageViews = [UIImageView]()
            
            for _ in 0..<buttonArray.count {
                let imageView = UIImageView.init(image: UIImage.init(named: "选中下标")!)
                imageViews.append(imageView)
            }
            
            return imageViews
    }()
    
    var buttonIsTapped:viewClicked?
    
    
    private func setChosenButton(with title:String) -> BasicButton {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setTitle(title, for: UIControl.State.normal)
        button.setViewDescribe(string: title)
        button.setAttributedTitle(attributedString(for: UIControl.State.normal, originString: title), for: UIControl.State.normal)
        button.setAttributedTitle(attributedString(for: UIControl.State.selected, originString: title), for: UIControl.State.selected)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }
    
    private func attributedString(for state:UIControl.State,originString:String) -> NSAttributedString {
        let attributeString = NSMutableAttributedString.init(string: originString)
        let range = NSRange.init(location: 0, length: originString.count)
        
        if state == .selected {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : CommonColor.black,NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 22)], range: range)
        } else if state == .normal {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : CommonColor.black,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)], range: range)
        }
        
        return attributeString
    }
    
    init(titles:[String]) {
        super.init(frame: CGRect.zero)
        self.titles = titles
        setTitles()
        changeViewStatesAsButtonSelected(with: buttonArray[0])
        configureSubviews()
    }
    
    deinit {
        removeObserver(self, forKeyPath: #keyPath(UIButton.isSelected))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func setTitles() -> () {
        
        guard titles.count > 0 else {
            return
        }
        buttonArray.removeAll()
        for i in 0..<titles.count {
            let button = setChosenButton(with: titles[i])
            buttonArray.append(button)
        }
    }
    
  
   private func configureSubviews() -> () {
        
        addSubview(addButton)
        addButton.sizeToFit()
        addButton.mas_makeConstraints { (make) in
            make?.centerY.equalTo()(self)
            make?.right.equalTo()(-20)
        }
        
        for i in 0..<buttonArray.count {
            let button = buttonArray[i]
            let underlyImageView = underlyViewArray[i]
            
            addSubview(button)
            addSubview(underlyImageView)
            
            let spacing = (ScreenW - viewWidth * CGFloat(buttonArray.count) - 2 * viewMargin)/CGFloat(buttonArray.count - 1)
            let centerMargin = viewMargin + viewWidth/2 + CGFloat(i) * (viewWidth + spacing)
            
            button.mas_makeConstraints { (make) in
                make?.centerY.equalTo()(self)
                make?.centerX.equalTo()(self.mas_left)?.offset()(centerMargin)
                make?.size.mas_equalTo()(CGSize.init(width: self.viewWidth, height: 30))
            }
            
            underlyImageView.sizeToFit()
            underlyImageView.mas_makeConstraints { (make) in
                make?.centerX.equalTo()(button)
                make?.top.equalTo()(button.mas_bottom)?.offset()(0)
            }
        }
    }
    
   public func changeButtonSelectedAtIndex(_ index:Int) -> () {
             changeViewStatesAsButtonSelected(with: buttonArray[index])
    }
    

}


extension HomePageHeader {
    
    
    @objc func viewIsTapped(sender:BasicButton){
        
        if let trBlock = buttonIsTapped {
            trBlock(sender,UIControl.Event.touchUpInside)
        }

        if buttonArray.contains(sender) {
            changeViewStatesAsButtonSelected(with: sender)
        }
        print_Debug(message: "homepage button is tapped,sender")
    }
    

  private func changeViewStatesAsButtonSelected(with button:BasicButton) -> () {
        let index = buttonArray.firstIndex(of: button)
        for i in 0..<buttonArray.count {
            if i != index {
                buttonArray[i].isSelected = false
                underlyViewArray[i].isHidden = true
            }else{
                buttonArray[i].isSelected = true
                underlyViewArray[i].isHidden = false
            }
        }
        
    }
}
