//
//  BasicLabel.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/8.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class BasicLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = CommonFont.content
        textColor = CommonColor.black
        textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func initWith(text:String?,font:UIFont? = CommonFont.content,
                         textColor:UIColor? = CommonColor.black,
                         textAlignment:NSTextAlignment? = .center) ->BasicLabel{
        let label = BasicLabel.init()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment ?? .center
        
        return label
    }
    
    
}
