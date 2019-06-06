//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

var originString:String?  =  ""
var newString:String? 

if newString == originString {
    print(" equal ")
}else{
    print("not equal")
}

newString = "hehe"
if newString == originString {
    print(" equal ")
}else{
    print("not equal")
}


enum authorizationError:Error {
    case userRefuse
    case systemReason
    case userNotDetermin
    case otherUnkownReason
}

let testError:Error? = authorizationError.userRefuse

if  let trError  = testError as? authorizationError {
    switch trError {
    case authorizationError.userRefuse:
        print("2 test finish trError=\(trError)")
    default:
        print("1")

    }
}


enum CellStyle:Int {
    
    case hasLeftImage  =          0b000000000001
    case hasLeftTitle  =          0b000000000010
//    一般是switch也算作imag的一种
    case hasRightSwitch =         0b100000000000
    case hasRightArrow  =         0b010000000000
    case hasRightContent =        0b001000000000
    case hasRightContentImage =   0b000100000000
    
}

//
let style1 =  CellStyle.hasLeftImage.rawValue | CellStyle.hasLeftTitle.rawValue
let style2 =  (style1 & CellStyle.hasLeftTitle.rawValue) == CellStyle.hasLeftTitle.rawValue



print("style1 =\(style1)style2=\(style2)")

