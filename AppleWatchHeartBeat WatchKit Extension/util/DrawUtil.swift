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
            
            var node:Node = Node(edges_to: edges_to, edges_cost: edges_cost)
            node.type = 1
            nodes.append(node)
        }
        diggNodes()
        drawMap()
    }
    
    private class func diggNodes()
    {
        var start:Int = -1
        var now:Int = -1
        var areaSize:Int = MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height
        var route:[Int] = [Int]()
        var returns:[Int] = [Int]()
        
        //外周以外の1点をスタート地点に指定する
        while (isOuterWall(start))
        {
            start = Int(Random.random(UInt32(areaSize)))
        }
        
        
        now = start
        var isEnd:Bool = false
        
        for(var i:Int = 0; i < MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height * 2 || isEnd == true; i++)
        {
            //繰り返しここから
            
            route.append(now)
            returns.append(now)
            var walls:[Int] = [Int]()
            var neighbors:[Int] = [Int]()
            //進んできたグリッド(routeに含まれるもの)を除いた四方向のどれかの壁を掘る
            //上
            var upperGrid:Int = now - MapConfig.AREA_SIZE.width
            if (upperGrid >= 0)
            {
                if (isOuterWall(upperGrid))
                {
                    //外周が含まれているか、既にwallsに追加する
                    walls.append(upperGrid)
                }
                else if (isRoute(upperGrid, route: route))
                {
                    //壁にも追加する
                    //walls.append(upperGrid)
                }
                else
                {
                    //wallsに含まれていないグリッドを、neighborsに追加する
                    neighbors.append(upperGrid)
                }
            }
            
            //下
            var lowerGrid:Int = now + MapConfig.AREA_SIZE.width
            if (lowerGrid < MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height)
            {
                if (isOuterWall(lowerGrid))
                {
                    //外周が含まれていたらwallsに追加する
                    walls.append(lowerGrid)
                }
                else if (isRoute(lowerGrid, route: route))
                {
                    //壁に追加する
                    //walls.append(lowerGrid)
                }
                else
                {
                    //wallsに含まれていないグリッドを、neighborsに追加する
                    neighbors.append(lowerGrid)
                }
            }
            
            //左
            var leftGrid:Int = now - 1
            if (isOuterWall(leftGrid))
            {
                //外周が含まれていたらwallsに追加する
                walls.append(leftGrid)
            }
            else if (isRoute(leftGrid, route: route))
            {
                //壁に追加する
                walls.append(leftGrid)
            }
            else
            {
                //wallsに含まれていないグリッドを、neighborsに追加する
                neighbors.append(leftGrid)
            }
            
            //右
            var rightGrid:Int = now + 1
            if (isOuterWall(rightGrid))
            {
                //外周が含まれていたらwallsに追加する
                walls.append(rightGrid)
            }
            else if (isRoute(rightGrid, route: route))
            {
                //壁に追加する
                walls.append(rightGrid)
            }
            else
            {
                //wallsに含まれていないグリッドを、neighborsに追加する
                neighbors.append(rightGrid)
            }
            
            
            //戻れなくなったら終了する
            
            //wallsが3つになったら、一つ前に戻る
            if (walls.count >= 3)
            {
                
                var count:Int = returns.count - 1
                if(returns.count - 1 < 0)
                {
                    break
                }
                while(returns[count] == now)
                {
                    returns.removeLast()
                    count = returns.count - 1
                    if (count < 0)
                    {
                        isEnd = true
                        break
                    }
                }
                
                if (count < 0)
                {
                    isEnd = true
                    break
                }
                now = returns[count]
            }
            else if (neighbors.count <= 0)
            {
                isEnd = true
                break
            }
            else
            {
                
                //neighborsから、ランダムで1つ選んで、edges_toに追加する
                var next:Int = neighbors[Int(Random.random(UInt32(neighbors.count - 1)))]
                nodes[now].edges_to.append(next)
                
                nodes[now].type = 0
                
                if (isEqualEdgeNo(now, edges_to: nodes[next].edges_to) == false)
                {
                    nodes[next].edges_to.append(now)
                }
                
                if (isEqualEdgeNo(next, edges_to: nodes[now].edges_to) == false)
                {
                    nodes[now].edges_to.append(next)
                }
                
                //同じ値を、nowに入れて、処理を最初から繰り返す
                now = next
            }
            
        }
        
        var end:Int = now
    }
    
    private class func isEqualEdgeNo(no:Int, edges_to:[Int]) -> Bool
    {
        var isEqual:Bool = false
        for edgeNum in edges_to
        {
            if (edgeNum == no)
            {
                isEqual = true
            }
        }
        
        return isEqual
    }
    
    private class func isRoute(grid:Int, route:[Int]) -> Bool
    {
        for num in route
        {
            if (num == grid)
            {
                return true
            }
        }
        return false
    }
    
    private class func isOuterWall(num:Int) -> Bool
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
        
        UIGraphicsBeginImageContext(CGSizeMake(CGFloat(MapConfig.SCREEN_SIZE.width), CGFloat(MapConfig.SCREEN_SIZE.height)))
        var bgCgContextRef = UIGraphicsGetCurrentContext()
        var bgImage:UIImage = UIImage(named: "chipbg.png")!
        
        
        let bgOrigRef    = bgImage.CGImage;
        let bgOrigWidth  = Int(CGImageGetWidth(bgOrigRef))
        let bgOrigHeight = Int(CGImageGetHeight(bgOrigRef))
        var bgResizeWidth:Int = 0, bgResizeHeight:Int = 0
        
        if (bgOrigWidth < bgOrigHeight) {
            bgResizeWidth = Int(rectSize.width) * MapConfig.AREA_SIZE.width
            bgResizeHeight = bgOrigHeight * bgResizeWidth / bgOrigWidth
        } else {
            bgResizeHeight = Int(rectSize.height) * MapConfig.AREA_SIZE.height
            bgResizeWidth = bgOrigWidth * bgResizeHeight / bgOrigHeight
        }
        
        var diffX:Int = MapConfig.SCREEN_SIZE.width - Int(rectSize.width) * MapConfig.AREA_SIZE.width
        var diffY:Int = MapConfig.SCREEN_SIZE.height - Int(rectSize.height) * MapConfig.AREA_SIZE.height
        
        bgImage.drawInRect(CGRectMake(CGFloat(diffX / 2), CGFloat(diffY / 2), CGFloat(bgResizeWidth), CGFloat(bgResizeHeight)))
        
        let resizeBgImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        ary.append(resizeBgImage)
        
        
        for (var i:Int = 0; i < nodes.count; i++)
        {
            
            var x:CGFloat = CGFloat(i % MapConfig.AREA_SIZE.width) * rectSize.width + CGFloat(diffX / 2)
            var y:CGFloat = CGFloat(i / MapConfig.AREA_SIZE.width) * rectSize.height + CGFloat(diffY / 2)
            
            UIGraphicsBeginImageContext(CGSizeMake(CGFloat(MapConfig.SCREEN_SIZE.width), CGFloat(MapConfig.SCREEN_SIZE.height)))
            var cgContextRef = UIGraphicsGetCurrentContext()
            
            var wall:Int = 1111
            var edges_to:[Int] = nodes[i].edges_to
            
            for num in edges_to
            {
                //下
                if (num == i + MapConfig.AREA_SIZE.width)
                {
                    wall -= 1000
                }
                //右
                else if(num == i + 1)
                {
                    wall -= 100
                }
                //上
                else if(num == i - MapConfig.AREA_SIZE.width)
                {
                    wall -= 10
                }
                //左
                else if(num == i - 1)
                {
                    wall -= 1
                }
            }
            
            var wallString:String = ""
            if (wall < 10)
            {
                wallString = "000" + String(wall)
            }
            else if(wall < 100)
            {
                wallString = "00" + String(wall)
            }
            else if(wall < 1000)
            {
                wallString = "0" + String(wall)
            }
            else
            {
                wallString = String(wall)
            }
            
            var chipName:String = "chip" + wallString + ".png"
            
            var image:UIImage = UIImage(named: chipName)!
            
            
            let origRef    = image.CGImage;
            let origWidth  = Int(CGImageGetWidth(origRef))
            let origHeight = Int(CGImageGetHeight(origRef))
            var resizeWidth:Int = 0, resizeHeight:Int = 0
            
            if (origWidth < origHeight) {
                resizeWidth = Int(rectSize.width)
                resizeHeight = origHeight * resizeWidth / origWidth
            } else {
                resizeHeight = Int(rectSize.height)
                resizeWidth = origWidth * resizeHeight / origHeight
            }
            
            image.drawInRect(CGRectMake(x, y, CGFloat(resizeWidth), CGFloat(resizeHeight)))
            
            let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            ary.append(resizeImage)
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