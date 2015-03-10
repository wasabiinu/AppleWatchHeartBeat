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
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
    }
    
    override func willActivate() {
        super.willActivate()
        
        var ary:[UIImage] = [UIImage]()
        for (var i:Int = 0; i < 512; i++)
        {
            ary.append(UIImage(named: "ground.rectcheck.0")!)
            ary.append(UIImage(named: "ground.rectcheck.1")!)
        }
        var image:UIImage = synthesizeImage(ary)
        mainScene.setImage(image)
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    func synthesizeImage(ary: [UIImage]) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(150,150), false, 0.0);
        for (var i:Int = 0; i < 512; i++)
        {
            var image:UIImage = ary[i]
            image.drawInRect(CGRectMake(CGFloat(i), CGFloat(i), image.size.width, image.size.height))
        }
//        for image in ary
//        {
//            image.drawInRect(CGRectMake(0, 0, image.size.width, image.size.height))
//        }
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage
    }
    
}
