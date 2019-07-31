//
//  NpcModel.swift
//  Forever
//
//  Created by iMac-03 on 2019/7/29.
//  Copyright © 2019 daimu. All rights reserved.
//

import UIKit

class NpcModel: NSObject {
    
    let basic:NpcBasicModel;

    // 服务器存的值
    var level : Int = 1;
    var foreverLevel : Int = 0;
    var surplusSkillLeave : Int = 0;    ///< 剩余技能点数
    var speedLevel : Int = 1;
    var bloodLevel : Int = 1;
    var defenseLevel : Int = 1;
    var attackLevel : Int = 1;
    var isPerson = false;
    
    // 生成的值
    var attack: Double = 0;
    var defense: Double = 0;
    var blood: Double = 0;
    var currentBlood : Double = 0;
    var speed: Double = 0;
    var speedTime: Double = 0;
    var nextTime:Double = 0;
    
    //MARK: -
    
    // 更新/初始化数值
    func updateValues() -> Void {
        attack = countValue(base: basic.attackBase, growth: basic.attackGrowth, aLevel: attackLevel);
        
        defense = countValue(base: basic.defenseBase, growth: basic.defenseGrowth, aLevel: defenseLevel);
        
        blood = countValue(base: basic.bloodBase, growth: basic.bloodGrowth, aLevel: bloodLevel);
        currentBlood = blood;
        
        speed = countValue(base: basic.speedBase, growth: basic.speedGrowth, aLevel: speedLevel);
        
        speedTime = 1/speed;
        nextTime = speedTime;

        print("name:\(self.basic.name)");
        print("attack:\(attack)");
        print("defense:\(defense)");
        print("blood:\(blood)");
        print("speed:\(speed)");
        print("speedTime:\(speedTime)");
        
    }
    
    func countValue(base:Double , growth:Double ,aLevel:Int) -> Double {
        return base + growth * Double(foreverLevel+1) * Double(aLevel);
    }

    func attackNpc(_ npc:NpcModel) {
        let tmpBlood = attack - npc.defense;
        npc.currentBlood -= tmpBlood;

        print("\(npc.basic.name) : -\(tmpBlood) 剩余\(npc.currentBlood)");

        nextTime += speedTime;
    }
    
    init(basicName:String,dict:[String:Any]?,person:Bool?) {
        basic = NpcBasicModel.init(name:basicName);
        
        if dict != nil {
            // 服务器存的值
            level = dmInt(dict!["leave"]) ;
            foreverLevel = dmInt(dict!["foreverLevel"]);
            surplusSkillLeave = dmInt(dict!["surplusSkillLeave"]);    ///< 剩余技能点数
            speedLevel = dmInt(dict!["speedLevel"]);
            bloodLevel = dmInt(dict!["speedLevel"]);
            defenseLevel = dmInt(dict!["speedLevel"]);
            attackLevel = dmInt(dict!["speedLevel"]);
        }
        
        self.isPerson = person ?? false;
    }
}
