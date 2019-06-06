//
//  YHMainNavigationVC.swift
//  ttkhj
//
//  Created by nin on 2017/6/27.
//  Copyright © 2017年 yunhang. All rights reserved.
//

import UIKit


class BasicNavigationVC: UINavigationController {
    
    var isChargingCompleteVCFromWaiting:Bool = false
    var isChargingWaitVCFromInitial:Bool = true
    var isUnlockVC:Bool = false
    
    lazy var secondPushOrPopInfo:[String:Any]? = [String:Any]()
    
    var vcPopToBeforeChargingPush:UIViewController?
    lazy var placeholderBt:UIButton = UIButton.init(type: .custom)
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.delegate = self
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return topViewController

    }
    
    /*
     设置状态栏颜色
     */
//    @objc override var childViewControllerForStatusBarStyle: UIViewController?{
//        var targetVC = UIViewController.init()
//
//        for VC in self.childViewControllers {
//            if VC.isKind(of: CYTSelectMusicMainViewController.self) ||
//                VC.isKind(of: CYTVedioCollectionForMusicViewController.self) ||
//                VC.isKind(of: HLPagingViewController.self)
//            {
//                targetVC = VC
//            }
//        }
//        return targetVC
//    }
 
  
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return  (self.children.count > 1)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {

        if self.children.count == 1 {
            // 隐藏tabbar
            viewController.hidesBottomBarWhenPushed = true
            
        }
        
//        加大返回按钮占位区域
    
        if self.children.count > 0 {
            // 如果push进来的不是第一个控制器，就增加左侧返回按钮

            let button = UIButton.init(type: .custom)
            button.setImage(UIImage.init(named: "leftArrow"), for: .normal)
            button.frame = CGRect.init(x: 0, y: 0, width: 60, height: 44)
            button.contentHorizontalAlignment = .left

            button.addTarget(self, action: #selector(self.back(_:)), for: .touchUpInside)
            // 修改导航栏左边的item
            let leftBarButtonItem = UIBarButtonItem(customView: button)
            viewController.navigationItem.leftBarButtonItems = [leftBarButtonItem]

            viewController.extendedLayoutIncludesOpaqueBars = false
        }
        
        
        super.pushViewController(viewController, animated: animated)
    }
    
   
    
//    所有navigationController push 出来VC，都统一添加leftBarButtonItem，设置方法为back回退
    @objc private func back(_ sender : UIButton){
        
//        if (topViewController?.isKind(of: ChargingCompleteViewController.self))!,
//             (topViewController as! ChargingCompleteViewController).isChargeEndedShow {
//            // 如果我们结束了充电，会首先通过充电等待、然后到达充电完成界面，此时，点击back按钮，效果是无论在哪个界面，关闭掉弹出来的充电等待、充电完成界面；
//
//            let chargingCompleteVC = topViewController as! ChargingCompleteViewController
//
//            //  pop掉充电完成界面和等待充电界面（因为充电完成界面可以从任何界面跳转过来）
//             if chargingCompleteVC.isFromWaitChargeVC {
//
//                let tabVC = AJTMainTabBarVC()
//                tabVC.selectedIndex = 0
//
//                keyWindow.rootViewController = tabVC
//            }else {
//
////                从其他界面跳过来的，连续pop两个界面，会出现视图停留（另一个pop掉的没办法立即消失，而是看到之后再pop）
//                let tabVC = AJTMainTabBarVC()
//                tabVC.selectedIndex = 1
//
//                keyWindow.rootViewController = tabVC
//            }
//
//        }else if (topViewController?.isKind(of: UnlockViewController.self))!{
//            //如果是充电锁视图控制器回退
//            let unlockVC = topViewController as! UnlockViewController
//            if let trFromChargingWait = unlockVC.isFromInitialChargingWait ,trFromChargingWait {
//            //  如果是起始界面跳转过来的，直接关闭掉充电等待和充电锁界面
//                vcPopToBeforeChargingPush = childViewControllers[childViewControllers.index(of: topViewController!)! - 2]
//               let _ = popToViewController(vcPopToBeforeChargingPush!, animated: true)
//            }
//
//        } else if (topViewController?.isKind(of: ScanChargerViewController.self))!{
//            serverData?.completionDelegate = nil
//            self.tabBarController?.selectedIndex = 0
//
//        }else  {
         let _ = popViewController(animated: true)
//        }
    }
}

extension BasicNavigationVC:UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//        分步骤跳转：pop视图的时候，如果直接使用tabBarController?.selectedIndex，会导致hidesBottomWhenPushed隐藏的tabbar出BUG，因此，需要过渡跳转。
      
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
      
    }
    
}

