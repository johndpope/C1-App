//
//  HomePageViewController.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/8.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class HomePageViewController: BasicViewController {
    
    let contentControllerHeight = ScreenH - SafeStatusBarHeight - NavigationBarH - TabBarH - SafeBottomMargin
    let titles = ["发现","活动"]

    lazy var header:HomePageHeader = {
       let header = HomePageHeader.init(titles: titles)
       
        return header
    }()
    
    lazy var contentControllers:[BasicViewController] = [DiscoveryViewController(),ActivityViewController()]
    
    
    lazy var containScrollView:BasicScrollView = {
        let scrollView = BasicScrollView.init()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.white
        scrollView.bounces = false
        
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        return scrollView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        header.buttonIsTapped = { (view,event ) in
            
        switch  view.viewDescribe() {
            case self.titles[0]:
                self.containScrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
                print_Debug(message: "find responder in home page vc")
            case self.titles[1]:
                self.containScrollView.setContentOffset(CGPoint.init(x: ScreenW, y: 0), animated: true)
                print_Debug(message: "activity responder in home page vc")
            default:
                print_Debug(message: "add av vedio responder in home page vc")
            }
        }
    }
    
    
   override func configureSubviews() -> () {
        super.configureSubviews()
        view.backgroundColor = UIColor.white
        
        view.addSubview(header)
        header.mas_makeConstraints { (make) in
            make?.left.right()?.equalTo()(self.view)
            make?.top.equalTo()(self.view)?.offset()(SafeStatusBarHeight)
            make?.height.mas_equalTo()(NavigationBarH)
        }
        
        view.addSubview(containScrollView)
        containScrollView.mas_makeConstraints { (make) in
            make?.left.right().equalTo()(self.view)
            make?.height.mas_equalTo()(self.contentControllerHeight)
            make?.top.equalTo()(self.view)?.offset()(SafeStatusBarHeight + NavigationBarH)
        }
        
        for i in 0..<contentControllers.count {
            let controller = contentControllers[i]
            let contentView = controller.view
            
            addChild(controller)
            containScrollView.addSubview(contentView!)
            
            contentView?.mas_makeConstraints({ (make) in
                make?.width.mas_equalTo()(ScreenW)
                make?.height.mas_equalTo()(self.contentControllerHeight)
                make?.left.equalTo()(self.containScrollView)?.offset()(ScreenW * CGFloat(i))
                make?.right.equalTo()(self.containScrollView)?.offset()(-ScreenW * CGFloat(self.contentControllers.count - i - 1))
            })
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
}


extension HomePageViewController:UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == containScrollView else {
            return
        }
        let index = NSInteger(scrollView.contentOffset.x/CGFloat(scrollView.frame.width))
        
        header.changeButtonSelectedAtIndex(index)
    }
    
}
