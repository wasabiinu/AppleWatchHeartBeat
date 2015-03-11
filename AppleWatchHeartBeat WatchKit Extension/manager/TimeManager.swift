//
//  TimeManager.swift
//  AppleWatchHeartBeat
//
//  Created by 横山 優 on 2015/03/11.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
internal class TimerManager: NSObject
{
    internal func start()
    {
        var timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("onUpdate:"), userInfo: nil, repeats: true)
    }
    
    internal func onUpdate(timer:NSTimer)
    {
        DrawUtil.draw()
    }
}