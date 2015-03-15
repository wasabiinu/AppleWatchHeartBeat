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
        
//        var refreshTime:NSTimeInterval = NSTimeInterval(1 / MapConfig.REFRESH_RATE)
//        var timer = NSTimer.scheduledTimerWithTimeInterval(refreshTime, target: self, selector: Selector("onUpdate:"), userInfo: nil, repeats: true)
        
        var turnTime:NSTimeInterval = NSTimeInterval(60 / MapConfig.HEARTBEAT_RATE)
        println("turnTime:\(turnTime)")
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
            
            var direction:Int = 0
            
            if ( turn - 1 >= 0)
            {
                var oldNo:Int = DrawUtil.route[turn-1]
                var newNo:Int = DrawUtil.route[turn]
                
                if (oldNo + MapConfig.AREA_SIZE.width ==  newNo)
                {
                    direction = 0
                }
                else if(oldNo + 1 == newNo)
                {
                    direction = 1
                }
                else if(oldNo - MapConfig.AREA_SIZE.width == newNo)
                {
                    direction = 2
                }
                else if(oldNo - 1 == newNo)
                {
                    direction = 3
                }
            }
            
            //1ターン分の画像を作る
            println("direction:\(direction)")
            DrawUtil.delegate.model.hero.position(DrawUtil.route[turn], direction: direction, immidiate: false, callback: callbackTurn)
            
            
            
            turn++
        }
        else
        {
            DrawUtil.isReady = false
            println("clear!")
        }
        
        DrawUtil.draw()
    }
    
    internal func callbackTurn()
    {
        
    }
}