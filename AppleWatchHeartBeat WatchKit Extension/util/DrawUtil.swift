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
    
    internal class var isReady:Bool
        {
        set {
        ClassProperty.isReady = newValue
        }
        get {
            return ClassProperty.isReady
        }
    }
    
    private struct ClassProperty {
        static var delegate:MapDelegate!
        static var nodes:[Node]!
        static var mapImage:UIImage!
        static var isReady:Bool = false
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
//            if ((i - MapConfig.AREA_SIZE.width) >= 0)
//            {
//                edges_to.append(i - MapConfig.AREA_SIZE.width)
//                edges_cost.append(1)
//            }
//            
//            //左
//            if ((i % MapConfig.AREA_SIZE.width ) != 0 && (i - 1) >= 0)
//            {
//                edges_to.append(i - 1)
//                edges_cost.append(1)
//            }
//            
//            //右
//            if (((i + 1) % MapConfig.AREA_SIZE.width ) != 0 && (i + 1) < (MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height))
//            {
//                edges_to.append(i + 1)
//                edges_cost.append(1)
//            }
//            
//            //下
//            if ((i + MapConfig.AREA_SIZE.width) < (MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height))
//            {
//                edges_to.append(i + MapConfig.AREA_SIZE.width)
//                edges_cost.append(1)
//            }
            
            
            var node:Node = Node(edges_to: edges_to, edges_cost: edges_cost)
            node.type = 1
            nodes.append(node)
        }
        diggNodes()
//        deleteRandomNode()
        drawMap()
    }
    
    private class func diggNodes()
    {
        var start:Int = -1
        var now:Int = -1
        var areaSize:Int = MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height
        var route:[Int] = [Int]()
        
        //外周以外の1点をスタート地点に指定する
        while (isOuterWall(start))
        {
            start = Int(Random.random(UInt32(areaSize)))
        }
        
        route.append(start)
        now = start
        
        var isMovable:Bool = false
        while (isMovable == false)
        {
            var walls:[Int] = [Int]()
            var passages:[Int] = [Int]()
            //進んできたグリッド(routeに含まれるもの)を除いた四方向のどれかの壁を掘る
            //戻れなくなったら終了する
            //外周が含まれていたらwallsに追加する
            //wallsが3つになったら、一つ前に戻る
            //wallsに含まれていないグリッドを、passagesに追加する
            //passagesから、ランダムで1つ選んで、edges_toに追加する
            //同じ値を、routeにも追加する
            //同じ値を、nowに入れて、処理を最初から繰り返す
            var rand:Int = Int(Random.random(3))
            switch (rand)
            {
                case 0:
                    //外周だったらやりなおす
                    if (isOuterWall(rand))
                    {
                        break
                    }
                    
                break
                case 1:
                    //外周だったらやりなおす
                    if (isOuterWall(rand))
                    {
                        break
                    }
                break
                case 2:
                    //外周だったらやりなおす
                    if (isOuterWall(rand))
                    {
                        break
                    }
                    
                break
                default:
                    //外周だったらやりなおす
                    if (isOuterWall(rand))
                    {
                        break
                    }
                break
            }
        }
        
    }
    
    private class func isOuterWall(num:Int)->Bool
    {
        return num < 0 ||
            num % MapConfig.AREA_SIZE.width == 0 || //左端
            num % MapConfig.AREA_SIZE.width == MapConfig.AREA_SIZE.width - 1 || //右端
            num - MapConfig.AREA_SIZE.width < 0 || //上端
            num - MapConfig.AREA_SIZE.width * (MapConfig.AREA_SIZE.height - 1) >= 0 //下端
    }
    
    private class func deleteRandomNode()
    {
        for (var n:Int = 0; n < MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height / 4; n++)
        {
            var _nodes:[Node] = nodes
            var ary:[Node] = []
            var rand:UInt32 = Random.random(UInt32(MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height))
            var edges_to:[Int] = _nodes[Int(rand)].edges_to
            _nodes[Int(rand)].edges_cost = []
            _nodes[Int(rand)].edges_to = []
            var isArrival:Bool = true
            for (var i:Int = 0; i < edges_to.count; i++)
            {
                if (RouteUtil.getArrival(_nodes, start: 0, goal: MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height - 1) == false)
                {
                    isArrival = false
                    break
                }
            }
            
            
            if (isArrival == true)
            {
                _nodes[Int(rand)].type = 1
                nodes = _nodes
            }
        }
    }
    
    internal class func drawMap()
    {
        println("drawMap")
        var ary:[UIImage] = [UIImage]()
        var rectSize:CGSize = CGSizeMake(CGFloat(Int(MapConfig.SCREEN_SIZE.width / MapConfig.AREA_SIZE.width)), CGFloat(Int(MapConfig.SCREEN_SIZE.height / MapConfig.AREA_SIZE.height)))
        
        
        for (var i:Int = 0; i < nodes.count; i++)
        {
            UIGraphicsBeginImageContext(CGSizeMake(CGFloat(MapConfig.SCREEN_SIZE.width), CGFloat(MapConfig.SCREEN_SIZE.height)))
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
        isReady = true
        draw()
    }
    
    internal class func draw()
    {
        if(isReady == true)
        {
            println("draw")
            delegate.model.mainScene.setImage(mapImage)
        }
    }
    
    private class func synthesizeImage(ary: [UIImage]) -> UIImage {
        println("synthesizeImage")
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(150,150), false, 0.0);
        for (var i:Int = 0; i < ary.count; i++)
        {
            var image:UIImage = ary[i]
            image.drawInRect(CGRectMake(0, 0, image.size.width, image.size.height))
        }
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        println("end synthesizeImage")
        return newImage
    }
}