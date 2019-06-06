//
//  TextDesign.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/8.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import Foundation
import UIKit

// Color

struct CommonColor {
    
    static let black:UIColor = UIColor.init(white: 0, alpha: 1)
    static let seperatorLine:UIColor = UIColor.init(red: 32/255, green: 32/255, blue: 32/255, alpha: 1)
    static let grayText:UIColor = UIColor.init(red: 187/255, green: 187/255, blue: 187/255, alpha: 1)
    static let systemBGGray:UIColor = UIColor.init(red: 232/255, green: 232/255, blue: 232/255, alpha: 1)
    
    static let buttonBG:UIColor = UIColor.init(red: 44/255, green: 52/255, blue: 69/255, alpha: 1)
    static let searchBarBG:UIColor =  UIColor.colorWithHex(hex: 0xF6F5F5)

}



struct CommonFont {
   static let content:UIFont = UIFont.systemFont(ofSize: 16)
   static let detail:UIFont = UIFont.systemFont(ofSize: 14)
   static let title:UIFont = UIFont.boldSystemFont(ofSize: 18)
   static let bdge:UIFont = UIFont.systemFont(ofSize: 10)
    
}
// Font

//View

let keyWindow = (UIApplication.shared.delegate!.window!)!

