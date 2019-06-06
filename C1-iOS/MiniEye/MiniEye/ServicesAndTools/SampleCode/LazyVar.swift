//
//  LazyVar.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/21.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import Foundation
import UIKit

class NoUserSampleCodeContainer {
    
    
    lazy var seperatorView:BasicView = {
        
        let view = BasicView.init()
        view.backgroundColor = CommonColor.seperatorLine
        
        return view
    }()
    
    lazy var leftImageView:BasicImageView = {
        let imageV = BasicImageView.init()
        
        return imageV
    }()
    
    lazy var rightSwitch:UISwitch = {
        let switchView = UISwitch.init()
        
        return switchView
    }()
    
    lazy var contactTextField:BasicTextField = {
        let textF = BasicTextField.init()
//        textF.delegate = self
        textF.font = UIFont.systemFont(ofSize: 16)
        textF.placeholder = " 联系人"
        textF.boardColor(CommonColor.grayText,width:1).cornerRadius(5)
        return textF
    }()
    
    lazy var questionTextView:BasicTextView = {
        let textV = BasicTextView.init()
        textV.text = "问题描述"
        textV.textColor = CommonColor.grayText
        textV.font = UIFont.systemFont(ofSize: 16)
//        textV.delegate = self
        textV.boardColor(CommonColor.grayText,width:1).cornerRadius(5)
        return textV
    }()
    
    
    lazy var logOutButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.backgroundColor = CommonColor.buttonBG
        button.setTitle("退出登录", for: UIControl.State.normal)
        button.cornerRadius(5.0)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    
    @objc func viewIsTapped(sender:NSObject) {
        print_Debug(message: "viewDebug is tapped", prlogLevel: LogLevel.testClose)
    }
    
    lazy  var userProfileLabel:BasicLabel = {
        let label = BasicLabel.initWith(text: "哥就是一个传说")
        label.textAlignment = .left
        label.font = CommonFont.content
        
        return label
    }()
    
    enum buttonName:String {
        case 分享
        case 删除
        case QQ
        case 微信
        case 微博
    }
    
    lazy var buttonArray:[BasicButton] = {
        let titileArr = [buttonName.QQ,buttonName.微信,buttonName.微博]
        var btArray = [BasicButton]()
        
        for i in 0..<titileArr.count {
            let button = BasicButton.init(type: UIButton.ButtonType.custom)
            //            button.setTitleColor(defaultBlackColor, for: UIControl.State.normal)
            button.setImage(CommonImage.size30AvatarPlaceHolder, for: UIControl.State.normal)
//            button.cornerRadius(shareButtonEdge)
            button.setViewDescribe(string: titileArr[i].rawValue)
            button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
            btArray.append(button)
        }
        return btArray
    }()
    
    
    lazy var searchBar:UISearchBar = {
        let searchBar = UISearchBar.init()
        searchBar.placeholder = "原密码"
//        searchBar.delegate = self
        searchBar.returnKeyType     = .search
        searchBar.frame = CGRect.init(x: 0, y: UIApplication.shared.statusBarFrame.height, width: ScreenW - 40 , height: 44)
        searchBar.showsCancelButton = false
        
        return searchBar
    }()
    
    let cellReuseID = "MyTableViewCellReuseID"
    
    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableView.backgroundColor = UIColor.white
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.register(CommonInfoTableViewCell.self, forCellReuseIdentifier: cellReuseID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 180 + 40
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    
    lazy var containScrollView:UIScrollView = {
        let scrollView = UIScrollView.init()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.delegate = self
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }else {
//            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        return scrollView
    }()
    
    lazy var myCaptureCollectionView:UICollectionView = {
        
        let flowOut = UICollectionViewFlowLayout.init()
        flowOut.minimumLineSpacing = 5.0
        flowOut.minimumInteritemSpacing = 5.0
        flowOut.sectionInset = UIEdgeInsets(top: 5, left: defaultCellContentHorizitalMargin, bottom: 5, right: defaultCellContentHorizitalMargin)
//        flowOut.itemSize =  CGSize.init(width: (ScreenW-defaultCellContentHorizitalMargin*2-3*5)/3, height: imageHeight)
        
        let collectionView = UICollectionView.init(frame: CGRect.init(x: ScreenW, y:0, width: ScreenW, height: ScreenH - NavigationBarH ), collectionViewLayout: flowOut)
        collectionView.backgroundColor = UIColor.white
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
        //        collectionView.register(CYTShortVedioCoverCollectionViewCell.self, forCellWithReuseIdentifier: CYTShortVedioCoverCollectionViewCellID)
        //        collectionView.register(CYTChallengeDetailHeader.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader , withReuseIdentifier: CYTChallengeDetailHeaderID)
        //
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }else {
//            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        return collectionView
    }()

}
