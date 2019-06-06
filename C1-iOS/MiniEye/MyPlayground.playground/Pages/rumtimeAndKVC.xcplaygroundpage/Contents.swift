import UIKit

var str = "Hello, playground"



//——————————————————————————————————————————————————————————————————————Test Runtime usage In swift ——————————————————————————————————————————————————————————————————————————————————————————
enum Number:String {
    case first
    case second
}

class TestClass:NSObject{
    
  @objc  var name:String?
//    swift enum cannot show in objc
  @objc   var sequence:String?
  @objc var gender:String?
    
    func descrip() -> String {
        return name ?? "" + (sequence ?? "first")
    }
}



let testObj = TestClass.init()
testObj.name = "name"
testObj.sequence = "first"


func setTestObjcIntoPerference(testObject:TestClass)->() {
    var count:UInt32 = 0
    
    let properties =  class_copyIvarList(TestClass.self, &count)
    
    for i in 0..<count {
        guard  let property = properties?[Int(i)]  else{
            continue
        }
        
        let name = String.init(cString: ivar_getName(property)!)
        print("name=\(name),testObj=\(testObj.descrip())")
        
        let oc_proVal÷ue = object_getIvar(testObj, property)
        let proValue = testObj.value(forKeyPath: name)
        
//        print("proValue=\(String(describing: proValue))oc_proValue=\(String(describing: oc_proValue))")
        
        UserDefaults.standard.set(proValue, forKey: name)
    }
    
}


func getTestObjectFromPerference()->TestClass{
    
    var count:UInt32 = 0
    let getTestObj = TestClass()
    
    let properties =  class_copyIvarList(TestClass.self, &count)
    
    for i in 0..<count {
        guard  let property = properties?[Int(i)]  else{
            continue
        }
        
        let name = String.init(cString: ivar_getName(property)!)
        let perferenceValue = UserDefaults.standard.value(forKey: name)
        
        print("perferenceValue=\(String(describing: perferenceValue)),name=\(name)")
        
        object_setIvar(getTestObj, property, perferenceValue)
    }
    
    return getTestObj
}

setTestObjcIntoPerference(testObject: testObj)

let objInPerference = getTestObjectFromPerference()
print("objInPerference=\(objInPerference.descrip())")



//————————————————————————————————————————Test Runtime usage In swift ——————————————————————————————————————————————————————————————————————————————————————————————


struct TestSturct {
    
    var name:String?
    var sequence:String?
    var ID:Int
}



let testStr = TestSturct.init(name: "name", sequence: "2", ID: 3)




