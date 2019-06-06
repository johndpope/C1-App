//: [Previous](@previous)

import Foundation
import UIKit
import PlaygroundSupport

var str = "Hello, playground"

//: [Next](@next)

let textField = UITextField.init(frame: CGRect.init(x: 0, y: 0, width: 300, height: 50))
textField.clearButtonMode = .always
textField.layer.borderColor = UIColor.red.cgColor
textField.layer.borderWidth = 0.5
textField.backgroundColor = UIColor.init(white: 1, alpha: 1)

PlaygroundPage.current.liveView = textField
