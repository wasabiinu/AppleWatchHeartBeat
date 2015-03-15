//
//  UIUtil.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/09.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation

class UIUtil {
    
    private struct ClassProperty {
        static var delegate:UIDelegate!
    }
    
    internal class var delegate:UIDelegate
        {
        set {
        ClassProperty.delegate = newValue
        }
        get {
            return ClassProperty.delegate
        }
    }
    
    internal class func setDelegate(delegate:UIDelegate)
    {
        println("MapUtil::setDelegate")
        self.delegate = delegate
    }
}