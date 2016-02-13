//
//  ThirdViewController.swift
//  VideoPlayer
//
//  Created by Ary on 2015/05/08.
//  Copyright (c) 2015年 Trabal. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ThirdViewController: UIViewController {

    var playerViewController: AVPlayerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 動画ファイルのURLを取得
//        let url = NSURL(string: "https://devimages.apple.com.edgekey.net/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8")!
        // どこかから拾ってきたやつ
//        let url = NSURL(scheme: "http", host: "devimages.apple.com", path: "/iphone/samples/bipbop/bipbopall.m3u8")!
        
        // https://developer.apple.com/streaming/examples/
        // なぜかhttp許容にする必要があった(SSL証明書が基準満たしてないのかな)
//        let url = NSURL(scheme: "https", host: "devimages.apple.com.edgekey.net", path: "/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8")!
//        let url = NSURL(scheme: "https", host: "devimages.apple.com.edgekey.net", path: "/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!
        
        // CloudFormation
        let url = NSURL(scheme: "http", host: "d3bsl1rterq3zk.cloudfront.net", path: "/livecf/myStream/playlist.m3u8")!

        
        // アイテム取得
        let playerItem = AVPlayerItem(URL: url)
        
        // 生成
        let player = AVPlayer(playerItem: playerItem)
        playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        // 設定
        playerViewController.view.frame = CGRectMake(54, 96, view.bounds.width - 108, view.bounds.height - 192)
        playerViewController.showsPlaybackControls = true // 操作パネルを非表示にする場合はfalse
        playerViewController.videoGravity = AVLayerVideoGravityResizeAspect // 矩形にフィット
        
        // 通知登録
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didPlayerItemReachEnd:", name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
        
        // 表示
        view.addSubview(playerViewController.view)
        
        // 再生
        player.play()
    }

    func didPlayerItemReachEnd(notification: NSNotification) {
        guard let player = playerViewController.player else {
            return
        }
        // リピート再生
        player.seekToTime(kCMTimeZero)
        player.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

