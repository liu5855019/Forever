//
//  FightVC.swift
//  Forever
//
//  Created by iMac-03 on 2019/7/29.
//  Copyright © 2019 daimu. All rights reserved.
//

import UIKit


class FightVC: DMBaseViewController {

    let _sceneIV = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: kScreenH));
    let _timeLab = UILabel.init(frame: CGRect.init(x: kScreenW/2, y: 40, width: 50, height: 20));
    
    let _npc1 = NpcModel.init(basicName: "李逍遥", dict: nil, person: true);
    let _npc2 = NpcModel.init(basicName: "怪物1", dict: nil, person: false);
    
    lazy var _npcV1:NpcView = NpcView.init(frame: CGRect.init(x: 380, y: 90, width: 0, height: 0), npc:_npc1);
    lazy var _npcV2 = NpcView.init(frame: CGRect.init(x: 220, y: 90, width: 0, height: 0), npc:_npc2);
    
    let _beginTime = Date.init();
    lazy var _link = CADisplayLink.init(target: self, selector: #selector(fight));

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup();
        
        _link.add(to: RunLoop.current, forMode: RunLoop.Mode.common);
    }
    
    func setup() {
//        _sceneIV.image = UIImage.init(named:"scene_40");
        
        _timeLab.font = UIFont.boldSystemFont(ofSize: 18);
        _timeLab.textColor = UIColor.green;
        
        self.view.addSubview(_sceneIV);
        self.view.addSubview(_timeLab);
        self.view.addSubview(_npcV2);
        self.view.addSubview(_npcV1);
    }
    
    @objc func fight() {
        
        let time = Date.init().timeIntervalSince(_beginTime);
        
        _timeLab.text = "\(Int(time))";
    
        if time >= _npc1.nextTime {
            _npcV1.attackNpc(_npcV2);
        }
        if time >= _npc2.nextTime {
            _npcV2.attackNpc(_npcV1);
        }
        
//        print("Game over : \(loser?.name ?? "")");
    }
    
    

    

}
