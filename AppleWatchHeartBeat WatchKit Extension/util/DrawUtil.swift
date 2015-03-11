//
//  DrawUtil.swift
//  AppleWatchHeartBeat
//
//  Created by 横山 優 on 2015/03/11.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
internal class DrawUtil {
    internal class var delegate:MapDelegate
        {
        set {
        ClassProperty.delegate = newValue
        }
        get {
            return ClassProperty.delegate
        }
    }
    
    internal class var nodes:[Node]
        {
        set {
        ClassProperty.nodes = newValue
        }
        get {
            return ClassProperty.nodes
        }
    }
    
    private struct ClassProperty {
        static var delegate:MapDelegate!
        static var nodes:[Node]!
    }
    
    internal class func setDelegate(delegate:MapDelegate)
    {
        println("DrawUtil::setDelegate")
        self.delegate = delegate
        for (var i:Int = 0; i < MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height; i++)
        {
            var node:Node = Node(edges_to: [], edges_cost: [])
            node.type = 0
            nodes.append(node)
        }
    }
    
    internal class func draw()
    {
        println("DrawUtil.draw")
    }
}