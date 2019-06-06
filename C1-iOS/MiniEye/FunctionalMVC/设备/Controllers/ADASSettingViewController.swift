//
//  ADASSettingViewController.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/6/3.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class ADASSettingViewController: BasicViewController {

    
    lazy var tableView:BasicTableView = {
        let tableView = BasicTableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CommonInfoTableViewCell.self, forCellReuseIdentifier: commonInfoTableViewCellID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    
    lazy var userInfoArray:[CommonInfoModel] = {
        var arrary = [CommonInfoModel]()
        let infoSet = [ ("前车防碰",true,nil), ("行人防碰",true,nil),
                        ("车道偏离",true,nil), ("前车起停",true,nil),
                        ("画面调校",false,CommonImage.rightArrow), ("车型选择",false,CommonImage.rightArrow)]
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
extension ADASSettingViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: commonInfoTableViewCellID, for: indexPath) as! CommonInfoTableViewCell
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
