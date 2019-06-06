//
//  AccountManageViewController.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/8.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit
import AVFoundation

class UserInfoViewController: BasicViewController {
    
    let cellReuseID = "UserInfoTableViewCellReuseID"
    
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
    
    lazy var logOutButton:BasicButton = {
        
        let button = BasicButton.init(type: UIButton.ButtonType.custom)
        button.backgroundColor = CommonColor.buttonBG
        button.setTitle("退出登录", for: UIControl.State.normal)
        button.cornerRadius(defaultButtonHeight/2)
        button.addTarget(self, action: #selector(viewIsTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    lazy var userInfoArray:[CommonInfoModel] = {
        var arrary = [CommonInfoModel]()
        let infoSet = [ ("头像","","头像"), ("昵称","老司机",""), ("性别","男",""), ("地区","",""),
                        ("签名","知行合一",""), ("修改密码","",""), ("更换手机号","15629198651","")]
        for case let (title,content,imageNameStr) in infoSet {
            var userInfo = CommonInfoModel()
            userInfo.titile = 	title
            if content.count > 0{
                userInfo.content = content
            }
            
            if imageNameStr.count > 0{
                userInfo.rightContentImageInfo = (UIImage.init(named: imageNameStr)!,nil)
            }
            userInfo.rightImageInfo = (CommonImage.rightArrow,nil)
            arrary.append(userInfo)
        }
        
        return arrary
    }()
    
    var changeInfo:(info:Any?,type:UserInfoChangeViewController.type)? {
        didSet{
            guard let trChangeInfo = changeInfo else {
                return
            }
            
            switch trChangeInfo.type {
            case .nickName:
                userInfoArray[1].content = trChangeInfo.info as! String
            case .signature:
                userInfoArray[4].content = trChangeInfo.info as! String
             case .region:
                
                if let changeInfoModel = changeInfo?.info as? CommonInfoModel {
                    var newModel = userInfoArray[3]
                    newModel.content = changeInfoModel.titile
                    newModel.addtionalInfo = changeInfoModel.addtionalInfo
                   userInfoArray[3] = newModel
                }
            }
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
         NotificationCenter.default.addObserver(forName: NSNotification.Name.districtChoose.notiName, object: nil, queue: OperationQueue.main) { (noti) in
            if let dic = noti.userInfo, let infoModel = dic[Notification.notikey.infoModel.rawValue] as? CommonInfoModel {
                var model = self.userInfoArray[3]
                model.content = infoModel.titile
                model.addtionalInfo = infoModel.addtionalInfo
                self.userInfoArray[3] = model
                self.tableView.reloadData()
            }
        }
    }
    
    override func configureSubviews() -> () {
        super.configureSubviews()
        view.addSubview(tableView)
        view.addSubview(logOutButton)
        
        tableView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)
        }
        
        logOutButton.mas_makeConstraints { (make) in
            make?.bottom.equalTo()(self.view)?.offset()(-SafeBottomMargin-15)
            make?.left.equalTo()(self.view)?.offset()(defaultCellContentHorizitalMargin)
            make?.right.equalTo()(self.view)?.offset()(-defaultCellContentHorizitalMargin)
            make?.height.mas_equalTo()(defaultButtonHeight)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension UserInfoViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! CommonInfoTableViewCell
        cell.model = userInfoArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch userInfoArray[indexPath.row].titile {
        case "头像":
            let cancelActionInfo = CommonAlertController.actionInfo.init(title: "取消", style: UIAlertAction.Style.cancel, handler:nil)
            let pictureActionInfo = CommonAlertController.actionInfo.init(title: "拍照", style: UIAlertAction.Style.default, handler:{ (action)in
                self.openImagePick(with: UIImagePickerController.SourceType.camera)
            })
            let chooseFromAlbumActionInfo = CommonAlertController.actionInfo.init(title: "从手机相册选择", style: UIAlertAction.Style.default, handler:{ (action)in
                self.openImagePick(with: UIImagePickerController.SourceType.photoLibrary)
            })
            let storePictureActionInfo = CommonAlertController.actionInfo.init(title: "保存图片", style: UIAlertAction.Style.default, handler:{ (action)in
                PhotosLibraryTool.shared.saveImageToPhotoLibrary(in: self, imageInfos:[CommonImage.size30AvatarPlaceHolder], albumTitle: "MyTest")
            })
            
            CommonAlertController.presentedActionSheetStyle(in: self, animated: true, actionInfos: [cancelActionInfo,pictureActionInfo,chooseFromAlbumActionInfo,storePictureActionInfo])
            print_Debug(message: "头像")
        case "昵称":
            let regionChangeVC = UserInfoChangeViewController.init(vcType: UserInfoChangeViewController.type.nickName,originInfo:userInfoArray[indexPath.row])
            regionChangeVC.view.backgroundColor = CommonColor.systemBGGray
            regionChangeVC.targetVC = self
            let navigationVC = BasicNavigationVC.init(rootViewController: regionChangeVC)
            present(navigationVC, animated: true, completion: nil)
            print_Debug(message: "昵称")
        case "性别":
            var userInfo = userInfoArray[indexPath.row]
            
            let cancelActionInfo = CommonAlertController.actionInfo.init(title: "取消", style: UIAlertAction.Style.cancel, handler:nil)
            let maleActionInfo = CommonAlertController.actionInfo.init(title: "男", style: UIAlertAction.Style.default, handler:{ (action)in
                userInfo.content = "男"
                self.userInfoArray[indexPath.row] = userInfo
            })
            let femaleFromAlbumActionInfo = CommonAlertController.actionInfo.init(title: "女", style: UIAlertAction.Style.default, handler:{ (action)in
                userInfo.content = "女"
                self.userInfoArray[indexPath.row] = userInfo
            })
            
            CommonAlertController.presentedActionSheetStyle(in: self, animated: true, actionInfos: [cancelActionInfo,maleActionInfo,femaleFromAlbumActionInfo])
            print_Debug(message: "性别")
        case "地区":
            
            let regionChangeVC = UserInfoChangeViewController.init(vcType: UserInfoChangeViewController.type.region,originInfo:userInfoArray[indexPath.row])
            regionChangeVC.view.backgroundColor = CommonColor.systemBGGray
            regionChangeVC.targetVC = self
            let navigationVC = BasicNavigationVC.init(rootViewController: regionChangeVC)
            present(navigationVC, animated: true, completion: nil)
            
            print_Debug(message: "地区")
        case "签名":
            let regionChangeVC = UserInfoChangeViewController.init(vcType: UserInfoChangeViewController.type.signature,originInfo:userInfoArray[indexPath.row])
            regionChangeVC.view.backgroundColor = CommonColor.systemBGGray
            regionChangeVC.targetVC = self

            let navigationVC = BasicNavigationVC.init(rootViewController: regionChangeVC)
            present(navigationVC, animated: true, completion: nil)
            
            print_Debug(message: "签名")
        case "修改密码":
            print_Debug(message: "修改密码")
        case "更换手机号":
            print_Debug(message: "更换手机号")
        default:
            print_Debug(message: "nothing ")
        }
    }
    
  
    func openImagePick(with type:UIImagePickerController.SourceType) -> () {
        let pickVC =  UIImagePickerController.init()
        pickVC.delegate = self
        pickVC.sourceType = type
        
        if UIImagePickerController.isSourceTypeAvailable(type) {
            
            if case UIImagePickerController.SourceType.camera = type {

                let authorStatus = AVCaptureDevice.authorizationStatus(for:AVMediaType.video)
                
                if case AVAuthorizationStatus.denied = authorStatus {
                    let cancelActionInfo:CommonAlertController.actionInfo = CommonAlertController.actionInfo.init(title:"取消",style:UIAlertAction.Style.cancel,handler: nil)
                    let confirmActionInfo:CommonAlertController.actionInfo = CommonAlertController.actionInfo.init(title:"确认",style:UIAlertAction.Style.default,handler: { (action) in
                        BasicTool.standard.openSettingURL()
                    })
                    CommonAlertController.presentAlert(in: self, animated: true, title: "MiniEye想访问你的相机", message: "MiniEye将访问您的相机，请在iPhone的\"设置-MiniEye\"选项中，允许MiniEye访问你的相机，以用于设置个人头像", actionInfos: [cancelActionInfo,confirmActionInfo])
                }else{
                    present(pickVC, animated: true) { }
                }
            }else{
                present(pickVC, animated: true) { }
            }
        }
    }
    
}

extension UserInfoViewController:UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print_Debug( message: "image pick Controller did finish picking \(info)", prlogLevel: LogLevel.testClose)
        
        picker.dismiss(animated: true) {
            
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true) {
            
        }
        print_Debug( message: "image pick Controller did cancel", prlogLevel: LogLevel.testClose)
    }
    
}

extension UserInfoViewController {
    
    @objc func viewIsTapped(sender:NSObject) {
        print_Debug(message: "viewDebug is tapped", prlogLevel: LogLevel.testClose)
    }
    
    
    
}
