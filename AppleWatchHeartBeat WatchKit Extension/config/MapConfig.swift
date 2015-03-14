//
//  MapConfig.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/21.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
internal class MapConfig
{
    internal class var AREA_SIZE:AreaSize
    {
        get
        {
            return ClassProperty.areaSize
        }
    }
    
    internal class var SCREEN_SIZE:ScreenSize
    {
        get
        {
            return ClassProperty.screenSize
        }
    }
    
    internal class var REFRESH_RATE:Int
    {
        get
        {
            return ClassProperty.refreshRate
        }
    }
    
    internal class var HEARTBEAT_RATE:Int
        {
        get
    {
        return ClassProperty.heartbeatRate
        }
    }
    
    internal class var MOVE_SEC:Int
        {
        get
    {
        return ClassProperty.moveSec
        }
    }
    
    
    private struct ClassProperty {
        static var areaSize:AreaSize! = AreaSize()
        static var screenSize:ScreenSize = ScreenSize()
        static var refreshRate:Int = 24
        static var heartbeatRate:Int = 80
        static var moveSec:Int = 60 / heartbeatRate
    }
    
    internal struct AreaSize
    {
        var width:Int = 12
        var height:Int = 12
    }
    
    internal struct ScreenSize
    {
        var width:Int = 150
        var height:Int = 150
    }
}