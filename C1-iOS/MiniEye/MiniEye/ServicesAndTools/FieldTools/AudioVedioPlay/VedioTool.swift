//
//  VedioTool.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/6/12.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit
import AVKit
import Photos

class VedioTool: NSObject {
    
    typealias avAssetLoadCompleteHandler = (_ avAsset:AVAsset)->()

    static let shared:VedioTool = VedioTool()
    private let loadKeys = ["playable",
                    "hasProtectedContent",
                    "availableMetadataFormats"]
    
    func composite(in controller:UIViewController?, firstVedio:AVAsset,fTimeRange:CMTimeRange,secondVedio:AVAsset,sTimeRange:CMTimeRange,complete: commonCompleteBlock?,progress: commonProgressblock? = nil) -> () {
        
        MBProgressHUD.showAdded(to: keyWindow, animated: true)
        
        loadAssetAsynchronous(with: firstVedio) { [unowned self] (avAsset1) in
            
            self.loadAssetAsynchronous(with: secondVedio, completeHandler: { (avAsset2) in
                
                self.recompositeAvasset(with:avAsset1, fTimeRange: fTimeRange,and:avAsset2,sTimeRange: sTimeRange,complete:complete,progress:progress)
            })
        }
        
    }
    
    
    func loadAssetAsynchronous(with avAsset:AVAsset,completeHandler:@escaping avAssetLoadCompleteHandler) -> () {
        
        avAsset.loadValuesAsynchronously(forKeys: loadKeys) {[unowned self] in
            var error:NSError? = nil
            
            for key in self.loadKeys {
                print("----loadValuesAsynchronously key =\(key)\n\n")
                if avAsset.statusOfValue(forKey: key, error: &error) == .failed {
                    return
                }
            }
            
            if avAsset.isPlayable == false || avAsset.hasProtectedContent {
                return
            }
            print("loadAssetAsynchronous success\n")
            completeHandler(avAsset)
        }
    }
    
    
    func recompositeAvasset(with avAsset1:AVAsset,fTimeRange:CMTimeRange,and avAsset2:AVAsset,sTimeRange:CMTimeRange,complete:commonCompleteBlock?,progress:commonProgressblock? = nil) -> (){
        
        let mutableCompostion = AVMutableComposition.init()
        let mutableVedioCompositionTrack = mutableCompostion.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid)
        let mutableAudioCompositionTrack = mutableCompostion.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        let firstAssetVedioTrack = avAsset1.tracks(withMediaType: AVMediaType.video)[0]
        let secondAssetVedioTrack = avAsset2.tracks(withMediaType: AVMediaType.video)[0]
        let firstAssetAudioTrack = avAsset1.tracks(withMediaType: AVMediaType.audio)[0]
        let secondAssetAudioTrack = avAsset2.tracks(withMediaType: AVMediaType.audio)[0]
        
        do {
            
            try mutableVedioCompositionTrack?.insertTimeRange(fTimeRange, of: firstAssetVedioTrack, at: CMTime.zero)
            try mutableVedioCompositionTrack?.insertTimeRange(sTimeRange, of: secondAssetVedioTrack, at: fTimeRange.duration)
            try mutableAudioCompositionTrack?.insertTimeRange(fTimeRange, of: firstAssetAudioTrack, at: CMTime.zero)
            try mutableAudioCompositionTrack?.insertTimeRange(sTimeRange, of: secondAssetAudioTrack, at: fTimeRange.duration)
            
        } catch  {
            print("error=\(error)")
        }
    
    
//    let firstVedioCompositionInstruction = AVMutableVideoCompositionInstruction.init()
//        firstVedioCompositionInstruction.timeRange = CMTimeRangeMake(start: CMTime.zero, duration: firstAssetVedioTrack.timeRange.duration)
//    let firstVedioLayerCompositionInstruction = AVMutableVideoCompositionLayerInstruction.init(assetTrack: firstAssetVedioTrack)
//        firstVedioLayerCompositionInstruction.setOpacityRamp(fromStartOpacity: 0.3, toEndOpacity: 1, timeRange: CMTimeRangeMake(start: CMTime.zero, duration: firstAssetVedioTrack.timeRange.duration))
//        firstVedioLayerCompositionInstruction.setTransformRamp(fromStart: CGAffineTransform.init(rotationAngle: CGFloat(90.0/360*CGFloat.pi)), toEnd: CGAffineTransform.identity, timeRange: CMTimeRangeMake(start: CMTime.zero, duration: firstAssetVedioTrack.timeRange.duration))
//    firstVedioCompositionInstruction.layerInstructions = [firstVedioLayerCompositionInstruction]
//
//    let secondVedioCompositionInstruction = AVMutableVideoCompositionInstruction.init()
//       secondVedioCompositionInstruction.timeRange = CMTimeRangeMake(start: firstAssetVedioTrack.timeRange.duration, duration: secondAssetVedioTrack.timeRange.duration + firstAssetVedioTrack.timeRange.duration)
//    let secondVedioLayerCompositionInstruction = AVMutableVideoCompositionLayerInstruction.init(assetTrack: secondAssetVedioTrack)
//    secondVedioLayerCompositionInstruction.setOpacityRamp(fromStartOpacity: 0.3, toEndOpacity: 1, timeRange: secondAssetVedioTrack.timeRange)
//    secondVedioLayerCompositionInstruction.setTransformRamp(fromStart: CGAffineTransform.init(rotationAngle: CGFloat(45/360*CGFloat.pi)), toEnd: CGAffineTransform.identity, timeRange: secondAssetVedioTrack.timeRange)
//
//    secondVedioCompositionInstruction.layerInstructions = [secondVedioLayerCompositionInstruction]
    
    
    let mutableVedioComposition = AVMutableVideoComposition.init()
//    mutableVedioComposition.instructions = [firstVedioCompositionInstruction,secondVedioCompositionInstruction]
    mutableVedioComposition.renderSize = CGSize.init(width: 480, height: 960)
    mutableVedioComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
    
    
    let dateFormatter = DateFormatter.init()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    //        let vedioName = dateFormatter.string(from: Date.init(timeIntervalSinceNow: 0) as Date)
    
    let url = URL.init(fileURLWithPath:NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]).appendingPathComponent("vedio", isDirectory: false).appendingPathExtension("mp4")
    
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
                print(" url = \(url) file exist")
            } catch {
                print("removeItem fail ,error=\(error)")
            }
        }
        
    let avAssertExporter = AVAssetExportSession.init(asset: mutableCompostion, presetName: AVAssetExportPresetMediumQuality)
    avAssertExporter?.outputURL = url
    avAssertExporter?.outputFileType = AVFileType.m4v
//    avAssertExporter?.videoComposition = mutableVedioComposition
        
        avAssertExporter?.exportAsynchronously(completionHandler: {
            [unowned self] in
            
            defer {
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: keyWindow, animated: true)
                }
            }
            
            if avAssertExporter?.status == AVAssetExportSession.Status.completed {
                print("avAssertExporter completed")
                
                let compositionAVasset = AVAsset.init(url: (avAssertExporter?.outputURL)!)
                
                
                self.loadAssetAsynchronous(with: compositionAVasset, completeHandler: { [unowned self] (avasset) in
                    
                    let playItem = AVPlayerItem.init(asset: avasset)
                    DispatchQueue.main.async {
//                        导出完成
                    }
                })
                
//                if PHPhotoLibrary.authorizationStatus() == .authorized {
//                    self.writeAssetToPhotosLibrary(at:(avAssertExporter?.outputURL)!)
//                } else {
//                    PHPhotoLibrary.requestAuthorization({ (status) in
//                        if status == .authorized {
//                            self.writeAssetToPhotosLibrary(at:(avAssertExporter?.outputURL)!)
//                        }else{
//                            print("photos requestAuthorization fail")
//                        }
//                    })
//                }
            } else  if avAssertExporter?.status == AVAssetExportSession.Status.failed {
                print("avAssertExporter failed ,error = \(String(describing: avAssertExporter?.error))")
            }
        })
        
    }
    
    func writeAssetToPhotosLibrary(at url:URL) -> () {
        
        DispatchQueue.main.async(execute: {
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL:url)
            }, completionHandler: { (success, error) in
                if success && error == nil {
                    print("assert export into Photo library success")
                }else{
                    print("assert export into Photo library fail" )
                }
            }
            )
        }
        )
    }

}
