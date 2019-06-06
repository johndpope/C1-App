//
//  HelpDetailViewController.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/23.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class HelpDetailViewController: BasicViewController {
    
    enum style {
        case account
        case device
    }
    
    let cellID = "HelpDetailTableViewCellID"
    
    
    let phoneLabelHeight:CGFloat = 30
    var additionalServeViewHeight:CGFloat {
        get{
            return SafeBottomMargin + phoneLabelHeight + 15 + 50 + defaultButtonHeight + 15
        }
    }
    
    var vcStyle:style
    
    lazy var serviceButton:BasicButton = {
        var title:String = ""
        switch vcStyle {
        case .account:
            title = "账户服务"
        case .device:
            title = "售后申请"
        }
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.backgroundColor = CommonColor.buttonBG
        button.setTitle(title, for: UIControl.State.normal)
        button.cornerRadius(defaultButtonHeight/2)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    lazy var recordButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setTitle("售后记录", for: UIControl.State.normal)
        button.setTitleColor(CommonColor.black, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
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
    
    lazy var additionalServeView:BasicView = {
        let view = BasicView.init()
        view.backgroundColor = UIColor.init(white: 1, alpha: 1)
        
        return view
    }()

    lazy  var serverPhoneLabel:BasicLabel = {
        let label = BasicLabel()
        let string = "客服热线：0755-12345678"
        var attributeString = NSMutableAttributedString.init(string: string)
        //        attributeString.addAttributes([NSAttributedString.Key.foregroundColor : defaultGrayFontColor], range: <#T##NSRange#>)
        //        attributeString.addAttributes([NSAttributedString.Key.foregroundColor : defaultGrayFontColor], range:NSRange.init(string.range(of: "客服热线：")))
        label.attributedText = attributeString
        label.textAlignment = .center
        label.font = CommonFont.content
        
        return label
    }()
    
    var models = [CommonInfoModel]()
    
    convenience init(style:style) {
        self.init()
        self.vcStyle = style
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.vcStyle = .account
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...5 {
            var model = CommonInfoModel()
            model.titile = "常见问题\(i)"
            model.rightImageInfo = (CommonImage.rightArrow,nil)
            models.append(model)
        }
        
    }
    
    
    override func configureSubviews() -> () {
        super.configureSubviews()
        switch vcStyle {
        case .account:
            title = "账户相关"
            
        case .device:
            title = "防撞小助手"
            navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: recordButton)
            additionalServeView.addSubview(serverPhoneLabel)
            
            serverPhoneLabel.sizeToFit()
            serverPhoneLabel.mas_makeConstraints { (make) in
                make?.centerX.equalTo()(self.additionalServeView)
                make?.bottom.equalTo()(self.additionalServeView)?.offset()(-SafeBottomMargin-15)
            }
            
        }
        
        view.addSubview(tableView)
        view.addSubview(additionalServeView)
        additionalServeView.addSubview(serviceButton)
        
        
        tableView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)
        }
        
        additionalServeView.mas_makeConstraints { (make) in
            make?.bottom.left()?.right()?.equalTo()(self.view)
            make?.height.mas_equalTo()(self.additionalServeViewHeight)
        }
        
        serviceButton.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.additionalServeView)?.offset()(15)
            make?.left.equalTo()(self.additionalServeView)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.additionalServeView)?.offset()(-defaultCellContentHorizitalMargin)
            make?.height.mas_equalTo()(defaultButtonHeight)
        }
        
        
        
    }
    
}

extension HelpDetailViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CommonInfoTableViewCell
        cell.model = models[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let container = BasicView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenW, height: 0))
        container.backgroundColor = UIColor.white
        let searchBar = UISearchBar.init()
        searchBar.placeholder = "原密码"
        searchBar.delegate = self
        searchBar.returnKeyType     = .search
        searchBar.frame = CGRect.init(x: 0, y: UIApplication.shared.statusBarFrame.height, width: ScreenW - 40 , height: 44)
        searchBar.showsCancelButton = false
        searchBar.backgroundImage = UIImage.createImageWith(color: CommonColor.searchBarBG, size: CGSize.init(width: 1, height: 1))
        container.addSubview(searchBar)
        
        searchBar.sizeToFit()
        searchBar.mas_makeConstraints { (make) in
            make?.left.equalTo()(container)?.offset()(0)
            make?.right.equalTo()(container)?.offset()(-0)
            make?.top.equalTo()(container)?.offset()(15)
            make?.bottom.equalTo()(container)?.offset()(-15)
        }
        
        return container
    }
    
}


extension HelpDetailViewController:UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
}


extension HelpDetailViewController{
    
    @objc  func viewIsTapped(sender:BasicButton) -> () {
        if sender == serviceButton {
            navigationController?.pushViewController(HelpFeedbackViewController(), animated: true)
        } else {
            navigationController?.pushViewController(HelpRecordViewController(), animated: true)
        }
    }
}
