//
//  UIImage+Ex.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/8.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import Foundation
import UIKit


protocol ImageConvert {
    
    func isCovertable() -> Bool
    func convertToImage() -> UIImage?
}

extension UIImage {
    
    static func createRandomColorImage(imageSize:CGSize) -> UIImage{
        
        let randomColor = UIColor.init(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1)
        return createImageWith(color: randomColor, size:imageSize)
    }
    
    static func createImageWith(color:UIColor,size:CGSize)->UIImage {
        let r = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(r.size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(color.cgColor)
        context.fill(r)
        
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return img
    }
    
}


extension UIImage:ImageConvert {
    
    func isCovertable() -> Bool {
        return true
    }
    
    func convertToImage() -> UIImage? {
        return self
    }

}
