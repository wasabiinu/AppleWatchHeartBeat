//
//  UIDelegate.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/12.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import WatchKit

class UIDelegate {
    var model:UIModel;
    var scene:WKInterfaceGroup
    
    init (model:UIModel, scene:WKInterfaceGroup)
    {
        self.model = model
        self.scene = scene
    }
    
    deinit {
        
    }
    
    internal func getModelLock() -> Bool
    {
        return self.model.lock
    }
    
    internal func setModelLock(v:Bool)
    {
        self.model.lock = v
    }
    
    internal func moveHero(callback:Void -> Void, option:[AnyObject])
    {
        self.model.moveHero(callback, option: option)
    }
}