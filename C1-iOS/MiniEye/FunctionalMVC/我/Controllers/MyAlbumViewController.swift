//
//  MyAlbumViewController.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/22.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit
import Photos

class MyAlbumViewController: BasicViewController {
    
//    let imageHeight:CGFloat = 40
    let selectedButtonHeight:CGFloat = 50
    
    
    let cellID = "MyAlbumCollectionViewCellID"
    let headerID = "MyAlbumCollectionViewHeaderID"
    
    lazy var rightBarButton:BasicButton = {
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setTitleColor(CommonColor.black, for: UIControl.State.normal)
        button.setTitle("选择", for: UIControl.State.normal)
        button.setTitle("取消", for: UIControl.State.selected)
        button.addTarget(self, action: #selector(rightBarButtonIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    lazy var adasEmergenceButton:BasicButton = {
        return setChosenButton(with: "ADAS紧急视频")
    }()
    
    lazy var myCaptureButton:BasicButton = {
        return setChosenButton(with: "我的抓拍")
    }()
    
    lazy var seperatorView:BasicView = {
        
        let view = BasicView.init()
        view.backgroundColor = UIColor.init(white: 0.5, alpha: 0.6)
        
        return view
    }()
    
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
    
    lazy var adasCollectionView:BasicCollectionView = {
        
        let flowOut = UICollectionViewFlowLayout.init()
        flowOut.minimumLineSpacing = 5.0
        flowOut.minimumInteritemSpacing = 5.0
        flowOut.sectionInset = UIEdgeInsets(top: 5, left: defaultCellContentHorizitalMargin, bottom: 5, right: defaultCellContentHorizitalMargin)
        let width = (ScreenW-defaultCellContentHorizitalMargin*2-3*5)/3
        flowOut.itemSize =  CGSize.init(width: width, height: width)
        
        let collectionView = BasicCollectionView.init(frame: CGRect.init(x: 0, y:0, width: ScreenW, height: ScreenH - NavigationBarH ), collectionViewLayout: flowOut)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isDirectionalLockEnabled = true
        collectionView.register(CommonAlumCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(CommonAlbumImageCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        
        return collectionView
    }()
    
    lazy var myCaptureCollectionView:BasicCollectionView = {
        
        let flowOut = UICollectionViewFlowLayout.init()
        flowOut.minimumLineSpacing = 5.0
        flowOut.minimumInteritemSpacing = 5.0
        flowOut.sectionInset = UIEdgeInsets(top: 5, left: defaultCellContentHorizitalMargin, bottom: 5, right: defaultCellContentHorizitalMargin)
        let width = (ScreenW-defaultCellContentHorizitalMargin*2-3*5)/3
        flowOut.itemSize =  CGSize.init(width: width, height: width)
        
        let collectionView = BasicCollectionView.init(frame: CGRect.init(x: ScreenW, y:0, width: ScreenW, height: ScreenH - NavigationBarH ), collectionViewLayout: flowOut)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isDirectionalLockEnabled = true
        
        collectionView.register(CommonAlumCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(CommonAlbumImageCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        
        
        return collectionView
    }()
    
    
    var adasSectionModels = [CommonAlbumSectionModel]()
    var myCaptureSectionModels = [CommonAlbumSectionModel]()
    
    private func setChosenButton(with title:String) -> BasicButton {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setTitle(title, for: UIControl.State.normal)
        button.setAttributedTitle(attributedString(for: UIControl.State.normal, originString: title), for: UIControl.State.normal)
        button.setAttributedTitle(attributedString(for: UIControl.State.selected, originString: title), for: UIControl.State.selected)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }
    
    private func attributedString(for state:UIControl.State,originString:String) -> NSAttributedString {
        let attributeString = NSMutableAttributedString.init(string: originString)
        let range = NSRange.init(location: 0, length: originString.count)
        
        if state == .selected {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : CommonColor.black,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)], range: range)
        } else if state == .normal {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : CommonColor.grayText,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], range: range)
        }
        
        return attributeString
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let testCollection =  PhotosLibraryTool.shared.fetchImageCollection(in: self, albumTitle: "Test")
       adasSectionModels =  LocalPhotosDataManager.shared.fetchDeviceAssets(in: self)[0]
        myCaptureSectionModels = LocalPhotosDataManager.shared.fetchDeviceAssets(in: self)[1]
        
        print_Debug(message: "testCollection.count=\(testCollection.count)")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    deinit {
        ThirdPartyShareView.hide()
    }
    
    override func configureSubviews() -> () {
        super.configureSubviews()
        title = "我的相册"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        
        view.backgroundColor = UIColor.white
        view.addSubview(adasEmergenceButton)
        adasEmergenceButton.isSelected = true
        view.addSubview(myCaptureButton)
        view.addSubview(seperatorView)
        view.addSubview(containScrollView)
        containScrollView.addSubview(adasCollectionView)
        containScrollView.addSubview(myCaptureCollectionView)
        
        adasEmergenceButton.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)
            make?.top.equalTo()(self.view)?.offset()(SafeStatusBarHeight + NavigationBarH)
            make?.height.mas_equalTo()(self.selectedButtonHeight)
            make?.right.mas_equalTo()(self.myCaptureButton.mas_left)
            make?.width.equalTo()(self.myCaptureButton)
        }
        
        myCaptureButton.mas_makeConstraints { (make) in
            make?.right.equalTo()(self.view)
            make?.top.equalTo()(self.view)?.offset()(SafeStatusBarHeight + NavigationBarH)
            make?.height.mas_equalTo()(self.selectedButtonHeight)
        }
        
        seperatorView.mas_makeConstraints { (make) in
            make?.right.left().equalTo()(self.view)
            make?.height.mas_equalTo()(1)
            make?.top.mas_equalTo()(self.myCaptureButton.mas_bottom)
        }
        
        containScrollView.mas_makeConstraints { (make) in
            make?.left.right()?.bottom().equalTo()(self.view)
            make?.top.mas_equalTo()(self.seperatorView.mas_bottom)
        }
        
        adasCollectionView.mas_makeConstraints { (make) in
            make?.left.top().equalTo()(self.containScrollView)
            make?.width.mas_equalTo()(ScreenW)
            make?.height.mas_equalTo()(ScreenH-NavigationBarH-self.selectedButtonHeight-SafeStatusBarHeight)
        }
        
        myCaptureCollectionView.mas_makeConstraints { (make) in
            make?.right.top()?.bottom()?.equalTo()(self.containScrollView)
            make?.left.mas_equalTo()(self.adasCollectionView.mas_right)
            make?.width.mas_equalTo()(ScreenW)
            make?.height.mas_equalTo()(ScreenH-NavigationBarH-self.selectedButtonHeight-SafeStatusBarHeight)
        }
        
    }
    
}


extension MyAlbumViewController:UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID, for: indexPath) as! CommonAlbumImageCollectionViewHeader
            if collectionView == adasCollectionView {
                header.timeString = adasSectionModels[indexPath.section].title
            } else {
                header.timeString = myCaptureSectionModels[indexPath.section].title
            }
            return header
        default:
            print_Debug(message: "collectionView without header")
            return CommonAlbumImageCollectionViewHeader.init()
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == adasCollectionView {
            return adasSectionModels.count
            
        } else {
            return myCaptureSectionModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == adasCollectionView {
            return adasSectionModels[section].items.count
            
        } else {
            return myCaptureSectionModels[section].items.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CommonAlumCollectionViewCell
        if collectionView == adasCollectionView {
            cell.model = adasSectionModels[indexPath.section].items[indexPath.row]
            
        } else {
            cell.model = myCaptureSectionModels[indexPath.section].items[indexPath.row]
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize.init(width: ScreenW, height:44)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CommonAlumCollectionViewCell
        
        var choseModels = [CommonAlbumSectionModel]()
        
        if collectionView == adasCollectionView {
            choseModels = adasSectionModels
        } else {
            choseModels = myCaptureSectionModels
        }
        
        var model = choseModels[indexPath.section].items[indexPath.row]
        
        if rightBarButton.isSelected {
            //   选择视图模式
            model.isSelected =  !model.isSelected
            cell.model = model
            choseModels[indexPath.section].items.replaceSubrange(Range.init(NSRange.init(location: indexPath.row, length: 1))!, with: [model])
            
        }else{
            //    开始播放视频或者选择图片
            
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == containScrollView else {
            return
        }
        let index = NSInteger(scrollView.contentOffset.x/CGFloat(scrollView.frame.width))
        
        adasEmergenceButton.isSelected = index == 0
        myCaptureButton.isSelected = index == 1
    }
    
    
    
}

extension MyAlbumViewController {
    
    
    @objc func rightBarButtonIsTapped(sender:UIButton){
        
        sender.isSelected = !sender.isSelected
        
        adasSectionModels = adasSectionModels.map { (model) -> CommonAlbumSectionModel in
            var newModel = model
            newModel.isChosenStyle = sender.isSelected
            return newModel
        }
        
        myCaptureSectionModels = myCaptureSectionModels.map { (model) -> CommonAlbumSectionModel in
            var newModel = model
            newModel.isChosenStyle = sender.isSelected
            return newModel
        }
        
        adasCollectionView.reloadData()
        myCaptureCollectionView.reloadData()
        
        if sender.isSelected {
            ThirdPartyShareView.show().shareButtonTappedBlock = { (view,event) in
                switch view.viewDescribe(){
                    case ThirdPartyShareView.buttonName.QQ.rawValue:
                     print_Debug(message: "QQ ButtonIsTapped")
                    
                    case ThirdPartyShareView.buttonName.微信.rawValue:
                        print_Debug(message: "微信ButtonIsTapped")

                    case ThirdPartyShareView.buttonName.微博.rawValue:
                        print_Debug(message: "微博rButtonIsTapped")

                    case ThirdPartyShareView.buttonName.删除.rawValue:
                        print_Debug(message: "删除ttonIsTapped")
                    
                default:
                    print_Debug(message: "other BarButtonIsTapped")
                }
            }
        }else{
            ThirdPartyShareView.hide()
        }
        
    }
    
    @objc func viewIsTapped(sender:UIButton){
        
        if sender == adasEmergenceButton {
            containScrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        } else {
            containScrollView.setContentOffset(CGPoint.init(x: ScreenW, y: 0), animated: true)
        }
        adasEmergenceButton.isSelected = sender == adasEmergenceButton
        myCaptureButton.isSelected = sender == myCaptureButton
    }
}
