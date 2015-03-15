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
    internal var turn:Int = 0
    internal func start()
    {
        println("NSTimeInterval(1 / MapConfig.REFRESH_RATE):\(NSTimeInterval(1 / MapConfig.REFRESH_RATE))")
        
        var refreshTime:NSTimeInterval = NSTimeInterval(1 / MapConfig.REFRESH_RATE)
        var timer = NSTimer.scheduledTimerWithTimeInterval(refreshTime, target: self, selector: Selector("onUpdate:"), userInfo: nil, repeats: true)
        
        var turnTime:NSTimeInterval = NSTimeInterval(60 / MapConfig.HEARTBEAT_RATE)
        var turnTimer = NSTimer.scheduledTimerWithTimeInterval(turnTime, target: self, selector: Selector("onTurn:"), userInfo: nil, repeats: true)
    }
    
    internal func onUpdate(timer:NSTimer)
    {
        println("onUpdata")
        DrawUtil.draw()
    }
    
    internal func onTurn(timer:NSTimer)
    {
        if (turn < DrawUtil.route.count)
        {
            println("onTurn")
            DrawUtil.delegate.model.hero.position(DrawUtil.route[turn], direction: 0, immidiate: false, callback: callbackTurn)
            turn++
        }
        else
        {
            println("clear!")
        }
    }
    
    internal func callbackTurn()
    {
        
    }
}