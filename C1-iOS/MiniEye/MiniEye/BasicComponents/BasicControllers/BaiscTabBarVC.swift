//
//  YHMainTabBarVC.swift
//  ttkhj
//
//  Created by nin on 2017/6/27.
//  Copyright © 2017年 yunhang. All rights reserved.
//

import UIKit

class BaiscTabBarVC: UITabBarController,UITabBarControllerDelegate {

    static var topCommonVC:BasicViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildViewControllers()
        delegate = self
    }

  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        addTestButton()
    }
    
    
    lazy var testButton:UIButton = {
       let bt = UIButton()
        bt.setTitle("test", for: .normal)
        bt.setTitleColor(.red, for: .normal)
        bt.sizeToFit()
//        bt.center = CGPoint.init(x: ScreenW/2, y: StatusBarH + NavigationBarH + 20)
        bt.addTarget(self, action: #selector(testButtonTapped), for: .touchUpInside)
        return bt
    }()
    
//    func addTestButton() {
//        keyWindow.addSubview(testButton)
//        keyWindow.bringSubview(toFront: testButton)
//    }
    
    @objc(testButtonTapped)
    func testButtonTapped()  {
//        if SVProgressHUD.isVisible() {
//            SVProgressHUD.popActivity()
//        }else{

            if UIApplication.shared.canOpenURL(URL.init(string: "weixin://")!) {
             print("能够打开微信")
            }
            if UIApplication.shared.canOpenURL(URL.init(string: "com.weibo://")!) {
                print("能够打开微博")
            }
//            WXApi.isWXAppInstalled()
//        }
    
        
    }
    
    /**
     * 设置tabbar
     */
    fileprivate func addChildViewControllers()  {
        
        let homePageVC = HomePageViewController.init()
        let deviceVC = DeviceHomePageViewController.init()
        let myVC = MyViewController.init()
        let tabBarItemTitle = ["首页","设备","我"]
        let tabBarItemSelectedTitle = ["首页-selected","设备-selected","我-selected"]
        var tabBarItemImage = [UIImage]()
        var tabBarItemSelectedImages = [UIImage]()
        
        for i in 0..<3 {
            let noseleImage = UIImage.init(named: tabBarItemTitle[i])
            let seleImage =  UIImage.init(named: tabBarItemSelectedTitle[i])?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            tabBarItemImage.append(noseleImage!)
            tabBarItemSelectedImages.append(seleImage!)
        }
        
        let vcArr = [homePageVC,deviceVC,myVC]
        for i in 0..<vcArr.count {
               setChildViewController(vcArr[i], noselectImage: tabBarItemImage[i], selectImage: tabBarItemSelectedImages[i] ,title: tabBarItemTitle[i])
        }
    }
    
    
    
    func setChildViewController(_ vc:UIViewController,noselectImage:UIImage,selectImage:UIImage,title:String)  {
        
        let nav = BasicNavigationVC(rootViewController : vc)
       
        vc.tabBarItem.image = noselectImage
        vc.tabBarItem.selectedImage = selectImage
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : CommonColor.black], for: UIControl.State.selected)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : CommonColor.grayText], for: UIControl.State.normal)
        vc.title = title
        
        self.addChild(nav)
    }
}

extension BaiscTabBarVC  {
   
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        return true
    }
}

