//
//  TestHero.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/22.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
internal class Hero: Human
{
    init() {
        super.init(imageName: "human.avatar.hero.0.0.png")
        
        super.walk0.append("human.avatar.hero.0.0.png")
        super.walk0.append("human.avatar.hero.0.1.png")
        super.walk0.append("human.avatar.hero.0.2.png")
        
        super.walk1.append("human.avatar.hero.1.0.png")
        super.walk1.append("human.avatar.hero.1.1.png")
        super.walk1.append("human.avatar.hero.1.2.png")
        
        super.walk2.append("human.avatar.hero.2.0.png")
        super.walk2.append("human.avatar.hero.2.1.png")
        super.walk2.append("human.avatar.hero.2.2.png")
        
        super.walk3.append("human.avatar.hero.3.0.png")
        super.walk3.append("human.avatar.hero.3.1.png")
        super.walk3.append("human.avatar.hero.3.2.png")
        
        
    }
}