//
//  AJTProgressHUD.swift
//  anjet charger
//
//  Created by 朱慧林 on 2018/5/21.
//  Copyright © 2018年 Anjet. All rights reserved.
//

import UIKit

public typealias buttonTapBlock = ()->Void

class ProgressHUD: MBProgressHUD {
    
    var btTapBlock:buttonTapBlock?
    
    class func showNoMoreDataHUD(on View:UIView,animated:Bool) {
        MBProgressHUD.hide(for: View, animated: animated)
        
        let noMoreDataHUD = MBProgressHUD(view: View)
        noMoreDataHUD.mode = .customView
        noMoreDataHUD.backgroundView.color = CommonColor.black
        noMoreDataHUD.bezelView.backgroundColor = CommonColor.black
        noMoreDataHUD.bezelView.color = CommonColor.black
        noMoreDataHUD.offset = CGPoint.init(x: 0, y: -210)
        noMoreDataHUD.bezelView.style = .solidColor
        noMoreDataHUD.customView = createCustomNoDataView(on: noMoreDataHUD)
        noMoreDataHUD.margin = 0
        
        View.addSubview(noMoreDataHUD)
        noMoreDataHUD.show(animated: animated)
        
    }
    
    
    class func showInternetErrorHUD(on View:UIView,message:String?,animated:Bool,disappearAfter time:TimeInterval)  {
        self.internetErrorHUD(on: View, message: message, animated: animated)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            MBProgressHUD.hide(for: View, animated: true)
        }
    }
    
  
    convenience init(on View:UIView,animated:Bool,with refreshBlock:buttonTapBlock?) {
        
        self.init(view: View)
        MBProgressHUD.hide(for: View, animated: animated)
        
        View.addSubview(self)
        View.backgroundColor = UIColor.colorWithHex(hex: 0xf2f2f2)
        backgroundView.color = UIColor.colorWithHex(hex: 0xf2f2f2)
        bezelView.backgroundColor = UIColor.colorWithHex(hex: 0xf2f2f2)
        mode = .customView
        offset = CGPoint.init(x: 0, y: -210)
        bezelView.style = .solidColor
        customView = createCustomInternetErrorView(on:self)
        margin = 0
        btTapBlock = refreshBlock
        
        self.show(animated: true)
        
    }
    
    
    
    @objc func buttonIsTapped(bt:UIButton)  {
        if btTapBlock != nil {
            btTapBlock!()
        }
    }

    class func internetErrorHUD(on View:UIView,message:String?,animated:Bool) {
        MBProgressHUD.hide(for: View, animated: false)
        
        let internetErrorHUD = MBProgressHUD(view: View)
        View.addSubview(internetErrorHUD)
        internetErrorHUD.mode = .customView
        let imageView = UIImageView.init(image: #imageLiteral(resourceName: "netWordIsInTrouble"))
        internetErrorHUD.customView = imageView
        internetErrorHUD.bezelView.backgroundColor = .white
        if let trMessage = message {
            internetErrorHUD.label.text = NSLocalizedString(trMessage, comment: "")
        }else{
            internetErrorHUD.label.text = NSLocalizedString("Internet error!", comment: "")
        }
        internetErrorHUD.show(animated: animated)
    }
    
    
    
 class func showLoadingDataHUD(on View:UIView,animated:Bool) {
    showLoadingDataHUD(on: View, with: NSLocalizedString("loadingData...", comment: ""), animated: animated)
    }
    
    class func showLoadingDataHUDAsyncOnMainThread(on View:UIView,animated:Bool) {
        DispatchQueue.main.async {
            self.showLoadingDataHUD(on:View,animated:animated)
        }
    }
    
    
    class func showActivityIndicatorLoadingDataHUD(on View:UIView,
                                                   with status:String = NSLocalizedString("loadingData...", comment: ""),
                                                   animated:Bool){
        MBProgressHUD.hide(for: View, animated:animated)
        if View.isKind(of: UIScrollView.self) {
            (View as! UIScrollView).isScrollEnabled = false
        }
        
        let loadDataHUD = MBProgressHUD(view: View)
        View.addSubview(loadDataHUD)
        loadDataHUD.label.text = status
        loadDataHUD.mode = .indeterminate
        loadDataHUD.bezelView.style = .blur
        loadDataHUD.show(animated: animated)
    }
    
    
    
    class func showLoadingDataHUD(on View:UIView,with status:String,animated:Bool) {
        
        MBProgressHUD.hide(for: View, animated:animated)
        if View.isKind(of: UIScrollView.self) {
            (View as! UIScrollView).isScrollEnabled = false
        }

        let loadDataHUD = MBProgressHUD(view: View)
        View.addSubview(loadDataHUD)
        loadDataHUD.mode = .indeterminate
        loadDataHUD.show(animated: animated)
        
    }
    
    
  class  func hideHUD(on view:UIView,animated:Bool) {
        MBProgressHUD.hide(for: view, animated:animated)
    
    for subview in view.subviews {
        if subview.isKind(of: MBProgressHUD.self){
            subview.removeFromSuperview()
        }
    }
    
        if view.isKind(of: UIScrollView.self) {
            (view as! UIScrollView).isScrollEnabled = true
        }
    }
    
    
    class  func hideHUDAsyncOnMainThread(on view:UIView,animated:Bool) {
        
        DispatchQueue.main.async {
            self.hideHUD(on: view, animated: animated)
        }
    }
    
    class  func hideHUDSyncOnMainThread(on view:UIView,animated:Bool) {
        
        DispatchQueue.main.async {
            self.hideHUD(on: view, animated: animated)
        }
    }
    
    
    
}




extension ProgressHUD {
    
    func createCustomInternetErrorView(on View:UIView)->UIView{
        let buttonHeight:CGFloat = 40
        
        let viewContainer = UIView()
        viewContainer.backgroundColor = UIColor.colorWithHex(hex: 0xf2f2f2)
        let imageView = UIImageView.init(image: #imageLiteral(resourceName: "netWordIsInTrouble"))
        let label = UILabel()
        label.text = NSLocalizedString("Internet error!", comment: "")
        let button = UIButton()
        button.setTitle(NSLocalizedString("Refresh", comment: ""), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = buttonHeight/2
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(self.buttonIsTapped(bt:)), for: .touchUpInside)
        viewContainer.addSubview(imageView)
        viewContainer.addSubview(label)
        viewContainer.addSubview(button)
        
        imageView.mas_makeConstraints { (make) in
            make?.centerX.equalTo()(viewContainer)
            make?.top.equalTo()(viewContainer)?.offset()(85)
            make?.size.equalTo()(imageView.image?.size)
        }
        label.mas_makeConstraints { (make) in
            make?.centerX.equalTo()(viewContainer)
            make?.top.equalTo()(imageView.mas_bottom)?.offset()(22)
            make?.left.lessThanOrEqualTo()(viewContainer)?.offset()(10)
            make?.right.lessThanOrEqualTo()(viewContainer)?.offset()(-10)
            make?.height.mas_equalTo()(30)
        }
        button.mas_makeConstraints { (make) in
            make?.centerX.equalTo()(viewContainer)
            make?.top.equalTo()(label.mas_bottom)?.offset()(52)
            make?.width.mas_equalTo()(ScreenW/3)
            make?.height.mas_equalTo()(buttonHeight)
            make?.bottom.equalTo()(viewContainer)?.offset()(-20)
        }
        viewContainer.layoutIfNeeded()
        return viewContainer
    }
    
   private static func createCustomNoDataView(on View:UIView)->UIView{
        
        let viewContainer = UIView()
        viewContainer.backgroundColor = UIColor.colorWithHex(hex: 0xf2f2f2)
        let imageView = UIImageView.init(image: #imageLiteral(resourceName: "noMoreDataNow"))
        let label = UILabel()
        label.textAlignment = .center
        label.text = NSLocalizedString("No more data", comment: "")
    
        viewContainer.addSubview(imageView)
        viewContainer.addSubview(label)
        
        imageView.mas_makeConstraints { (make) in
            make?.centerX.equalTo()(viewContainer)
            make?.top.equalTo()(viewContainer)?.offset()(85)
            make?.left.lessThanOrEqualTo()(viewContainer)?.offset()(10)
            make?.right.lessThanOrEqualTo()(viewContainer)?.offset()(-10)
            make?.size.equalTo()(imageView.image?.size)
        }
        
        label.mas_makeConstraints { (make) in
            make?.centerX.equalTo()(viewContainer)
            make?.top.equalTo()(imageView.mas_bottom)?.offset()(22)
            make?.left.lessThanOrEqualTo()(viewContainer)?.offset()(10)
            make?.right.lessThanOrEqualTo()(viewContainer)?.offset()(-10)
            make?.height.mas_equalTo()(30)
            make?.bottom.equalTo()(viewContainer)?.offset()(-20)
        }
       
        viewContainer.layoutIfNeeded()
        return viewContainer
    }
    
}
