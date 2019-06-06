//
//  DiscoveryViewController.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/25.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class DiscoveryViewController: BasicViewController {
    
    let cellID = "VedioPlayCollectionViewCellID"
    let headerID = "VedioPlayCollectionViewheaderID"
    
    lazy var searchBar:UISearchBar = {
        let searchBar = UISearchBar.init()
        searchBar.placeholder = "大家都在搜\"惊险瞬间\""
        searchBar.delegate = self
        searchBar.returnKeyType     = .search
        searchBar.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: 44)
        searchBar.showsCancelButton = false
        searchBar.backgroundImage = UIImage.createImageWith(color: CommonColor.searchBarBG, size: CGSize.init(width: 1, height: 1))
        
        return searchBar
    }()
    
    lazy var vedioPlayCollectionView:UICollectionView = {
        
        let flowOut = UICollectionViewFlowLayout.init()
        flowOut.minimumLineSpacing = 5.0
        flowOut.minimumInteritemSpacing = 5.0
        flowOut.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 15, right: 15)
        flowOut.headerReferenceSize = CGSize.init(width: ScreenW, height: 60)
        flowOut.itemSize =  CGSize.init(width: vedioPlayerWidth, height: vedioPlayerHeight + 35)
        
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowOut)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(VedioPlayCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(VedioPlayCollectionHeader.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: headerID)
        //
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }else {
            //            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        return collectionView
    }()
    
    typealias vedioKind = (titie:String,detail:String)
    var vedioKinds = [vedioKind]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<5 {
            let kind = ("第\(i)视频","我是对第\(i)种视频的说明文字，我可能有点长……………………………………")
            vedioKinds.append(kind)
        }
    }
    
    override func configureSubviews() {
        super.configureSubviews()
        view.addSubview(searchBar)
        view.addSubview(vedioPlayCollectionView)
        
        searchBar.sizeToFit()
        searchBar.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.view)?.offset()(20)
            make?.left.right()?.equalTo()(self.view)
        }
        vedioPlayCollectionView.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.searchBar.mas_bottom)
            make?.left.right()?.bottom()?.equalTo()(self.view)
        }
    }

}


extension DiscoveryViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vedioKinds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID, for: indexPath)
        }else{
            return VedioPlayCollectionHeader()
        }
    }
    
}


extension DiscoveryViewController:UISearchBarDelegate {
    
    
    
}
