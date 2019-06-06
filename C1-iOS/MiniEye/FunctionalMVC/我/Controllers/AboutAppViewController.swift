//
//  AboutAppViewController.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/21.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class AboutAppViewController: BasicViewController {
    
    let cellReuseID = "AboutAppTableViewCellReuseID"
    
    lazy var tableView:BasicTableView = {
        let tableView = BasicTableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CommonInfoTableViewCell.self, forCellReuseIdentifier: cellReuseID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = 300
        
        return tableView
    }()
    
    
    lazy var userInfoArray:[CommonInfoModel] = {
        var arrary = [CommonInfoModel]()
        let infoSet = [("官方网站","WWWW.MINIEYE.CC",nil),
                       ("客服热线","0755-110110110",nil),
                        ("邮箱地址","HH@MINIEYE.CC",nil),
                        ("微信公众号","MINIEYE",nil),
                        ("官方微博","MINIEYE官方",nil),
                        ("使用条款和隐私政策","",CommonImage.rightArrow)]
        for case let (title,content,rightImage) in infoSet {
            var userInfo = CommonInfoModel()
            userInfo.titile = title
            if content.count > 0 {
                userInfo.content = content
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
        title = "关于"
    }
    
    override func configureSubviews() -> () {
        super.configureSubviews()
        view.addSubview(tableView)
        tableView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)
        }
    }
    
}

extension AboutAppViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! CommonInfoTableViewCell
        let model = userInfoArray[indexPath.row]
        cell.model = model
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if userInfoArray[indexPath.row].titile == "使用条款和隐私政策" {
            print_Debug(object: nil, message: "使用条款点击了", prlogLevel: LogLevel.debug)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return AboutAppHeader()
    }
    
}
