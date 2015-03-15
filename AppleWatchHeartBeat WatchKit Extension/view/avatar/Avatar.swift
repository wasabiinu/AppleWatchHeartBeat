//
//  Avatar.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/22.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//
//Avatarの基本クラスです
//Avatarを作る場合は、このクラスを継承して下さい

import Foundation
import WatchKit
internal class Avatar
{
    internal var nodeNo:Int
    internal var image:UIImage
    internal var walk0:[String]
    internal var walk1:[String]
    internal var walk2:[String]
    internal var walk3:[String]
    
    var x:Int
    var y:Int
    var turn:Int
    
    init(let imageName:String, startNo:Int) {
        var point:[Int] = [Int]()
        var start:Int = startNo
        point = DrawUtil.getNodePoint(start)
        println("point:\(point)")
        
        x = point[0]
        y = point[1]
        
        image = DrawUtil.createUIImage(imageName, x:point[0] , y: point[1], width: MapConfig.SCREEN_SIZE.width / MapConfig.AREA_SIZE.width, height: MapConfig.SCREEN_SIZE.height / MapConfig.AREA_SIZE.height)
        
        DrawUtil.heroImage = image
        
        walk0 = [String]()
        walk1 = [String]()
        walk2 = [String]()
        walk3 = [String]()
        
        self.nodeNo = startNo
        
        DrawUtil.isReady = true
        self.turn = 0
    }
    

    internal func position(no:Int, direction:Int = 0, immidiate:Bool = false, callback:Void -> Void) {
        
        var oldNo:Int = self.nodeNo
        var newNo:Int = no
        
        self.nodeNo = newNo
        
        var oldX:Int = DrawUtil.getNodePoint(oldNo)[0]
        var oldY:Int = DrawUtil.getNodePoint(oldNo)[1]
        
        var xDiff:Int = DrawUtil.getNodePoint(newNo)[0] - oldX
        var yDiff:Int = DrawUtil.getNodePoint(newNo)[1] - oldY
        
        AloeTween.doTween(0.6, ease: AloeEase.None, progress: { (val) -> () in
            
            var x:Int = Int(Float(oldX) + Float(xDiff) * Float(val))
            var y:Int = Int(Float(oldY) + Float(yDiff) * Float(val))
            
            self.x = x
            self.y = y
            if( val >= 1)
            {
                callback()
            }
            
        })
    }
    
    internal func createUIImage()
    {
        var cgNo:Int = turn % 3
        self.image = DrawUtil.createUIImage(self.walk0[cgNo], x:self.x , y: self.y, width: MapConfig.SCREEN_SIZE.width / MapConfig.AREA_SIZE.width, height: MapConfig.SCREEN_SIZE.height / MapConfig.AREA_SIZE.height)
        
        DrawUtil.heroImage = self.image
    }
}