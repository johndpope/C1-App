//
//  CommonInfoModel.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/21.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import Foundation
import CoreLocation

struct CommonAlbumSectionModel {
    var title:String?
    var items = [CommonAlbumItemModel]()
    var isChosenStyle:Bool = false {
        didSet{
            items =  items.map { (itemModel) -> CommonAlbumItemModel in
                var newItemModel = itemModel
                newItemModel.isChosenStyle = isChosenStyle
                if isChosenStyle == false {
                    newItemModel.isSelected = false
                }
                return newItemModel
            }
        }
    }
}

struct CommonAlbumItemModel {
    
    var image:UIImage?
    var location:CLLocation?
    var creationDate:Date?

    var isSelected:Bool = false
    var isChosenStyle:Bool = false
    
}

struct CommonInfoModel {
    
    
    typealias imageInfo = (image:UIImage?,urlString:String?)
    
    static func setImageFor(imageView:UIImageView,with imageInfo:CommonInfoModel.imageInfo){
        if let image = imageInfo.image {
            imageView.image = image
        }else if let urlStr = imageInfo.urlString{
            imageView.sd_setImage(with: URL.init(string: urlStr), placeholderImage: CommonImage.size30AvatarPlaceHolder)
        }
    }
    //    左侧视图
    var leftImageInfo:imageInfo?
    
    var titile:String?
    
    //    右侧视图
    var content:String?
    var rightImageInfo:imageInfo?
    var hasRightSwitch:Bool = false
    var rightContentImageInfo:imageInfo?
    
    var addtionalInfo:Any?
    
}

extension CommonInfoModel {
    
    struct additionalKey {
        let countryCode = "countryCode"
    }
    
}
