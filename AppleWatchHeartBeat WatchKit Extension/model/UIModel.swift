//
//  UIModel.swift
//  AppleWatchHeartBeat
//
//  Created by 横山 優 on 2015/03/14.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
import WatchKit

class UIModel {
    var delegate:UIDelegate!;
    var lock:Bool
    var scene:WKInterfaceImage
    
    init (scene:WKInterfaceImage)
    {
        self.scene = scene
        println("UIModel::init")
        self.lock = false
        afterInit()
    }
    
    deinit {
        delegate = nil
    }
    
    private func afterInit()
    {
        delegate = UIDelegate(model: self, scene:scene)
        UIUtil.setDelegate(delegate)
    }
    
    internal func onTouchButton0()
    {
        println("UIModel::onTouchButton0")
    }
    
    internal func moveHero(callback:Void -> Void, option:[AnyObject])
    {
        MapUtil.moveAvatar(option[0] as Avatar, direction: HeroManager.getNextDirection(), callback:callback)
    }
}