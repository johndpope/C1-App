//
//  LocalPhotoAlbumManager.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/28.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit
import Photos

class LocalPhotosDataManager: NSObject {
    
    let AppName = Bundle.main.infoDictionary![String.init(describing: kCFBundleNameKey!)] as! String
    var adasPhotoLibraryAlbumTitle:String {
        print_Debug(object: nil, message: "adasPhotoLibraryAlbumTitle=\(AppName + "-ADAS")", prlogLevel: LogLevel.debug)
        return  AppName + "-ADAS"
    }
    var myCapturePhotoLibraryAlbumTitle:String {
        print_Debug(object: nil, message: "myCapturePhotoLibraryAlbumTitle=\(AppName + "-我的抓拍")", prlogLevel: LogLevel.debug)
        return  AppName + "-我的抓拍"
    }
    
    static let shared = LocalPhotosDataManager()
    
    
    func fetchDeviceAssets(in controller:UIViewController) -> [[CommonAlbumSectionModel]] {
     
        let adasImageAssetArr = PhotosLibraryTool.shared.fetchImageCollection(in: controller, albumTitle: "Test")
        let myCaptureImageAssetArr = PhotosLibraryTool.shared.fetchImageCollection(in: controller, albumTitle: "MyTest")
        
        let adasModels = transformAscendingImageAsset(adasImageAssetArr)
        let myCaptureModels = transformAscendingImageAsset(myCaptureImageAssetArr)
        
        return [adasModels,myCaptureModels]
    }
    
    private func transformAscendingImageAsset(_ imageAssets:[(UIImage,PHAsset)]) -> [CommonAlbumSectionModel] {
        var models = [CommonAlbumSectionModel]()
        
        guard imageAssets.count > 0 else {
            return models
        }
        
        var sectionModel = CommonAlbumSectionModel.init(title: imageAssets[0].1.creationDate?.toString(), items: [CommonAlbumItemModel](), isChosenStyle: false)
        
        for (image,asset) in imageAssets {
            let dateString = asset.creationDate?.toString()
            
            if sectionModel.title! != dateString {
//                因为sectionModel一直在添加item，所以不能在itemq添加完之前直接添加到array中，因为struct添加是值复制；
                 models.append(sectionModel)
                sectionModel = CommonAlbumSectionModel(title: dateString, items: [CommonAlbumItemModel](), isChosenStyle: false)
            }
            
            let itemModel = CommonAlbumItemModel.init(image: image, location: asset.location, creationDate: asset.creationDate, isSelected: false, isChosenStyle: false)
            
            sectionModel.items.append(itemModel)
        }
//        最后一个循环的sectionModel要等循环结束再添加
        models.append(sectionModel)
        
        return models
    }

}


extension Date {
    
    func toString() -> String {
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: self)
    }
    
}
