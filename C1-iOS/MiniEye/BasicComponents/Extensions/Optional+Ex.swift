//
//  Optional+Ex.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/29.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    
    func wrappedToString() -> String {
        if let trValue = self {
            return trValue
        }else{
            return ""
        }
    }
}

