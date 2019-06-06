//
//  NetworkService.swift
//  anjet charger
//
//  Created by 朱慧林 on 2018/6/29.
//  Copyright © 2018年 Anjet. All rights reserved.
//

import UIKit
import Alamofire
import os

let aesKey = "dongbinhuiasxiny"
let aesIV = "poilkjmnbyhtgvfr"
let anjetHostName = "www.anjet-tech.cn"

let API_URL = ""


enum NetworkServiceError:Error {
    case responseEmpty
    case decodeResponseStringFailure
}

typealias networkCompletion = (_ data:[String:Any]?,_ error:Error?,_ response:DataResponse<String>?)->()
typealias dataNetworkCompletion = (_ data:Data?,_ error:Error?,_ response:DataResponse<String>?)->()

class HTTPNetworkTool: BasicTool {
    
    static let shared = HTTPNetworkTool()
    
    
    let retryMax = 3
    var retryNum = 0
    
    //MARK: - Public method -
    
    func userLogin(complete:@escaping (networkCompletion))  {
        
//        let parameters = [ "bid": "UR0002", "data": ["account": GlobalData.currentUser?.mobile, "password": GlobalData.currentUser?.password]] as [String : Any]
//        connenctToServer(parameters: parameters, with: complete)
  }
    
    
    func getMyFavoriteListIOWith(Page:Int,complete:@escaping (dataNetworkCompletion)) ->(){
//        let parameters = [ "bid": "CT0003", "data": ["uid": GlobalData.currentUser?.uid as Any,"p": Page,"max_page": "10","is_cache": "N" ]] as [String : Any]
//        connenctToServer(parameters: parameters, with: complete)
    }
    
}
    


extension HTTPNetworkTool {
    //获取客户端证书相关信息
    
    private  func connenctToServer(parameters:[String:Any],with complete:@escaping (networkCompletion)) -> () {
        
        let headers = ["Content-Type":"application/x-www-form-urlencoded","accept":"application/json","User-Agent":"Anjet charger IOS Version 0.0.1"]
        
//        setupSessionManagerConfiguration()
        
//        Alamofire.request(ProjectSet.API_URL,
//                          method: .post,
//                          parameters: parameters,
//                          encoding: AJTUrlEncoding(),
//                          headers: headers)
//            .responseString { (response) in
//                if response.error != nil || response.value == nil || response.data == nil {
//                    let error = response.error
//                    print("[NetWork Service]responseString ,user login error,error=\(String(describing: error))")
//                    complete(nil,error,nil)
//                } else {
//                    let responseValue = response.value
//                    if let json = AJTResponseDecoding.decodeResponseStr(str: responseValue!) {
//                        complete(json,nil,response)
//                    }else {
//                        if responseValue!.isEmpty {
//                            complete(nil,NetworkServiceError.responseEmpty,response)
//                        }else {
//                            complete(nil,NetworkServiceError.decodeResponseStringFailure,response)
//                        }
//                    }
//                }
//                print("[NetworkService] responseString complete")
//        }
    }
    
    private  func connenctToServer(parameters:[String:Any],with dataComplete:@escaping (dataNetworkCompletion)) -> () {
        
        let headers = ["Content-Type":"application/x-www-form-urlencoded","accept":"application/json","User-Agent":"Anjet charger IOS Version 0.0.1"]
        
//        setupSessionManagerConfiguration()
        
//        Alamofire.request(ProjectSet.API_URL,
//                          method: .post,
//                          parameters: parameters,
//                          encoding: AJTUrlEncoding(),
//                          headers: headers)
//            .responseString { (response) in
//                if response.error != nil || response.value == nil || response.data == nil {
//                    let error = response.error
//                    print("[NetWork Service]responseString ,user login error,error=\(String(describing: error))")
//                    dataComplete(nil,error,nil)
//                } else {
//                    let responseValue = response.value
//                    if let json = AJTResponseDecoding.decodeResponseStringToData(str: responseValue!) {
//                        dataComplete(json,nil,response)
//                    }else {
//                        if responseValue!.isEmpty {
//                            dataComplete(nil,NetworkServiceError.responseEmpty,response)
//                        }else {
//                            dataComplete(nil,NetworkServiceError.decodeResponseStringFailure,response)
//                        }
//                    }
//                }
//                print("[NetworkService] responseString complete")
//        }
    }
    
    
//     func setupSessionManagerConfiguration() -> () {
//
//        SessionManager.default.retrier = AJTNetworkRetry()
//
//        SessionManager.default.delegate.sessionDidReceiveChallengeWithCompletion = { session,challenge,completionHandler in
//            print_Debug(object:self,message: "sessionDidReceiveChallengeWithCompletion called")
//            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
//                var err: OSStatus
//
//                guard let cerPath = Bundle.main.path(forResource: "anjet", ofType: "der"),
//                    let data = try? Data(contentsOf: URL(fileURLWithPath: cerPath)),
//                    let certificate = SecCertificateCreateWithData(nil, data as CFData),
//                    challenge.protectionSpace.host.contains(anjetHostName) else {
//                        completionHandler(Foundation.URLSession.AuthChallengeDisposition.performDefaultHandling,nil)
//                        return
//                }
//
//                let trustedCertList = [certificate]
//                var disposition: Foundation.URLSession.AuthChallengeDisposition = Foundation.URLSession.AuthChallengeDisposition.performDefaultHandling
//                var trustResult: SecTrustResultType = .invalid
//                var credential: URLCredential? = nil
//
//
//                let serverTrust: SecTrust = challenge.protectionSpace.serverTrust!
//
//                //将读取的证书设置为serverTrust的根证书
//                err = SecTrustSetAnchorCertificates(serverTrust, trustedCertList as CFArray)
//
//                if err == noErr {
//                    //通过本地导入的证书来验证服务器的证书是否可信
//                    err = SecTrustEvaluate(serverTrust, &trustResult)
//                }
//
//                if err == errSecSuccess && (trustResult == .proceed || trustResult == .unspecified) {
//                    //认证成功，则创建一个凭证返回给服务器
//                    disposition = Foundation.URLSession.AuthChallengeDisposition.useCredential
//                    credential = URLCredential(trust: serverTrust)
//                } else {
//                    disposition = Foundation.URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge
//                }
//
//                //回调凭证，传递给服务器
//                completionHandler(disposition, credential)
//                print_Debug(object:self,message: "NSURLAuthenticationMethodServerTrust disposition=%d,credential=%@", args:disposition.rawValue,credential! )
//            }  else if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodClientCertificate {//认证客户端证书
//
//                //获取客户端证书相关信息
//                let identityAndTrust:IdentityAndTrust = self.extractIdentity()
//
//                let urlCredential:URLCredential = URLCredential(
//                    identity: identityAndTrust.identityRef,
//                    certificates: identityAndTrust.certArray as? [AnyObject],
//                    persistence: URLCredential.Persistence.forSession)
//
//                completionHandler(.useCredential, urlCredential)
//                print_Debug(object:self,message: "NSURLAuthenticationMethodClientCertificate credential=%@", args:urlCredential)
//
//            } else {// 其它情况（不接受认证）
//
//                completionHandler(.cancelAuthenticationChallenge, nil);
//                print_Debug(object:self,message: "NSURLAuthenticationMethod others")
//            }
//
//        }
//    }
    
    
//    private func extractIdentity() -> IdentityAndTrust {
//        var identityAndTrust:IdentityAndTrust!
//        var securityError:OSStatus = errSecSuccess
//
//        let path: String = Bundle.main.path(forResource: "anjet", ofType: "pem")!
//        let PKCS12Data = NSData(contentsOfFile:path)!
//        let key : NSString = kSecImportExportPassphrase as NSString
//        let options : NSDictionary = [key : "88888888"] //客户端证书密码
//        //create variable for holding security information
//        //var privateKeyRef: SecKeyRef? = nil
//
//        var items : CFArray?
//
//        securityError = SecPKCS12Import(PKCS12Data, options, &items)
//
//        if securityError == errSecSuccess {
//            let certItems:CFArray = items as CFArray!;
//            let certItemsArray:Array = certItems as Array
//            let dict:AnyObject? = certItemsArray.first;
//            if let certEntry:Dictionary = dict as? Dictionary<String, AnyObject> {
//                // grab the identity
//                let identityPointer:AnyObject? = certEntry["identity"];
//                let secIdentityRef:SecIdentity = identityPointer as! SecIdentity!
//                print("\(identityPointer ?? "empty1" as AnyObject)  :::: \(secIdentityRef)")
//                // grab the trust
//                let trustPointer:AnyObject? = certEntry["trust"]
//                let trustRef:SecTrust = trustPointer as! SecTrust
//                print("\(trustPointer ?? "empty1" as AnyObject)  :::: \(trustRef)")
//                // grab the cert
//                let chainPointer:AnyObject? = certEntry["chain"]
//                identityAndTrust = IdentityAndTrust(identityRef: secIdentityRef,
//                                                    trust: trustRef, certArray:  chainPointer!)
//            }
//        }
//        return identityAndTrust;
//
//}
}
