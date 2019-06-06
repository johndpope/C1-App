//: [Previous](@previous)

import Foundation



let optionalArr:[Int?] = [1,nil,3,nil,4,5,6]


// 下面的方法是错误的，因为'let' pattern cannot appear nested in an already immutable context
// let模式不能出现嵌套在已经不可变的环境下；
//for let value in optionalArr  {
//    print("value = \(value)")
//}

//模式匹配可以使用；但是let 不能用,因为let是绑定一个值，
for case let value? in optionalArr  {
    print("  case let value? value = \(value)")
}

for case Optional.some(let value) in optionalArr  {
    print(" case Optional.some value = \(value)")
}

for value in optionalArr where value != nil {
    print("value = \(value!)")
}


//下面的代码仍然是错误的， 错误提示：：expected expression in 'where' guard of 'for/in'
//原因分析：（1）if 支持where里面带 let 模式匹配，但是for里面不支持；可能是if只是条件判断，只要结果是true就行了，for里面是有个输出值；
//（2）let value = cacheSomething 作为可选类型的解绑可能有其他的机制；
//for var value in optionalArr where let trvalue = value {
//    print("value = \(value)")
//}

for value in optionalArr {
    if let trValue = value {
        print("trValue = \(trValue)")
    }else{
        print("value == nil")
    }
}

let optInt:Int? = 3

switch optInt {
case 3?:
    print("3")
case Optional.some(4):
    print("4")
default:
    print("defalut")
}





var cacheSomething = UserDefaults.standard.object(forKey: "testKey")
cacheSomething = "3"

if case Optional<Any>.none = cacheSomething {
    print("case Optional.none is nil ")
}else{
    print("case Optional.none is not nil")
}

if case Optional<Any>.some( let caseValue) = cacheSomething {
    print("is not nil  case optional \(caseValue) ")
}else{
    print("is  nil")
}

if case let value? = cacheSomething {
    print("is not nil case value?\(value)")
}else{
    print("is nil case let value?")
}

if let value = cacheSomething {
    print("cacheSomething is not nil for cache \(value)")
}else{
    print("cacheSomething is  nil for cache")
}

if cacheSomething == nil {
    print("cacheSomething == nil")
}



