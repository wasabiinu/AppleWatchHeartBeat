//
//  MapUtil.swift
//  AppleWatchHeartBeat
//
//  Created by 横山 優 on 2015/03/14.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
internal class MapUtil {
    
    internal class var delegate:MapDelegate
        {
        set {
        ClassProperty.delegate = newValue
        }
        get {
            return ClassProperty.delegate
        }
    }
    
    private struct ClassProperty {
        static var delegate:MapDelegate!
    }
    
    internal class func setDelegate(delegate:MapDelegate)
    {
        println("MapUtil::setDelegate")
        self.delegate = delegate
    }
    
    internal class func moveAvatar(avatar:Avatar, direction:Int, callback:Void -> Void)
    {
        var nodes:[Node] = DrawUtil.nodes
        var no:Int = avatar.nodeNo
        var ary:[Int] = nodes[no].edges_to
        
        for checkNo:Int in ary
        {
            if (checkMovable(avatar, direction:direction, checkNo:checkNo))
            {
                avatar.position(self.moveNodeNo(direction, no:no), direction:direction, callback:callback)
            }
        }
    }
    
    internal class func checkMovable(avatar:Avatar, direction:Int, checkNo:Int) -> Bool
    {
        var nodes:[Node] = DrawUtil.nodes
        var no:Int = avatar.nodeNo
        var moveNodeNo:Int = 0
        switch (direction)
        {
        case 0:
            moveNodeNo = no + Int(MapConfig.AREA_SIZE.width)
            break
        case 1:
            moveNodeNo = no + 1
            break
        case 2:
            moveNodeNo = no - Int(MapConfig.AREA_SIZE.width)
            break
        case 3:
            moveNodeNo = no - 1
            break
        default :
            moveNodeNo = no + Int(MapConfig.AREA_SIZE.width)
            break
        }
        
        return checkNo == moveNodeNo
    }
    
    internal class func moveNodeNo(direction:Int, no:Int) -> Int
    {
        var moveNodeNo:Int = 0
        switch (direction)
        {
        case 0:
            moveNodeNo = no + Int(MapConfig.AREA_SIZE.width)
            break
        case 1:
            moveNodeNo = no + 1
            break
        case 2:
            moveNodeNo = no - Int(MapConfig.AREA_SIZE.width)
            break
        case 3:
            moveNodeNo = no - 1
            break
        default :
            moveNodeNo = no + Int(MapConfig.AREA_SIZE.width)
            break
        }
        
        return moveNodeNo
    }
}