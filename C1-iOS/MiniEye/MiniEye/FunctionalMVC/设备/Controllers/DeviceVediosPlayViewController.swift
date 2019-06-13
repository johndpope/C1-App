//
//  ZFIJKPlayerViewController.swift
//  iOSSyntaxAndPrinciple
//
//  Created by 朱慧林 on 2019/6/5.
//  Copyright © 2019 朱慧林. All rights reserved.
//

import UIKit

class DeviceVediosPlayViewController: BasicViewController {
    
    lazy var mediaContainerView: BasicImageView = {
        let imageV = BasicImageView()
        imageV.image = UIImage.createImageWith(color: UIColor.init(white: 0, alpha: 0.7), size: CGSize.init(width: 1, height: 1))
        imageV.contentMode = .scaleAspectFit
        imageV.isUserInteractionEnabled = true
        return imageV
    }()
    
    lazy var initPlayButton:BasicButton = {
       let button = BasicButton.init(type: .custom)
        button.setTitle("startPlay", for: UIControl.State.normal)
        button.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(playPlayer(_:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var realTimePlayContainer: BasicImageView = {
        let imageV = BasicImageView()
        imageV.image = UIImage.createImageWith(color: UIColor.init(white: 0, alpha: 0.7), size: CGSize.init(width: 1, height: 1))
        imageV.contentMode = .scaleAspectFit
        imageV.isUserInteractionEnabled = true
        return imageV
    }()
    
    
    lazy var nextButton: BasicButton = {
        let button = BasicButton.init(type: .custom)
        button.setTitle("startPlay", for: UIControl.State.normal)
        button.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(playPlayer(_:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var mediaControlView:ZFPlayerControlView = {
       let view = ZFPlayerControlView()
        view.fastViewAnimated = true
        view.autoHiddenTimeInterval = 10
        view.autoFadeTimeInterval = 1
        view.prepareShowLoading = true
        view.horizontalPanShowControlView = true
        
        return view
    }()
    
    lazy var realTimeControlView:ZFPlayerControlView = {
        let view = ZFPlayerControlView()
        view.fastViewAnimated = true
        view.autoHiddenTimeInterval = 5
        view.autoFadeTimeInterval = 1
        view.prepareShowLoading = true
        
        return view
    }()
    
    lazy var mediaPlayerController:ZFPlayerController = {
       
        let playerManager = ZFIJKPlayerManager()
        let playerController = ZFPlayerController.init(playerManager: playerManager, containerView: mediaContainerView)
        playerController.controlView = self.mediaControlView
    
        
        playerController.orientationDidChanged = { [unowned self](controller,isFullScreen) in
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        playerController.customAudioSession = true
        
        playerController.playerReadyToPlay = {(asset,assetURL) in
            try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: AVAudioSession.CategoryOptions.allowBluetooth)
            try? AVAudioSession.sharedInstance().setActive(true, options: AVAudioSession.SetActiveOptions.notifyOthersOnDeactivation)
        }
        playerController.setupRTSPContinuePlay(titles: titles, assetDurationArrays: assetTotalTime,urls:assetUrls)
        return playerController
    }()
    
    lazy var realTimePlayerController:ZFPlayerController = {
        
        let playerManager = ZFIJKPlayerManager()
        let playerController = ZFPlayerController.init(playerManager: playerManager, containerView: self.realTimePlayContainer)
        playerController.controlView = self.realTimeControlView
        
        
        playerController.orientationDidChanged = { [unowned self](controller,isFullScreen) in
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        playerController.customAudioSession = true
        
        playerController.playerReadyToPlay = {(asset,assetURL) in
            try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: AVAudioSession.CategoryOptions.allowBluetooth)
            try? AVAudioSession.sharedInstance().setActive(true, options: AVAudioSession.SetActiveOptions.notifyOthersOnDeactivation)
        }
        return playerController
    }()
    
    
    var assetUrls:[URL] = [URL.init(string: "rtsp://192.168.1.165:8888/test1")!,
                           URL.init(string: "rtsp://192.168.1.165:8888/test2")!,
                            URL.init(string: "rtsp://192.168.1.165:8888/test3")!]
//    "rtsp://171.221.230.220:9090/dss/monitor/param?cameraid=1000108%240&substream=1"原始播放地址，不能播放
//    "rtsp://171.221.230.220:9103/dss/monitor/param/cameraid=1000108%240%26substream=1%26sessionid=1565?token=802907&trackID=0"重定向地址，能够播放
    let assetTotalTime:[TimeInterval] = [25,60,19]
    let titles = ["first","second","third"]
    
    let realTimeUrl:URL = URL.init(string: "rtsp://171.221.230.220:9103/dss/monitor/param/cameraid=1000108%240%26substream=1%26sessionid=1565?token=802907&trackID=0")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
//        ZFPlayerLogManager.setLogEnable(true)
//        realTimePlayerController.setRealTimePlayUrl(realTimeUrl)
    }
    
    override func configureSubviews() {
        super.configureSubviews()
        view.addSubview(mediaContainerView)
        mediaContainerView.addSubview(initPlayButton)
        view.addSubview(nextButton)
        
        initPlayButton.sizeToFit()
        initPlayButton.mas_makeConstraints { (make) in
            make?.center.equalTo()(self.mediaContainerView)
        }
        
        mediaContainerView.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.view)?.offset()(StatusBarH + NavigationBarH + 20)
            make?.left.right()?.equalTo()(self.view)
            make?.height.mas_equalTo()(200)
        }
        
        nextButton.sizeToFit()
        nextButton.mas_makeConstraints { (make) in
            make?.centerX.equalTo()(self.view)
            make?.top.equalTo()(self.mediaContainerView.mas_bottom)?.offset()(20)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mediaPlayerController.isViewControllerDisappear = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mediaPlayerController.isViewControllerDisappear = true
    }
    
}

extension DeviceVediosPlayViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if mediaPlayerController.isFullScreen {
            return .lightContent
        }
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return mediaPlayerController.isStatusBarHidden
    }
    
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    
    override var shouldAutorotate: Bool {
        return mediaPlayerController.shouldAutorotate
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if mediaPlayerController.isFullScreen {
            return .landscape
        }
        
        return .portrait
    }
    
}


extension DeviceVediosPlayViewController {
    
    @objc func playPlayer(_ sender: Any) {
       
        if sender as! UIButton == initPlayButton {
            mediaPlayerController.playTheIndex(0)
            mediaControlView.showTitle("first vedio", cover: UIImage.createRandomColorImage(imageSize: CGSize.init(width: 10, height: 10)), fullScreenMode: ZFFullScreenMode.automatic)
        }else if sender as? UIButton == nextButton {
            
//            if (mediaPlayerController.currentPlayerManager as! ZFIJKPlayerManager).isRealTimePlayForRTSP {
//
//                mediaPlayerController.setupRTSPContinuePlay(titles: ["first","second"], assetDurations: assetTotalTime,urls:assetUrls)
//            }else{
//
//                realTimePlayerController.setRealTimePlayUrl(realTimeUrl)
//            }
            
        }
       
    }
}
