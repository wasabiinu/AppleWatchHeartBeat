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
    
    private struct ClassProperty {
        static var areaSize:AreaSize! = AreaSize()
    }
    
    internal struct AreaSize
    {
        var width:Int = 32
        var height:Int = 32
    }
}