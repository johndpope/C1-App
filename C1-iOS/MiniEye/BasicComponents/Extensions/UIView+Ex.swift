//
//  UIView+Ex.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/8.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import Foundation
import UIKit

fileprivate var viewDescribeKey: UInt8 = 0

extension UIView {
    
    func setViewDescribe(string:String) -> () {
        objc_setAssociatedObject(self, &viewDescribeKey, string, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    func viewDescribe() -> String? {
        if let anyStr =  objc_getAssociatedObject(self, &viewDescribeKey) {
            return anyStr as! String
        } else {
            return nil
        }
    }
    
    @discardableResult
    func cornerRadius(_ radius:CGFloat) -> UIView {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func boardColor(_ color:UIColor,width:CGFloat) -> UIView {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        return self
    }
    
}
