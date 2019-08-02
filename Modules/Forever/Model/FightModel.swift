//
//  FightModel.swift
//  Forever
//
//  Created by iMac-03 on 2019/8/1.
//  Copyright © 2019 daimu. All rights reserved.
//

import UIKit

class FightModel: NSObject {
    let name: String;
    let tmpBlood: Int;
    let currentBlood: Int;
    let blood:Int;
    
    init(name:String , tmp:Int , current:Int , all:Int) {
        self.name = name;
        self.tmpBlood = tmp;
        self.currentBlood = current;
        self.blood = all;
    }
}
