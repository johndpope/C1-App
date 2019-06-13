//
//  ZFPlayerController+MiniEye.swift
//  iOSSyntaxAndPrinciple
//
//  Created by 朱慧林 on 2019/6/6.
//  Copyright © 2019 朱慧林. All rights reserved.
//

import Foundation


func exchangeImp(Of originSelector:Selector,newSelector:Selector,cls:AnyClass,token:String) -> () {
    
    DispatchQueue.once(token: token) {
        
        let originMethod = class_getInstanceMethod(cls, originSelector)
        let replaceMethod = class_getInstanceMethod(cls, newSelector)
        
        if let originMethod = originMethod, let replaceMethod = replaceMethod {
            let originImp = method_getImplementation(originMethod)
            let replaceImp = method_getImplementation(replaceMethod)
            
            let didAddReplaceIMp = class_addMethod(cls, originSelector, replaceImp, method_getTypeEncoding(replaceMethod))
            
            if didAddReplaceIMp {
                class_replaceMethod(cls,newSelector, originImp, method_getTypeEncoding(originMethod))
            }else {
                method_exchangeImplementations(originMethod, replaceMethod)
            }
        }
    }
    
}

extension ZFPlayerController {
    
    static var assetDurationkey:String = "assetDurationkey.MiniEye"
    static var titlekey:String = "titlekey.MiniEye"

    var assetDurations:[TimeInterval] {
        set {
            objc_setAssociatedObject(self, &ZFPlayerController.assetDurationkey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
            print("set assetDurations =\(newValue)")
        }
        
        get{
            if let assetDurations = objc_getAssociatedObject(self,  &ZFPlayerController.assetDurationkey) as? [TimeInterval]{
                print("get assetDurations =\(assetDurations)")
                return assetDurations
            }
            return [TimeInterval]()
        }
    }
    
    var titles:[String] {
        set {
            objc_setAssociatedObject(self,  &ZFPlayerController.titlekey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
            print("set titles =\(newValue)")
        }
        get{
            if let titles = objc_getAssociatedObject(self,  &ZFPlayerController.titlekey) as? [String]{
                print("get titles=\(titles)")
                return titles
            }
            return [String]()
        }
    }
    
    var trCurrentPlayerManager:ZFIJKPlayerManager  {
        return (currentPlayerManager as! ZFIJKPlayerManager)
    }
    
    
    func setupRTSPContinuePlay(titles:[String],assetDurationArrays:[TimeInterval],urls:[URL]) -> () {
        
        trCurrentPlayerManager.isRealTimePlayForRTSP = false
        
        assetURLs = urls
        
        playerDidToEnd  = {  [unowned self] (asset) in
            if !self.isLastAssetURL {
                self.trCurrentPlayerManager.replay()
                self.playTheNext()
                print("currentPlayerManager.assetURL=\(String.init(describing: self.currentPlayerManager.assetURL) )")
                (self.controlView as! ZFPlayerControlView).showTitle(titles[self.currentPlayIndex], cover: UIImage.createRandomColorImage(imageSize: self.containerView.bounds.size), fullScreenMode: ZFFullScreenMode.landscape)
            }else{
                self.stop()
            }
        }
        
        self.assetDurations = assetDurationArrays
        self.titles = titles
//        报错，因为Cannot assign to property: 'self' is immutable，playerPlayTimeChanged是一个协议属性，是OC
        
         trCurrentPlayerManager.playerPlayTimeChanged =  { [unowned self] (asset,currentTime,duration) in
            
            let collectionDuration = assetDurationArrays.reduce(0, +)
            let collectionCurrentTime = assetDurationArrays[0..<self.currentPlayIndex].reduce(0, +) + currentTime
            
            self.trCurrentPlayerManager.setValue(collectionCurrentTime, forKey: "currentTime")
            self.trCurrentPlayerManager.setValue(collectionDuration, forKey: "totalTime")
            
            if let trTimeChanged = self.playerPlayTimeChanged {
                trTimeChanged (asset,collectionCurrentTime,collectionDuration)
            }
            
            if self.controlView.responds(to: #selector(ZFPlayerMediaControl.videoPlayer(_:currentTime:totalTime:))) {
                self.controlView.videoPlayer?(self, currentTime: collectionCurrentTime, totalTime: collectionDuration)
            }
        }
        
        
        exchangeImp(Of: #selector(seek(toTime:completionHandler:)), newSelector: #selector(mineye_SeekToTime(time:completion:)), cls: ZFPlayerController.self, token: "MiniEye_ZFPlayerController" +  String.init(describing: #selector(seek(toTime:completionHandler:))))
        exchangeImp(Of: #selector(ZFPlayerControlView.videoPlayer(_:prepareToPlay:)), newSelector: #selector(ZFPlayerControlView.minieye_VideoPlayer(_:prepareToPlay:)), cls: ZFPlayerControlView.self, token: "MiniEye_ZFPlayerControlView" + String.init(describing: #selector(ZFPlayerControlView.videoPlayer(_:prepareToPlay:))))
        
    }
    
    func isRealTimePlayFor(rtspRealTime:Bool) -> () {
        (currentPlayerManager as! ZFIJKPlayerManager).isRealTimePlayForRTSP = rtspRealTime
    }
    
    func setRealTimePlayUrl(_ url:URL) -> () {
//        顺序有影响，因options是懒加载；
        isRealTimePlayFor(rtspRealTime:true)
        assetURL = url

    }
    
    @objc func mineye_SeekToTime(time:TimeInterval,completion:@escaping (_ finish:Bool)->()) -> () {

        var newPlyerTime:TimeInterval = time
        var newIndex = currentPlayIndex
        
        print("before transform,mineye_SeekToTime =\(time)currentIndex=\(newIndex)assetDurations=\(assetDurations)")
        if assetDurations.count > 1 {
            var totalDuration:TimeInterval = 0
            
            for i in 0..<assetDurations.count {
                let assetDuration = assetDurations[i]
                totalDuration += assetDuration
                if totalDuration >= time {
                    newIndex = i
                    break
                }
            }
            
            newPlyerTime -= assetDurations[0..<newIndex].reduce(0, +)
        }
        
        print(" after transform,mineye_SeekToTime =\(newPlyerTime)newIndex=\(newIndex)")
        if newIndex != currentPlayIndex {
            trCurrentPlayerManager.pause()
            playTheIndex(newIndex)
//             (self.controlView as! ZFPlayerControlView).showTitle(titles[self.currentPlayIndex], cover: UIImage.createRandomColorImage(imageSize: self.containerView.bounds.size), fullScreenMode: ZFFullScreenMode.landscape)
            print("currentPlayerManager.assetURL=\(String.init(describing: self.currentPlayerManager.assetURL) )")
            
            trCurrentPlayerManager.playerReadyToPlay = { (asset,url) in
                if let trPlayerReadyToPlay = self.playerReadyToPlay {
                    trPlayerReadyToPlay(asset,url)
                }
                if self.customAudioSession == false {
                   try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: AVAudioSession.CategoryOptions.allowBluetooth)
                   try? AVAudioSession.sharedInstance().setActive(true, options: AVAudioSession.SetActiveOptions.notifyOthersOnDeactivation)
                }
                self.mineye_SeekToTime(time: newPlyerTime, completion: completion)
            }
            
        }else{
            mineye_SeekToTime(time: newPlyerTime, completion: completion)
        }
    }
    
    
    
}


extension ZFPlayerControlView {
    
  @objc  func minieye_VideoPlayer(_ player:ZFPlayerController,prepareToPlay assetUrl:URL) -> () {
        
    }
    
}



