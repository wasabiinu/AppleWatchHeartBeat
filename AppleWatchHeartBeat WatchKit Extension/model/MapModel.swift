//
//  MapModel.swift
//  AppleWatchHeartBeat
//
//  Created by 横山 優 on 2015/03/11.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
import WatchKit

internal class MapModel
{
    var mainScene: WKInterfaceImage!
    internal var delegate:MapDelegate!
    init (scene:WKInterfaceImage)
    {
        delegate = MapDelegate(model: self)
        mainScene = scene
        
        DrawUtil.setDelegate(delegate)
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("onUpdate:"), userInfo: nil, repeats: true)

        
        //AloeTween.doTween(duration:0.042, ease: AloeEase.None, progress: DrawUtil.draw())
    }
    
    private func onUpdate()
    {
        DrawUtil.draw()
    }
}