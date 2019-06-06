
//
//  CGRect+Ex.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/23.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import Foundation


extension CGRect {
    
    enum property {
        case width
        case height
        case x
        case y
    }
    
    func addPrperty(_ addProperty:property,value:CGFloat) -> CGRect {
        
        var x = origin.x
        var y = origin.y
        var newWidth = width
        var newHeight = height
        
        switch addProperty {
        case .width:
            newWidth += value
        case .height:
            newHeight += value
        case .x:
            x += value
        case .y:
            y += value
        }
        
        return CGRect.init(x: x, y: y, width: newWidth, height: newHeight)
    }
    
    func x() -> CGFloat {
        return origin.x
    }
    
    func y() -> CGFloat {
        return origin.y
    }
 
    
}
