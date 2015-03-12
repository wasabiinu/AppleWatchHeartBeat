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
        set {
        ClassProperty.areaSize = newValue
        }
        get {
            return ClassProperty.areaSize
        }
    }
    
    internal class var SCREEN_SIZE:ScreenSize
        {
        set {
        ClassProperty.screenSize = newValue
        }
        get {
            return ClassProperty.screenSize
        }
    }
    
    private struct ClassProperty {
        static var areaSize:AreaSize! = AreaSize()
        static var screenSize:ScreenSize = ScreenSize()
    }
    
    internal struct AreaSize
    {
        var width:Int = 32
        var height:Int = 32
    }
    
    internal struct ScreenSize
    {
        var width:Int = 150
        var height:Int = 150
    }
}