//
//  UserInfoChangeViewController.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/28.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class UserInfoChangeViewController: BasicViewController {
    
    enum type {
        case nickName
        case region
        case signature
    }
    
    let bgColor:UIColor = UIColor.init(white: 0.90, alpha: 0.8)
    let horizitalMargin:CGFloat = 15
    let signatrueCountLimit:Int = 30
    let nickNameCountLimit:Int = 20
    let cellReuseID = "UserInfoChangeTableViewCellID"
    let placeHolderTitle = "定位中..."
    let locationPrefixTitle = "定位地区："
    
    
    var vcType:type
    
    var originInfo:CommonInfoModel?
    var currentInfo:String?
    weak var targetVC:UserInfoViewController?
    
    lazy var infoTextField:BasicTextField = {
        let textF = BasicTextField.init()
        textF.font = UIFont.systemFont(ofSize: 16)
        textF.backgroundColor = UIColor.white
      
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textF, queue: OperationQueue.main) { [unowned self](noti) in
            let text = (noti.object as! UITextField).text
            self.confirmButton.isEnabled  = text != self.originInfo?.content
        }
        
        return textF
    }()
    
    lazy var infoTextView:BasicTextView = {
        let textV = BasicTextView.init()
        textV.backgroundColor = UIColor.white
        textV.font = CommonFont.content
        textV.delegate = self
        
        return textV
    }()
    
    lazy var promptTextLabel:BasicLabel = {
        let label = BasicLabel.initWith(text: "26")
        label.textAlignment = .right
        label.font = CommonFont.detail
        label.textColor = CommonColor.grayText
        
        return label
    }()
    
    lazy var bgView:BasicView = {
        
        let view = BasicView.init()
        view.backgroundColor = UIColor.white
        
        return view
    }()
    
    lazy var cancelButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setTitleColor(CommonColor.grayText, for: UIControl.State.normal)
        button.setTitle("取消", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    lazy var confirmButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.setTitleColor(CommonColor.buttonBG, for: UIControl.State.normal)
        button.setTitleColor(CommonColor.grayText, for: UIControl.State.disabled)
        button.setTitle("确认", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CommonInfoTableViewCell.self, forCellReuseIdentifier: commonInfoTableViewCellID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 0.01
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    var currentLocatedCityModel:CommonInfoModel?
    var countryNameModels = [CommonInfoModel]()
    var selectedIndexPath:IndexPath? {
        didSet{

            func setModel(_ model:CommonInfoModel, in indexPath:IndexPath) -> () {
                if indexPath.section == 0 {
                    currentLocatedCityModel = model
                } else {
                    countryNameModels[indexPath.row] = model
                }
            }
            
            guard let trSelectedIndexPath = selectedIndexPath else {
                return
            }
            
            confirmButton.isEnabled = true
            var newModel = getModel(in:trSelectedIndexPath)
            
            if LocalizedTool.shared.isChina(newModel.addtionalInfo as! String),trSelectedIndexPath != IndexPath.init(row: 0, section: 0) {
                //               如果选择的是中国，就跳转到城市、地区选择的详情界面；
                let cityChosenVC = CityAndDistrictChooseViewController.init(vcType: CityAndDistrictChooseViewController.type.city, names: LocalizedTool.shared.chinaCityNames(),chooseModel:newModel)
                navigationController?.pushViewController(cityChosenVC, animated: true)
                print_Debug(message: "china row is tapped!")
                
                return
            }
            
            if trSelectedIndexPath == oldValue {
                return
            }
            
//                否则，改变选中的indexPath的模型；
                if newModel.titile != placeHolderTitle {
                    newModel.rightImageInfo = (CommonImage.choosen,nil)
                    setModel(newModel, in: trSelectedIndexPath)
                }
            
            if let trOldIndexPath = oldValue {
//                改变旧的选中indexPath的模型；
                var oldModel = getModel(in: trOldIndexPath)
                
                if LocalizedTool.shared.isChina(oldModel.addtionalInfo as! String), trOldIndexPath != IndexPath.init(row: 0, section: 0){
                   
                }else{
                     oldModel.rightImageInfo = nil
                }
                
                setModel(oldModel, in: trOldIndexPath)
            }
            
            tableView.reloadData()
            
        }
    }
    
    func getModel(in indexPath:IndexPath) -> CommonInfoModel {
        if indexPath.section == 0 {
            return currentLocatedCityModel!
        } else {
            return countryNameModels[indexPath.row]
        }
    }
    
    
    

    init(vcType:type,originInfo:CommonInfoModel?) {
        self.vcType = vcType
        self.originInfo = originInfo
        super.init(nibName: nil, bundle: nil)
        if case type.region = vcType {
            self.setLocationData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

   override func configureSubviews() {
        super.configureSubviews()
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: cancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: confirmButton)
    
    
        switch vcType {
        case .nickName:
            title = "设置昵称"
            confirmButton.isEnabled = false
            
            view.addSubview(bgView)
            bgView.addSubview(infoTextField)
            infoTextField.delegate = self
            infoTextField.clearButtonMode = .always
            infoTextField.text = originInfo?.content
            infoTextField.becomeFirstResponder()
            
            bgView.mas_makeConstraints { (make) in
                make?.left.right()?.equalTo()(self.view)
                make?.top.equalTo()(self.view)?.offset()(SafeStatusBarHeight + NavigationBarH)
                make?.height.mas_equalTo()(defaultButtonHeight)
            }
            infoTextField.mas_makeConstraints { (make) in
                make?.left.equalTo()(self.bgView)?.offset()(self.horizitalMargin)
                make?.right.equalTo()(self.bgView)?.offset()(-self.horizitalMargin)
                make?.top.bottom()?.equalTo()(self.bgView)
            }
            print("nick Name type vC")
            
        case .signature:
            title = "设置个性签名"
            
            view.addSubview(bgView)
            bgView.addSubview(infoTextView)
            infoTextView.delegate = self
            infoTextView.text = originInfo?.content
            infoTextView.becomeFirstResponder()
            view.addSubview(promptTextLabel)
            
            if let trOriginInfo = originInfo {
                promptTextLabel.text = "\(signatrueCountLimit - trOriginInfo.content!.count)"
            }else{
                promptTextLabel.text = "\(signatrueCountLimit)"
            }
            
            bgView.mas_makeConstraints { (make) in
                make?.left.right()?.equalTo()(self.view)
                make?.top.equalTo()(self.view)?.offset()(SafeStatusBarHeight + NavigationBarH)
                make?.height.mas_equalTo()(defaultButtonHeight + 30)
            }
            infoTextView.mas_makeConstraints { (make) in
                make?.left.equalTo()(self.bgView)?.offset()(self.horizitalMargin)
                make?.right.equalTo()(self.bgView)?.offset()(-self.horizitalMargin)
                make?.top.bottom()?.equalTo()(self.bgView)
            }
            
            promptTextLabel.sizeToFit()
            promptTextLabel.mas_makeConstraints { (make) in
                make?.bottom.equalTo()(self.infoTextView)?.offset()(-15)
                make?.right.equalTo()(self.infoTextView)
            }
            print("signature type vC")
        case .region:
            view.addSubview(tableView)
            tableView.mas_makeConstraints { (make) in
                make?.left.right()?.bottom().equalTo()(self.view)
                make?.top.equalTo()(self.view)?.offset()(NavigationBarH + SafeStatusBarHeight)
            }
            
            print("region type vC")
        }
    }
    
    func setLocationData() -> () {
        
        var placeModel = CommonInfoModel.init()
        placeModel.titile = placeHolderTitle
        currentLocatedCityModel = placeModel
        
        LocationTool.shared.getCurrentLocation(in: self) { (success, location) in
            if success,let trLocation = location {
                LocationTool.shared.transformToCityName(location:trLocation,complete:{ (success,error,cityInfo) in
                    if success ,let trCityInfo = cityInfo {
                        var model = CommonInfoModel.init()
                        model.titile = self.locationPrefixTitle + trCityInfo.countryName
                        model.addtionalInfo = trCityInfo.countryCode
                        self.currentLocatedCityModel = model
                        self.tableView.reloadData()
                    }
                })
            }
        }
        
        var selectedCountryCode:String = ""
        
//        如果本身已经选中了国家或者地区，就将选中的作为第一个国家
        if let trCurrentCountryName = originInfo?.content?.components(separatedBy: " ")[0] {
            var model = CommonInfoModel.init()
            model.titile = trCurrentCountryName
            
            if LocalizedTool.shared.isChina(originInfo?.addtionalInfo as! String) {
                model.rightImageInfo = (CommonImage.rightArrow,nil)
                model.content = "已选国家"
            }else{
                model.rightImageInfo = (CommonImage.choosen,nil)
            }
            
            model.addtionalInfo = originInfo?.addtionalInfo
            selectedCountryCode = originInfo?.addtionalInfo as! String
           
            countryNameModels.append(model)

            selectedIndexPath = IndexPath.init(row: 0, section: 1)
            confirmButton.isEnabled = true
        }
        
//        获取所有国家的信息，转化为models
        for countryInfo in LocalizedTool.shared.getAllCountryInfos() {
            
            if selectedCountryCode == countryInfo.countryCode {
                continue
            }
            
            var model = CommonInfoModel.init()
            model.titile = countryInfo.countryName
            if LocalizedTool.shared.isChina(countryInfo.countryCode){
                model.rightImageInfo = (CommonImage.rightArrow,nil)
            }
            model.addtionalInfo = countryInfo.countryCode
            countryNameModels.append(model)
        }
    }
  
}

extension UserInfoChangeViewController {
    
    @objc func viewIsTapped(sender:NSObject) {
        if sender == cancelButton {
            dismiss(animated: true, completion: nil)
        }else{
            var info:Any?
            
            switch vcType {
            case .nickName:
                
                var noContent = false
                
                info = infoTextField.text
                
                if let trInfo = info as? String , trInfo.hasNoContent() {
                    noContent = true
                }else if info == nil {
                    noContent = true
                }
                
                if noContent {
                    let cancelActionInfo = CommonAlertController.actionInfo.init(title: "我知道了", style: UIAlertAction.Style.cancel, handler: nil)
                    CommonAlertController.presentAlert(in: self, animated: true, title: nil, message: "昵称不能为空", actionInfos: [cancelActionInfo])
                    
                    return
                }
             
            case .signature:
                info = infoTextView.text
            case .region:
                if let trSelectIndexPath = selectedIndexPath {
                    var model = getModel(in: trSelectIndexPath)
                    
                    if trSelectIndexPath == IndexPath.init(row: 0, section: 0) {
                        model.titile = model.titile?.replacingOccurrences(of: locationPrefixTitle, with: "")
                    }
                    
                    info = model
                }
                print("hehe")
            }

	            targetVC?.changeInfo = (info,vcType)
            dismiss(animated: true, completion: {})
        }
        print_Debug(message: "viewDebug is tapped", prlogLevel: LogLevel.testClose)
    }
    
}


extension UserInfoChangeViewController:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let trCurrentString = textField.text {
            
            var newString = trCurrentString.replacingCharacters(in:trCurrentString.toRange(range)!, with: string)
            
            print("newString=\(newString)")
            if newString.count > nickNameCountLimit {
                
                let removeStartIndex = newString.indexMoveAfter(nickNameCountLimit)
                newString = newString.replacingCharacters(in: removeStartIndex!..<newString.endIndex, with: "")
                
                print("after remove, newString=\(newString)")
                textField.text = newString
                return false
            }
        }
        
        return true
    }
}

extension UserInfoChangeViewController:UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
   
        if let trCurrentString = textView.text {
            
            var newString = trCurrentString.replacingCharacters(in:trCurrentString.toRange(range)!, with: text)
            
            print("newString=\(newString)")
            if newString.count > signatrueCountLimit {
                
                let removeStartIndex = newString.indexMoveAfter(signatrueCountLimit)
                newString = newString.replacingCharacters(in: removeStartIndex!..<newString.endIndex, with: "")
                
                print("after remove, newString=\(newString)")
                textView.text = newString
                
                return false
            }
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if let text = textView.text {
            promptTextLabel.text = "\(signatrueCountLimit - text.count)"
        }else{
            promptTextLabel.text = "\(signatrueCountLimit)"
        }
    }
    
    
}

extension UserInfoChangeViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return countryNameModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: commonInfoTableViewCellID, for: indexPath) as! CommonInfoTableViewCell
        if indexPath.section == 0  {
            if let trModel = currentLocatedCityModel {
                cell.model = trModel
            }
        } else {
            cell.model = countryNameModels[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let bgView = BasicView.init()
        bgView.backgroundColor = CommonColor.systemBGGray
        let label = BasicLabel.init()
        label.textAlignment = .left
        label.font = CommonFont.detail
        label.textColor = CommonColor.grayText
        if section == 0 {
            label.text = "定位到的位置"
        } else {
            label.text = "全部"
        }
        bgView.addSubview(label)
        
        label.sizeToFit()
        label.mas_makeConstraints { (make) in
            make?.top.bottom()?.equalTo()(bgView)
            make?.left.equalTo()(bgView)?.offset()(defaultCellContentHorizitalMargin)
        }
        
        
        return bgView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0,currentLocatedCityModel!.titile!.contains(placeHolderTitle) {
            return
        }else{
            selectedIndexPath = indexPath
        }
    }
    
}
