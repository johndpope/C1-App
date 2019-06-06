//
//  MyViewController.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/8.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class MyViewController: BasicViewController {
    
    let cellReuseID = "MyTableViewCellReuseID"
    
    lazy var tableView:BasicTableView = {
        let tableView = BasicTableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CommonInfoTableViewCell.self, forCellReuseIdentifier: cellReuseID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 180 + 40
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    
    lazy var userInfoArray:[CommonInfoModel] = {
        var arrary = [CommonInfoModel]()
        let infoSet = [ ("消息","100",""), ("相册","",""), ("设置","",""), ("帮助","","")]
        for case let (title,content,imageUrlStr) in infoSet {
            var userInfo = CommonInfoModel()
            userInfo.titile = title
            if content.count > 0{
                userInfo.content = content
            }
            userInfo.rightImageInfo = (UIImage.init(named: "arrow_right"),nil)
            userInfo.leftImageInfo = (UIImage.init(named: title),nil)
            arrary.append(userInfo)
        }
        
        return arrary
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

    }
    
    
    override func configureSubviews() -> () {
        super.configureSubviews()
        view.addSubview(tableView)
        tableView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)
        }
    }
}

extension MyViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! CommonInfoTableViewCell
        cell.model = userInfoArray[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = MyTableViewHeader.init(frame: CGRect.init(x: 0, y: 0, width: ScreenW, height: 300))
//        header.model = UserAccountManager.shared.userAccountData
       let model = UserAccountData.init()
//        model.telephone = "10012345678"
        header.model = model

        header.viewTappedBlock = { (view,event) in
            if view.viewDescribe() == MyTableViewHeader.ViewDescribe.关注.rawValue {
                
            }else if view.viewDescribe() == MyTableViewHeader.ViewDescribe.分享.rawValue {
                
            }else if view.viewDescribe() == MyTableViewHeader.ViewDescribe.好友.rawValue {
                
            }else if view.viewDescribe() == MyTableViewHeader.ViewDescribe.用户.rawValue {
                if model.isLogin() {
                    self.navigationController?.pushViewController(UserInfoViewController(), animated: true)
                }else{
                    self.navigationController?.pushViewController(AccountUsageViewController.init(vcType: AccountUsageViewController.type.loginUsePassword), animated: true)
                }
            }
            
            print("view's describe = \(String(describing: view.viewDescribe()))")
        }
        return header
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if userInfoArray[indexPath.row].titile == "设置" {
            navigationController?.pushViewController(AppSettingViewController(), animated: true)
        }else  if userInfoArray[indexPath.row].titile == "帮助" {
            navigationController?.pushViewController(HelpViewController(), animated: true)
        }else  if userInfoArray[indexPath.row].titile == "相册" {
            PhotosLibraryTool.shared.requestPhotosLibarayAuthorization(in: self) { [unowned self](success, error, object) in
                    if success {
                          DispatchQueue.main.async {
                        self.navigationController?.pushViewController(MyAlbumViewController(), animated: true)
                    }
                }
            }
        }
    }
    
}
