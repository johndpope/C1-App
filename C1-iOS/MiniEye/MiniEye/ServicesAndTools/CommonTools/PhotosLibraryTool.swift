//
//  PhotosManager.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/22.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit
import Photos

class PhotosLibraryTool: BasicTool {
    
    
    static let shared = PhotosLibraryTool()
    
    func fetchImageCollection(in controller:UIViewController?, albumTitle:String) -> [(UIImage,PHAsset)] {
       
        var collection:PHAssetCollection?
        var imageArr = [(UIImage,PHAsset)]()
        
        requestPhotosLibarayAuthorization(in: controller) { (success, error, any) in
            if success {
                
                let phAlbumFetchResult = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.albumRegular, options: nil)
                phAlbumFetchResult.enumerateObjects { (enumCollection, index, stop) in
                    if enumCollection.localizedTitle == albumTitle {
                        collection = enumCollection
                        stop.pointee = true
                    }
                }
                
                if let trCollection = collection {
                    let fetchOption = PHFetchOptions.init()
                    fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
                    
                    let assetFetchResult = PHAsset.fetchAssets(in: trCollection, options: nil)
                   
                    assetFetchResult.enumerateObjects { (asset, index, stop) in
                        
                        let requestOption = PHImageRequestOptions.init()
                        requestOption.isSynchronous  = true
                        requestOption.resizeMode = .fast
                        requestOption.deliveryMode = .fastFormat
                        
                        print_Debug(message: "asset description =\(asset.description) localIdentifier=\(asset.localIdentifier)modificationDate=\(String(describing: asset.modificationDate))")
                        
                        PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFill, options: requestOption, resultHandler: { (image, _) in
                            if let trImage = image{
                                imageArr.append((trImage,asset))
                                print_Debug(message: "image=\(String(describing: image))",prlogLevel:.debug)
                            }
                        })
                    }
                }
            }
        }
        
        return imageArr
    }
    
    
    func saveImageToPhotoLibrary(in controller:UIViewController?,  imageInfos:[ImageConvert],albumTitle:String) -> () {
        
        var assetId:String?
        var collection:PHAssetCollection?
        var collectionLocalId:String?
        
        
        func saveAsset(with imageInfos:[ImageConvert],in collection:PHAssetCollection)->() {
            
//            首先，根据UIImage创建PHAsset，此时只能拿到AssetID。
            print_Debug(message: "save to collection.localizedTitle=\(String(describing: collection.localizedTitle))")
            for imageConvert in imageInfos where imageConvert.isCovertable() {
                
                PHPhotoLibrary.shared().performChanges({
                    
                    assetId = PHAssetChangeRequest.creationRequestForAsset(from: imageConvert.convertToImage()!).placeholderForCreatedAsset?.localIdentifier
                    
                }, completionHandler: { (success, error) in
                    
                    if success {
                        //        如果Asset创建成功了，就将asset添加到AassetCollection里面。
                        PHPhotoLibrary.shared().performChanges({
                            let trcollection = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [collectionLocalId!], options: nil).lastObject
                            let assetCollectionRequest = PHAssetCollectionChangeRequest.init(for: trcollection!)
                            let asset = PHAsset.fetchAssets(withLocalIdentifiers: [assetId!], options: nil)
                            assetCollectionRequest?.addAssets(asset)
                            
                        }, completionHandler: { (success, error) in
                            ProgressHUD.hideHUDSyncOnMainThread(on: keyWindow, animated: true)

                            if success {
                                PromptHUD.showInfo(withStatus: "保存成功")
                                print_Debug(message: "save the image to album successful")
                            }else{
                                PromptHUD.showInfo(withStatus: "保存失败")
                            }
                        })
                    }else{
                        ProgressHUD.hideHUDSyncOnMainThread(on: keyWindow, animated: true)
                        PromptHUD.showInfo(withStatus: "保存失败")
                    }
                })
            }
        
        }

        requestPhotosLibarayAuthorization(in: controller) { (success, error, any) in
            if success {
                ProgressHUD.showLoadingDataHUD(on: keyWindow, animated: true)

//                首先，查看本地的相册中有没有已经创建了名字为albumTitle的相册文件夹；
                let phAlbumFetchResult = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.albumRegular, options: nil)
                
                phAlbumFetchResult.enumerateObjects { (enumCollection, index, stop) in
                    
                    if enumCollection.localizedTitle == albumTitle {
                        collection = enumCollection
                        collectionLocalId = collection?.localIdentifier
                        stop.pointee = true
                    }
                }
                
//                如果没有，就创建一个名字为albumTitle的相册
                if collection == nil {
                    
                    PHPhotoLibrary.shared().performChanges({
                        
                        collectionLocalId = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: albumTitle).placeholderForCreatedAssetCollection.localIdentifier

                    }, completionHandler: { (success, error) in
                        
                        //                如果成功了，就拿到相册，把图片保存到相册中
                        if success {
                            collection = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [collectionLocalId!], options: nil)[0]
                            saveAsset(with: imageInfos, in: collection!)

                        }else{
                            ProgressHUD.hideHUDAsyncOnMainThread(on: keyWindow, animated: true)
                            PromptHUD.showInfo(withStatus: "保存失败")                        }
                    })
                }else{
                       saveAsset(with: imageInfos, in: collection!)
                }
            }
        }

    }
    
    func requestCameraAuthorization(type:AVMediaType, complete:@escaping commonCompleteBlock) -> () {
        
        let authorStatus = AVCaptureDevice.authorizationStatus(for:type)
        
//        没有决定的时候，进入相机选取的的时候会自动提醒；
//        只有拒绝了，才需要请求权限拍照；
        switch authorStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: type) { (success) in
                if success {
                    complete(true,nil,nil)
                }else{
                    complete(false,authorizationError.notDeterminedToRefuse,nil)
                }
            }
        case .denied:
             complete(false,authorizationError.alreadyRefuse,nil)
        case .authorized:
            complete(true,nil,nil)
        case .restricted:
            complete(false,authorizationError.systemReason,nil)
        default:
            complete(false,authorizationError.otherUnkownReason,nil)
        }
    }
    
    
    
    func requestPhotosLibarayAuthorization(in controller:UIViewController?, complete:@escaping commonCompleteBlock) -> () {
       
        let authorStatus = PHPhotoLibrary.authorizationStatus()
        
        switch authorStatus {
//           用户第一次申请权限的时候，调用请求授权方法
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    complete(true,nil,nil)
                case .denied:
                    complete(false,authorizationError.notDeterminedToRefuse,nil)
                case .restricted:
                    complete(false,authorizationError.systemReason,nil)
                default:
                    complete(false,authorizationError.otherUnkownReason,nil)
                }
            }
        case .authorized:
            complete(true,nil,nil)
        case .denied:
            
//            用户第一次申请权限的时候拒绝授权之后，不会再弹出授权窗口，需要手动弹出，让用户跳转到设置页面
            complete(false,authorizationError.alreadyRefuse,nil)
            print_Debug(message: "should go to setting")
            
            if let trController = controller {
                DispatchQueue.main.async {
                    CommonAlertController.presentAlertConfirm(in:trController,animated:true,title:"MiniEye想访问你的相册",
                                                              message:"MiniEye将访问您的相册，以获取设备拍摄的照片",confirmTitle:"确认",confirmHandler: {(action) in
                    self.openSettingURL()
                },completion: nil)
                }
            }
        case .restricted:
            complete(false,authorizationError.systemReason,nil)
        default:
            complete(false,authorizationError.otherUnkownReason,nil)
        }
    }
    
 }

