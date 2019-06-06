//
//  HelpRecordViewController.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/23.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class HelpRecordViewController: BasicViewController {
    
    let cellID = "HelpDetailTableViewCellID"

    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CommonInfoTableViewCell.self, forCellReuseIdentifier:cellID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    var models = [CommonInfoModel]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...5 {
            var model = CommonInfoModel()
            model.titile = "2019-0\(i)-21维修"
            model.rightImageInfo = (CommonImage.rightArrow,nil)
            models.append(model)
        }
    }
    

    override func configureSubviews() -> () {
        super.configureSubviews()
        
        title = "售后记录"
        
        view.addSubview(tableView)
        
        tableView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)
        }
    }

}


extension HelpRecordViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CommonInfoTableViewCell
        cell.model = models[indexPath.row]
        
        return cell
    }
   
}
