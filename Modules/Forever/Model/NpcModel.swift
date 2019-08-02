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
    var exp : Int = 0;
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

    // 攻击另一个 npc
    func attackNpc(_ npc:NpcModel) -> FightModel {
        var tmpBlood = attack - npc.defense;
        if tmpBlood < 1 {
            tmpBlood = 1;
        }
        
        npc.currentBlood -= tmpBlood;
        if npc.currentBlood < 0 {
            npc.currentBlood = 0;
        }
        nextTime += speedTime;
        
        return FightModel.init(name: npc.basic.name, tmp: Int(tmpBlood), current: Int(npc.currentBlood),all: Int(npc.blood));
    }
    
    // 加经验
    func addExp(exp:Int) {
        self.exp += exp;
        let needExp = self.getNeedExp();
        user.writeHero();
        
        if self.exp >= needExp {
            self.level += 1;
            if self.level > 100 {
                self.forever();
            } else {
                self.exp -= needExp;
                self.surplusSkillLeave += 4;
                self.attackLevel += 1;
                self.defenseLevel += 1;
                self.bloodLevel += 1;
                self.speedLevel += 1;
                user.writeHero();
                UIApplication.shared.keyWindow?.makeToast("恭喜升级!");
            }
        }
    }
    
    func getNeedExp() -> Int {
        var needExp = 0;
        for _ in 1...level {
            needExp += Int(1000 * (1.1 + 0.1*Double(foreverLevel)));
        }
        return needExp;
    }
    
    //转生
    func forever() {
        self.level = 1;
        self.foreverLevel += 1;
        self.surplusSkillLeave = 0;
        self.exp = 0;
 
        self.speedLevel = 1;
        self.bloodLevel = 1;
        self.defenseLevel = 1;
        self.attackLevel = 1;
        user.writeHero();
        UIApplication.shared.keyWindow?.makeToast("恭喜转生!");
    }
    
    
    init(basicName:String,dict:[String:Any]?,person:Bool?) {
        basic = NpcBasicModel.init(name:basicName);
        
        if dict != nil {
            // 服务器存的值
            level = dmInt(dict!["leave"]) ;
            foreverLevel = dmInt(dict!["foreverLevel"]);
            surplusSkillLeave = dmInt(dict!["surplusSkillLeave"]);    ///< 剩余技能点数
            speedLevel = dmInt(dict!["speedLevel"]);
            bloodLevel = dmInt(dict!["bloodLevel"]);
            defenseLevel = dmInt(dict!["defenseLevel"]);
            attackLevel = dmInt(dict!["attackLevel"]);
            exp = dmInt(dict!["exp"]);
        }
        
        self.isPerson = person ?? false;
        
        super.init();
    }
    
    func toDict() -> [String:Any] {
        return [
            "name":self.basic.name,
            "leave":level,
            "foreverLevel":foreverLevel,
            "surplusSkillLeave":surplusSkillLeave,
            "speedLevel":speedLevel,
            "bloodLevel":bloodLevel,
            "defenseLevel":defenseLevel,
            "attackLevel":attackLevel,
            "exp":exp
        ];
    }
}
