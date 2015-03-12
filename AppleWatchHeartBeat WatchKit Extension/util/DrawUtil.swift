//
//  DrawUtil.swift
//  AppleWatchHeartBeat
//
//  Created by 横山 優 on 2015/03/11.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
import WatchKit

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
    
    internal class var mapImage:UIImage
        {
        set {
        ClassProperty.mapImage = newValue
        }
        get {
            return ClassProperty.mapImage
        }
    }
    
    private struct ClassProperty {
        static var delegate:MapDelegate!
        static var nodes:[Node]!
        static var mapImage:UIImage!
    }
    
    internal class func setDelegate(delegate:MapDelegate)
    {
        println("DrawUtil::setDelegate")
        self.delegate = delegate
        nodes = []
        for (var i:Int = 0; i < MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height; i++)
        {
            var edges_to:[Int] = [Int]()
            var edges_cost:[Int] = [Int]()
            
            //上
            if ((i - MapConfig.AREA_SIZE.width) >= 0)
            {
                edges_to.append(i - MapConfig.AREA_SIZE.width)
                edges_cost.append(1)
            }
            
            //左
            if ((i % MapConfig.AREA_SIZE.width ) != 0 && (i - 1) >= 0)
            {
                edges_to.append(i - 1)
                edges_cost.append(1)
            }
            
            //右
            if (((i + 1) % MapConfig.AREA_SIZE.width ) != 0 && (i + 1) < (MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height))
            {
                edges_to.append(i + 1)
                edges_cost.append(1)
            }
            
            //下
            if ((i + MapConfig.AREA_SIZE.width) < (MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height))
            {
                edges_to.append(i + MapConfig.AREA_SIZE.width)
                edges_cost.append(1)
            }
            
            var node:Node = Node(edges_to: edges_to, edges_cost: edges_cost)
            node.type = 0
            nodes.append(node)
        }
        
        drawMap()
    }
    
    internal class func drawMap()
    {
        var ary:[UIImage] = [UIImage]()
        var rectSize:CGSize = CGSizeMake(CGFloat(Int(MapConfig.SCREEN_SIZE.width / MapConfig.AREA_SIZE.width)), CGFloat(Int(MapConfig.SCREEN_SIZE.height / MapConfig.AREA_SIZE.height)))
        
        for (var i:Int = 0; i < nodes.count; i++)
        {
            UIGraphicsBeginImageContext(rectSize)
            var cgContextRef = UIGraphicsGetCurrentContext()
            
            //typeによって色を使い分ける
            if (nodes[i].type == 0)
            {
                CGContextSetFillColorWithColor(cgContextRef, UIColor.greenColor().CGColor)
            }
            else
            {
                CGContextSetFillColorWithColor(cgContextRef, UIColor.brownColor().CGColor)
            }
            
            var x:CGFloat = CGFloat(i % MapConfig.AREA_SIZE.width) * rectSize.width
            var y:CGFloat = CGFloat(i / MapConfig.AREA_SIZE.width) * rectSize.height
            CGContextFillRect(cgContextRef, CGRectMake(x, y, rectSize.width, rectSize.height))
            var image = UIGraphicsGetImageFromCurrentImageContext()
            ary.append(image)
        }
        
        self.mapImage = synthesizeImage(ary)
    }
    
    internal class func draw()
    {
        delegate.model.mainScene.setImage(mapImage)
        println("DrawUtil.draw")
    }
    
    private class func synthesizeImage(ary: [UIImage]) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(150,150), false, 0.0);
        for (var i:Int = 0; i < 512; i++)
        {
            var image:UIImage = ary[i]
            image.drawInRect(CGRectMake(CGFloat(i), CGFloat(i), image.size.width, image.size.height))
        }
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage
    }
}