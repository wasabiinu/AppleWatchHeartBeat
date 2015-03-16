//
//  InterfaceController.swift
//  AppleWatchHeartBeat WatchKit Extension
//
//  Created by 横山 優 on 2015/03/10.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var mainScene: WKInterfaceImage!
    var mapModel:MapModel!
    var uiModel:UIModel!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
    }
    
    override func willActivate() {
        super.willActivate()
        mapModel = MapModel(scene: mainScene)
        uiModel = UIModel(scene: mainScene)
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
//    @IBAction func onTouchButton0() {
//        uiModel.onTouchButton0()
//    }
    
}
