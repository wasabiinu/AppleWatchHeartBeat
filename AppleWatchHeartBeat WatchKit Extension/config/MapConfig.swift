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
    
    
    
    private struct ClassProperty {
        static var areaSize:AreaSize! = AreaSize()
        static var screenSize:ScreenSize = ScreenSize()
        static var refreshRate:Int = 24
    }
    
    internal struct AreaSize
    {
        var width:Int = 16
        var height:Int = 16
    }
    
    internal struct ScreenSize
    {
        var width:Int = 150
        var height:Int = 150
    }
}