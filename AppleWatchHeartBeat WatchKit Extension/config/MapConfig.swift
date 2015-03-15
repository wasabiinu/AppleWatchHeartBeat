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
    
    internal class var REFRESH_RATE:Float
    {
        get
        {
            return ClassProperty.refreshRate
        }
    }
    
    internal class var HEARTBEAT_RATE:Float
        {
        get
    {
        return ClassProperty.heartbeatRate
        }
    }
    
    internal class var MOVE_SEC:Float
        {
        get
    {
        return ClassProperty.moveSec
        }
    }
    
    
    private struct ClassProperty {
        static var areaSize:AreaSize! = AreaSize()
        static var screenSize:ScreenSize = ScreenSize()
        static var refreshRate:Float = 4
        static var heartbeatRate:Float = 40
        static var moveSec:Float = 60 / heartbeatRate
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