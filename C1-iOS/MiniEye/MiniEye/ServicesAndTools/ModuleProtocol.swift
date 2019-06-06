//
//  ModuleProtocol.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/16.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import Foundation


@objc protocol ModuleCommonProtocol {
    
    @objc optional var completeBlock:commonCompleteBlock? { get set }
    
}
