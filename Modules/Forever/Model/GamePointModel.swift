//
//  GamePointModel.swift
//  Forever
//
//  Created by iMac-03 on 2019/8/1.
//  Copyright © 2019 daimu. All rights reserved.
//

import UIKit

class GamePointModel: NSObject {

    var npc:NpcModel;
    
    //关卡
    var point:Int = 1;
    // 是否通关
    var isOver:Bool = false;
    
    var exp:Int = 1;
    
    var money:Int = 1;
    
    init(dict:[String:Any]) {
        self.npc = NpcModel.init(basicName: dmString(dict["name"]), dict: dict, person: false);
        
        point = dmInt(dict["point"]);
        isOver = dmBool(dict["isOver"]);
        exp = dmInt(dict["exp"]);
        money = dmInt(dict["money"]);
        
        super.init();
    }
    
    func toDict() -> [String:Any] {
        var dict = npc.toDict();
        
        dict["point"] = point;
        dict["isOver"] = isOver;
        dict["exp"] = exp;
        dict["money"] = money;
        
        return dict;
    }
}
