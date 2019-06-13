//
//  Blocks.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/8.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import Foundation
import UIKit

//点击View，target 对应的action的block
typealias viewClicked = (_ sender:UIView,_ event:UIControl.Event)->()

//通用的回调block
typealias commonCompleteBlock = (_ success:Bool,_ error:Error?,_ data:Any?)->()


//通用的progress回调block
typealias commonProgressblock = (_ progress:Float,_ error:Error?)->()
