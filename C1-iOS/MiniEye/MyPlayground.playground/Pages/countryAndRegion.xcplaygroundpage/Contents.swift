//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

let countryCodes = NSLocale.isoCountryCodes
let local = NSLocale.init(localeIdentifier: "CN")

for countryCode in countryCodes {
    let countryName  = local.displayName(forKey: NSLocale.Key.countryCode, value: countryCode)
    print("countryCode=\(countryCode),countryName=\(countryName)")
}



var currentLocal:NSLocale {
    return NSLocale.init(localeIdentifier: Locale.current.identifier)
}

var currentCountryName:String? {
    return currentLocal.displayName(forKey: NSLocale.Key.countryCode, value:currentLocal.countryCode)
}

print("currentLocal=\(currentLocal),currentCountryName=\(currentCountryName)")
