//
//  LogManager.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/16.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

enum LogLevel:Int {
    case testClose
    case debug
    case release
}

class LogTool: BasicTool {
    
    static var logLevel = LogLevel.debug
   
}
