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
    internal var mainScene: WKInterfaceImage!
    internal var delegate:MapDelegate!
    internal var hero:Avatar!
    init (scene:WKInterfaceImage)
    {
        mainScene = scene
        delegate = MapDelegate(model: self)
        DrawUtil.setDelegate(delegate)
        
        self.hero = Hero()
        var timeManager:TimerManager = TimerManager()
        timeManager.start()
        
        //self.mainScene.setImage(DrawUtil.animationImage)
        //AloeTween.doTween(duration:0.042, ease: AloeEase.None, progress: DrawUtil.draw())
    }
}