//
//  NpcBasicModel.swift
//  Forever
//
//  Created by iMac-03 on 2019/7/31.
//  Copyright © 2019 daimu. All rights reserved.
//

import UIKit

class NpcBasicModel: NSObject {

    // 攻击 , 防御 , 血量 , 攻速 , 等级 , 转生等级
    var name = "";
    var imgName = "";
    
    // 攻击
    var attackBase : Double = 15;
    var attackGrowth : Double = 1.5;
    
    // 防御
    var defenseBase : Double = 12;
    var defenseGrowth : Double = 1.2;
    
    // 血量
    var bloodBase : Double = 100;
    var bloodGrowth : Double = 10;
    
    // 攻速
    var speedBase : Double = 0.333;
    var speedGrowth : Double = 0.033;
    
    
    init(name:String) {
        if name == "李逍遥" {
            imgName = "npc_1";
            attackGrowth  = 2;
            defenseGrowth  = 1.5;
            bloodGrowth  = 12;
            speedGrowth = 0.038;
        } else if name == "怪物1" {
            imgName = "npc_11";
            attackGrowth  = 1.5;
            defenseGrowth  = 1.2;
            bloodGrowth  = 10;
            speedGrowth = 0.033;
        }
    }
}
