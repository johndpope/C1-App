//
//  LocationTool.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/29.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit
import CoreLocation

typealias locationUpateComplete = (_ success:Bool,_ location:CLLocation?)->()
typealias locationTransfromComplete = (_ success:Bool,_ error:Error?,_ cityInfo:countryInfo?)->()

class LocationTool: BasicTool {
    
    enum infoError:Error {
        case cityNameEmpty
    }
    
    static let  shared:LocationTool = LocationTool()
    private lazy var locationManager:CLLocationManager  = {
        let manager = CLLocationManager.init()
        manager.delegate = self
        return manager
    }()
    private let geoCoder = CLGeocoder.init()
    
    var authorizationComplete:commonCompleteBlock?
    var updateLocationBlock:locationUpateComplete?
    
    
    func getCurrentLocation(in controller:UIViewController,complete:@escaping locationUpateComplete) -> () {
        
        requestCLAuthorization(in: controller) { (success, error, any) in
            if success {
                self.locationManager.startUpdatingLocation()
                self.updateLocationBlock = complete
            }
            
        }
    }
    
    func transformToCityName(location:CLLocation,complete:@escaping locationTransfromComplete) -> () {
        
        geoCoder.reverseGeocodeLocation(location) { (placeMarks, error) in
            if let trPlaceMarks = placeMarks, trPlaceMarks.count > 0 {
                let cityMark = trPlaceMarks[0]
                let country = cityMark.country.wrappedToString()
                let province = cityMark.administrativeArea.wrappedToString()
                let cityInfo = cityMark.locality.wrappedToString()
                
                if (country + province + cityInfo).count > 0 {
                    complete(true,nil,(country + " " + province + " " + cityInfo,cityMark.isoCountryCode!))
                }else{
                    complete(false,infoError.cityNameEmpty,nil)
                }
                print_Debug(message: "cityInfo=\(String(describing: cityInfo)),country=\(String(describing: country)),province=\(province)")
            }
        }
    }
   
    
    func requestCLAuthorization(in controller:UIViewController,complete:@escaping commonCompleteBlock) -> () {
        
        switch CLLocationManager.authorizationStatus() {
        case .denied:
            DispatchQueue.main.async {
                CommonAlertController.presentAlertConfirm(in:controller,animated:true,title:"MiniEye想访问你的地理位置",
                                                          message:"MiniEye想在使用的时候访问你的地理位置，以设置你的个人位置信息",confirmTitle:"确认",confirmHandler: {(action) in
                                                            self.openSettingURL()
                },completion: nil)
            }
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            self.authorizationComplete = complete
        case .restricted:
            complete(false,authorizationError.systemReason,nil)
        case .authorizedAlways,.authorizedWhenInUse:
            complete(true,nil,nil)
        @unknown default:
            complete(false,authorizationError.otherUnkownReason,nil)
        }
    }
}


extension LocationTool:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if let trComplete = authorizationComplete {
            switch status {
            case .authorizedAlways,.authorizedWhenInUse:
                trComplete(true,nil,nil)
            case .restricted:
                trComplete(false,authorizationError.systemReason,nil)
            case .denied:
                trComplete(false,authorizationError.notDeterminedToRefuse,nil)
            default:
                print_Debug(message: "didChangeAuthorization other status=\(status) ")
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let trUpdateComplete = updateLocationBlock {
            trUpdateComplete(true,locations.last)
            locationManager.stopUpdatingLocation()
        }
        
    }
    
}
