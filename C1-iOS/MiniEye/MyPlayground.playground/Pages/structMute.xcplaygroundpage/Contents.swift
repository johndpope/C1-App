//: [Previous](@previous)

import Foundation
import UIKit

var str = "Hello, playground"

//: [Next](@next)
struct CommonAlbumSectionModel {
    var title:String?
    var items = [CommonAlbumItemModel]()
    var isChosenStyle:Bool = false {
        didSet {
            
        }
    }
}

struct CommonAlbumItemModel {
    
    var image:String??
    var isSelected:Bool = false
    var isChosenStyle:Bool = false
    
    mutating func changeChoosenStyle(to style:Bool) -> () {
       isChosenStyle = style
    }
}

//---------// 给数组添加模型的方法///——————————————————

//cannot use mutating member on immutable value: 'sectionModel' is a 'let' constant;即使model的属性array是var类型的，let的modelz的array变量也不能够添加变量；
var sectionModel = CommonAlbumSectionModel.init(title: "1", items: [CommonAlbumItemModel](), isChosenStyle: false)

for i in 0...3 {
    var model  = CommonAlbumItemModel.init()
    model.image = "\(i)"
    sectionModel.items.append(model)
}

print("sectionModel.items=\(sectionModel.items)")


//---------// 改变数组中的model的值的方法///——————————————————

var models = [CommonAlbumItemModel]()

for i in 0...3 {
    var model  = CommonAlbumItemModel.init()
    model.image = "\(i)"
    models.append(model)
}

//var model = models[1]
////model.isChosenStyle = true
////model.isSelected = true
//model.changeChoosenStyle(to:true)


//struct是值类型的，从数组中取出struct的时候，是重新复制了一个struct；所以，改变取出的这个struct的值，不会改变数组中的属性；、
//要想改变，只能置换元素
//models.replaceSubrange(Range.init(NSRange.init(location: 1, length: 1))!, with: [model])

models = models.map { (model) -> CommonAlbumItemModel in
    var newModel = model
    newModel.isSelected = true
    return newModel
}

print(" model1=\(models[1])")


