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
    
    let _expLab = UILabel.init(frame: CGRect.init(x:20,y: kScreenH-40,width: kScreenW,height: 20));
    let _expProgress = UIProgressView.init(frame: CGRect.init(x: 0, y: kScreenH-5, width: kScreenW, height: 5));
    
    
    let _hero: NpcModel;
    let _npc: NpcModel;
    let _point: GamePointModel;
    
    var _fightDatas:[FightModel] = [];
    var loser:NpcModel? = nil;
    
    lazy var _heroV:NpcView = NpcView.init(frame: CGRect.init(x: 420, y: 120, width: 0, height: 0), npc:_hero);
    lazy var _npcV = NpcView.init(frame: CGRect.init(x: 120, y: 40, width: 0, height: 0), npc:_npc);
    
    let _beginTime = Date.init();

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup();
        
        self.createFightDatas();
        
        self.perform(#selector(playFightDatas), with: nil, afterDelay: 1.5);
    }
    
    func setup() {
        _sceneIV.image = UIImage.init(named:"scene_40");
        
        _timeLab.font = UIFont.boldSystemFont(ofSize: 18);
        _timeLab.textColor = UIColor.green;
        
        _expLab.text = "\(_hero.exp) / \(_hero.getNeedExp())";
        _expLab.textColor = UIColor.green;
        _expLab.font = UIFont.systemFont(ofSize: 15);
        
        _expProgress.progressTintColor = UIColor.green;
        _expProgress.trackTintColor = UIColor.lightGray;
        _expProgress.progress = Float(_hero.exp) / Float(_hero.getNeedExp())
        
        
        self.view.addSubview(_sceneIV);
        self.view.addSubview(_timeLab);
        self.view.addSubview(_npcV);
        self.view.addSubview(_heroV);
        
        self.view.addSubview(_expLab);
        self.view.addSubview(_expProgress);
    }

    func createFightDatas() {
        _hero.updateValues();
        _npc.updateValues();
        
        var time:Double = 0;
        var gameover:Bool = false;
        
        
        while (!gameover) {
            time += 0.001;
            if time >= _hero.nextTime {
                self._fightDatas.append(_hero.attackNpc(_npc));
                if _npc.currentBlood <= 0 {
                    gameover = true;
                    loser = _npc;
                    continue;
                }
            }
            if time >= _npc.nextTime {
                self._fightDatas.append(_npc.attackNpc(_hero));
                if _hero.currentBlood <= 0 {
                    gameover = true;
                    loser = _hero;
                    continue;
                }
            }
        }
        
        print("Game over : \(loser?.basic.name ?? "")");
    }
    
    @objc func playFightDatas() {
        
        let time = Date.init().timeIntervalSince(_beginTime);
        _timeLab.text = "\(Int(time))";
        
        let fightModel = self._fightDatas.first;
        
        if fightModel != nil {
            self._fightDatas.removeFirst();
            self.perform(#selector(playFightDatas), with: nil, afterDelay: 1.5);
            
            if fightModel?.name == _hero.basic.name {
                _npcV.attackNpc(_heroV);
            } else {
                _heroV.attackNpc(_npcV);
            }
            self.perform(#selector(playRemoveBlood(fight:)), with: fightModel, afterDelay: 0.5);
        } else {
            if loser != _hero {
                //关卡通过
                self._point.isOver = true;
                user.writePoints();
                print("\(_point.point) : 已通过!");
                
                //经验增加
                self._hero.addExp(exp: self._point.exp);
                print("增加经验:\(_point.exp)");
                
                //给钱
                user.money += Int64(_point.money);
                user.write();
                
                UIApplication.shared.keyWindow?.makeToast(" 挑战\(_point.point) 成功! \n 增加经验:\(_point.exp) \n 增加金币:\(_point.money)");
                
                
            } else {
                print("\(_point.point) : 失败!");
                 UIApplication.shared.keyWindow?.makeToast(" 挑战\(_point.point) 失败!");
            }
            
            self.dismiss(animated: true, completion: nil);
        }
    }
    
    @objc func playRemoveBlood(fight:FightModel) {
        if fight.name == _hero.basic.name {
            _heroV.removeBlood(fight: fight);
        } else {
            _npcV.removeBlood(fight: fight);
        }
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
