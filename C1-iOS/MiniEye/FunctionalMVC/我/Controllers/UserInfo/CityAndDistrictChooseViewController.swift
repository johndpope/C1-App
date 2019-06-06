//
//  CityAndDistrictChooseViewController.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/30.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class CityAndDistrictChooseViewController: BasicViewController {
    
    enum type {
        case city
        case district
    }
   
    
    var vcType:type
    var names:[String]
    var models = [CommonInfoModel]()
//    var topArea:String
    
    var selectedIndexPath:IndexPath? {
        didSet{
            
            guard let trSelectedIndexPath = selectedIndexPath,trSelectedIndexPath != oldValue else {
                return
            }
            var newModel = models[trSelectedIndexPath.row]
            newModel.rightImageInfo = (CommonImage.choosen,nil)
            models[trSelectedIndexPath.row] = newModel
            
            if let trOldIndexPath = oldValue {
                var oldModel = models[trOldIndexPath.row]
                oldModel.rightImageInfo = nil
                models[trOldIndexPath.row] = oldModel
            }
            
            tableView.reloadData()
            
        }
    }

    var chooseModel:CommonInfoModel
    
    lazy var confirmButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setTitleColor(CommonColor.buttonBG, for: UIControl.State.normal)
        button.setTitleColor(CommonColor.grayText, for: UIControl.State.disabled)
        button.setTitle("确认", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CommonInfoTableViewCell.self, forCellReuseIdentifier: commonInfoTableViewCellID)
        tableView.sectionHeaderHeight = 0.1
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    init(vcType:type,names:[String],chooseModel:CommonInfoModel) {
        self.vcType = vcType
        self.names = names
//        self.topArea = topArea
        self.chooseModel = chooseModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
    }
    
    override func configureSubviews() {
        super.configureSubviews()
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: confirmButton)
        confirmButton.isEnabled = false
        
        switch vcType {
        case .city:
            title = "请选择城市"
        case .district:
            title = "请选择城区"
        }
        view.addSubview(tableView)
        tableView.mas_makeConstraints { (make) in
            make?.left.right()?.bottom().equalTo()(self.view)
            make?.top.equalTo()(self.view)?.offset()(SafeStatusBarHeight + NavigationBarH)
        }
        
    }
    
    func configureModels() -> () {
        
        for name in names {
            var model = CommonInfoModel()
            model.titile = name
            if case type.city = vcType {
                model.rightImageInfo = (CommonImage.rightArrow,nil)
            }
            models.append(model)
        }
    }

}

extension CityAndDistrictChooseViewController {
    
    @objc func viewIsTapped(sender:NSObject) {
        
//        let finalDistrict = topArea + models[selectedIndexPath!.row].titile!
        chooseModel.titile = chooseModel.titile! + " " + models[selectedIndexPath!.row].titile!
        
        NotificationCenter.default.post(name:NSNotification.Name.districtChoose.notiName, object: self, userInfo: [Notification.notikey.infoModel.rawValue:chooseModel])
        
        dismiss(animated: true, completion: {})
        print_Debug(message: "viewDebug is tapped", prlogLevel: LogLevel.testClose)
    }
    
}



extension CityAndDistrictChooseViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: commonInfoTableViewCellID, for: indexPath) as! CommonInfoTableViewCell
        cell.model = models[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if case type.city = vcType {
            
            let cityName = models[indexPath.row].titile!
            
            let districtNames = LocalizedTool.shared.chinaDistrictName(for: cityName)
            chooseModel.titile = chooseModel.titile! + " " + cityName
            
            navigationController?.pushViewController(CityAndDistrictChooseViewController.init(vcType: CityAndDistrictChooseViewController.type.district, names: districtNames, chooseModel: chooseModel), animated: true)
        }else {
            
            selectedIndexPath = indexPath
            confirmButton.isEnabled = true
        }
    }
    
    
}

extension Notification.Name {
    
    struct districtChoose {
       static  let notiName:Notification.Name = Notification.Name.init("districtChoose.cc.miniEye")
    }
    
}

extension Notification {
    
    enum notikey:String {
        case districtChoose
        case infoModel
    }
}
