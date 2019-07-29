//
//  NpcModel.swift
//  Forever
//
//  Created by iMac-03 on 2019/7/29.
//  Copyright © 2019 daimu. All rights reserved.
//

import UIKit

class NpcModel: NSObject {
    
    var name = "";
    
    // 攻击 , 防御 , 血量 , 攻速 , 等级 , 转生等级
    

    // 攻击
    var attackBase : Double = 15;
    var attackGrowth : Double = 1.5;
    var attackLevel : Int = 1;
    
    // 防御
    var defenseBase : Double = 12;
    var defenseGrowth : Double = 1.2;
    var defenseLevel : Int = 1;
    
    // 血量
    var bloodBase : Double = 100;
    var bloodGrowth : Double = 10;
    var bloodLevel : Int = 1;
    
    // 攻速
    var speedBase : Double = 0.666;
    var speedGrowth : Double = 0.07;
    var speedLevel : Int = 1;
    
    
    var level : Int = 1;
    var foreverLevel : Int = 0;
    
    
    var attack: Double = 0;
    var defense: Double = 0;
    var blood: Double = 0;
    var speed: Double = 0;
    var speedTime: Double = 0;
    var nextTime:Double = 0;
    
    func updateValues() -> Void {
        attack = countValue(base: attackBase, growth: attackGrowth, aLevel: attackLevel);
        
        defense = countValue(base: defenseBase, growth: defenseGrowth, aLevel: defenseLevel);
        
        blood = countValue(base: bloodBase, growth: bloodGrowth, aLevel: bloodLevel);
        
        speed = countValue(base: speedBase, growth: speedGrowth, aLevel: speedLevel);
        
        speedTime = 1/speed;
        nextTime = speedTime;

        print("name:\(name)");
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
        npc.blood = npc.blood - tmpBlood;

        print("\(npc.name) : -\(tmpBlood) 剩余\(npc.blood)");

        nextTime += speedTime;
    }
    
    
}
