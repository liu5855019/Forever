//
//  FightVC.swift
//  Forever
//
//  Created by iMac-03 on 2019/7/29.
//  Copyright © 2019 daimu. All rights reserved.
//

import UIKit


class FightVC: DMBaseViewController {

    let npc1 = NpcModel.init();
    let npc2 = NpcModel.init();

    override func viewDidLoad() {
        super.viewDidLoad()

        npc1.name = "正常";
    
        npc2.name = "一转";
        npc2.foreverLevel = 1;
        
        
        fight();
    }

    func fight() {
        npc1.updateValues();
        npc2.updateValues();

        var time:Double = 0;
        var gameover:Bool = false;
        var loser:NpcModel? = nil;

        while (!gameover) {
            time += 0.001;
            if time >= npc1.nextTime {
                npc1.attackNpc(npc2);
                if npc2.blood <= 0 {
                    gameover = true;
                    loser = npc2;
                    continue;
                }
            }
            if time >= npc2.nextTime {
                npc2.attackNpc(npc1);
                if npc1.blood <= 0 {
                    gameover = true;
                    loser = npc1;
                    continue;
                }
            }
        }
        
        print("Game over : \(loser?.name ?? "")");
    }
    
    

    

}
