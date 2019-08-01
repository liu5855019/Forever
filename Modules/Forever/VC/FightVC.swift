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
    
    let _hero: NpcModel;
    let _npc: NpcModel;
    let _point: GamePointModel;
    
    lazy var _npcV1:NpcView = NpcView.init(frame: CGRect.init(x: 380, y: 90, width: 0, height: 0), npc:_hero);
    lazy var _npcV2 = NpcView.init(frame: CGRect.init(x: 220, y: 90, width: 0, height: 0), npc:_npc);
    
    let _beginTime = Date.init();
    lazy var _link = CADisplayLink.init(target: self, selector: #selector(fight));

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup();
        
        self.createFightDatas();
        
//        _link.add(to: RunLoop.current, forMode: RunLoop.Mode.common);
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

//        if time >= _npc1.nextTime {
//            _npcV1.attackNpc(_npcV2);
//        }
//        if time >= _npc2.nextTime {
//            _npcV2.attackNpc(_npcV1);
//        }
        
//        print("Game over : \(loser?.name ?? "")");
    }
    
    func createFightDatas() {
        _hero.updateValues();
        _npc.updateValues();
        
        var time:Double = 0;
        var gameover:Bool = false;
        var loser:NpcModel? = nil;
        
        while (!gameover) {
            time += 0.001;
            if time >= _hero.nextTime {
                _hero.attackNpc(_npc);
                if _npc.currentBlood <= 0 {
                    gameover = true;
                    loser = _npc;
                    continue;
                }
            }
            if time >= _npc.nextTime {
                _npc.attackNpc(_hero);
                if _hero.currentBlood <= 0 {
                    gameover = true;
                    loser = _hero;
                    continue;
                }
            }
        }
        
        print("Game over : \(loser?.basic.name ?? "")");
    }
    
    
    init(person:NpcModel , point:GamePointModel) {
        
        self._hero = person;
        self._npc = point.npc;
        self._point = point;
        
        super.init(nibName: nil, bundle: nil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    

}
