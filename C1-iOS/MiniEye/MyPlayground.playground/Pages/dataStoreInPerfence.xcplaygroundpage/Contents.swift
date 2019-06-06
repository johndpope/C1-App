//: [Previous](@previous)

import Foundation
import UIKit

var str = "Hello, playground"

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


@objc class UserAccountData: NSObject {
    //
    //    enum Gender:String {
    //        case male
    //        case female
    //    }
    
    @objc  var avatarImageUrl:URL?
//    @objc   var avatarImage:UIImage?
    
    @objc   var userName:String?
    @objc   var gender:String?
    @objc   var region:String?
    @objc   var signature:String?
    
    @objc   var password:String?
    @objc   var telephone:String?
   
}

private let defaults = UserDefaults.standard


func fetchObjectFromPerference(objectType:NSObject.Type) -> NSObject {
    
    let object = objectType.init()
    
    let placeMirror = Mirror.init(reflecting: object)
    
    for case (let originName,_) in placeMirror.children {
        let storeName = String.init(describing: type(of: object).self) + "." +  originName!
        let cacheValue = defaults.object(forKey: storeName)
        print("fetch from perference  originName=\(originName!),storeName=\(storeName),cacheValue=\(String(describing: cacheValue))\n")
        object.setValue(cacheValue, forKey: originName!)
    }
    
    return object
}


func set(objectIntoPerference object:NSObject) -> () {
    
    let placeMirror = Mirror.init(reflecting: object)
    
    for case  (let originName,let originValue) in placeMirror.children {
        let storeName = String.init(describing: type(of: object).self) + "." +  originName!
        print("store in perference originName=\(originName!),storeName=\(storeName),originValue=\(originValue)\n")
        
        switch originValue {
        case Optional<Any>.none:
            print("originValue=\(originValue)")
        default:
            defaults.setValue(originValue, forKey: storeName)
            print("originValue != nil.originValue=\(originValue)")

        }

        
    }
    
}


let testAccount2 = UserAccountData.init()
testAccount2.userName = "my name"
testAccount2.gender = "female"
testAccount2.avatarImage = UIImage.createImageWith(color: UIColor.red, size: CGSize.init(width: 20, height: 20))
set(objectIntoPerference: testAccount2)
fetchObjectFromPerference(objectType: UserAccountData.self)

print("testAccount2=\(testAccount2)")




//: [Next](@next)
