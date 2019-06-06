
//
//  HelpViewController.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/21.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class HelpViewController: BasicViewController {
    let cellReuseID = "HelpTableViewCellReuseID"
    let helpDeviceCellReuseID = "helpDeviceCellReuseID"
    
    lazy var tableView:BasicTableView = {
        let tableView = BasicTableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CommonInfoTableViewCell.self, forCellReuseIdentifier: cellReuseID)
        tableView.register(HelpDeviceTableViewCell.self, forCellReuseIdentifier: helpDeviceCellReuseID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    lazy var recordButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setTitle("售后记录", for: UIControl.State.normal)
        button.setTitleColor(CommonColor.black, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    lazy var userInfoArray:[CommonInfoModel] = {
        var arrary = [CommonInfoModel]()
        let infoSet = [ ("账号相关","",CommonImage.rightArrow)]
        for case let (title,content,rightImage) in infoSet {
            var userInfo = CommonInfoModel()
            userInfo.titile = title
            userInfo.rightImageInfo = (rightImage,nil)
            
            arrary.append(userInfo)
        }
        
        return arrary
    }()
    
    lazy var deviceInfoArray:[String] = {
        return ["防撞小助手","防撞小助手"]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "帮助"
    }
    
    override func configureSubviews() -> () {
        super.configureSubviews()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: recordButton)
        
        view.addSubview(tableView)
        tableView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)
        }
    }
    
}

extension HelpViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return deviceInfoArray.count
        } else {
            return userInfoArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: helpDeviceCellReuseID, for: indexPath) as! HelpDeviceTableViewCell
            let title = deviceInfoArray[indexPath.row]
            cell.deviceTitleLabel.text = title
            cell.leftImageView.image = CommonImage.size30AvatarPlaceHolder
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! CommonInfoTableViewCell
            let model = userInfoArray[indexPath.row]
            cell.model = model
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let containerView = BasicView.init()
            let label = BasicLabel.initWith(text: "我的设备", font: UIFont.boldSystemFont(ofSize: 20), textColor: CommonColor.black, textAlignment: NSTextAlignment.left)
            containerView.addSubview(label)
            label.sizeToFit()
            label.mas_makeConstraints { (make) in
                make?.top.bottom()?.equalTo()(containerView)
                make?.left.equalTo()(containerView)?.offset()(defaultCellContentHorizitalMargin)
            }
            return containerView
            
        }else{
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 50
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            navigationController?.pushViewController(HelpDetailViewController.init(style: HelpDetailViewController.style.device), animated: true)
        } else {
            navigationController?.pushViewController(HelpDetailViewController.init(style: HelpDetailViewController.style.account), animated: true)
            
        }
        
    }
    
    
}

extension HelpViewController {
    
    @objc  func viewIsTapped(sender:BasicButton) -> () {
        
        navigationController?.pushViewController(HelpRecordViewController(), animated: true)
        
    }
}
