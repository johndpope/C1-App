//
//  AppSettingViewController.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/21.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class AppSettingViewController: BasicViewController {

    let cellReuseID = "AppSettingTableViewCellReuseID"
    
    lazy var tableView:BasicTableView = {
        let tableView = BasicTableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CommonInfoTableViewCell.self, forCellReuseIdentifier: cellReuseID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    
    lazy var userInfoArray:[CommonInfoModel] = {
        var arrary = [CommonInfoModel]()
        let infoSet = [ ("连接设备自动下载事件照片",true,nil), ("连接设备自动下载事件视频",true,nil),
                        ("语言",false,CommonImage.rightArrow), ("清理缓存",false,CommonImage.rightArrow),
                        ("固件升级",false,CommonImage.rightArrow), ("关于",false,CommonImage.rightArrow)]
        for case let (title,hasSwitch,rightImage) in infoSet {
            var userInfo = CommonInfoModel()
            userInfo.titile = title
            if hasSwitch {
                userInfo.hasRightSwitch = true
            }
            if let trrightImge = rightImage {
                userInfo.rightImageInfo = (trrightImge,nil)
            }
            
            arrary.append(userInfo)
        }
        
        return arrary
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "APP设置"
    }
    
    override func configureSubviews() -> () {
        super.configureSubviews()
        view.addSubview(tableView)
        tableView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)
        }
    }
    
}

extension AppSettingViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! CommonInfoTableViewCell
        let model = userInfoArray[indexPath.row]
        cell.model = model
        cell.switchChangeBlock = { [unowned self](switchView,event) in
            if model.titile == "连接设备自动下载事件照片" {
                if (switchView as! UISwitch).isOn {
                    
                }else{
                    
                }
            }else if model.titile == "连接设备自动下载事件视频" {
                if (switchView as! UISwitch).isOn {
                    
                }else{
                    
                }
            }
            print_Debug( message: model.titile!, prlogLevel: LogLevel.debug)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if userInfoArray[indexPath.row].titile == "关于" {
            navigationController?.pushViewController(AboutAppViewController(), animated: true)
        }
    }
    
}

