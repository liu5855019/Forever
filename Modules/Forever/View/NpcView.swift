//
//  NpcView.swift
//  Forever
//
//  Created by iMac-03 on 2019/7/29.
//  Copyright © 2019 daimu. All rights reserved.
//

import UIKit

class NpcView: UIView {

    let nameLab = UILabel();
    let imgV = UIImageView();
    let bloodV = UIProgressView();
    let bloodLab = UILabel();
    let levelLab = UILabel();
    
    var _model:NpcModel;
    
    
    init(frame: CGRect ,npc:NpcModel) {
        self._model = npc;
        npc.updateValues();
        
        super.init(frame: CGRect.init(x: frame.origin.x, y: frame.origin.y, width: 100, height: 180));
        
        self.setupViews();
        self.setupLayouts();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        self.addSubview(levelLab)
        self.addSubview(nameLab);
        self.addSubview(imgV);
        self.addSubview(bloodV);
        self.addSubview(bloodLab);
        
        
        levelLab.textColor = UIColor.green;
        levelLab.font = UIFont.systemFont(ofSize: 15);
        levelLab.textAlignment = NSTextAlignment.center;
        
        nameLab.textColor = UIColor.orange;
        nameLab.font = UIFont.systemFont(ofSize: 15);
        nameLab.textAlignment = NSTextAlignment.center;
        
        bloodLab.textColor = UIColor.red;
        bloodLab.font = UIFont.systemFont(ofSize: 15);
        bloodLab.textAlignment = NSTextAlignment.center;
        
        bloodV.progressTintColor = UIColor.red;
        bloodV.trackTintColor = UIColor.lightGray;
        
        imgV.animationRepeatCount = 1;
        imgV.animationDuration = 0.6;
        

        levelLab.text = "lv. \(_model.level)";
        nameLab.text = _model.basic.name;
        bloodLab.text = "\(_model.currentBlood)/\(_model.blood)";
        bloodV.progress = Float(_model.currentBlood / _model.blood);
        
        let imgs = imagesWithName(name: _model.basic.imgName, num: 4);
        imgV.image = imgs.first;
        imgV.animationImages = imgs;
    }
    
    func setupLayouts() {
        
        levelLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(0);
        };
        
        nameLab.snp.makeConstraints { (make) in
            make.top.equalTo(levelLab.snp.bottom).offset(2);
            make.left.right.equalTo(0);
        };
        
        bloodLab.snp.makeConstraints { (make) in
            make.top.equalTo(nameLab.snp.bottom).offset(2);
            make.left.right.equalTo(0);
            make.height.equalTo(15);
        };
        
        bloodV.snp.makeConstraints { (make) in
            make.top.equalTo(bloodLab.snp.bottom).offset(2);
            make.height.equalTo(5);
            make.left.right.equalTo(0);
        };
        
        imgV.snp.makeConstraints { (make) in
            make.top.equalTo(bloodV.snp.bottom).offset(2);
            make.left.bottom.right.equalTo(0);
        };
    }
    
    func attackNpc(_ npc:NpcView) {
        
        let oldFrame = self.frame;
        let newFrame = npc.frame;

        self.imgV.startAnimating();
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = newFrame;
            
        }) { (complete) in
            if complete {
                UIView.animate(withDuration: 0.5, animations: {
                    self.frame = oldFrame;
                })
            }
        }
    }
    
    func removeBlood(fight:FightModel) {
        
        self.bloodLab.text = "\(fight.currentBlood)/\(fight.blood)";
        
        let lab = UILabel.init(frame: CGRect.init(x: 0, y: 40, width: 100, height: 20));
        self.addSubview(lab);
        lab.textAlignment = .center;
        lab.textColor = UIColor.red;
        lab.font = UIFont.boldSystemFont(ofSize: 18);
        lab.text = "-\(fight.tmpBlood)";
        
        UIView.animate(withDuration: 0.5, animations: {
            self.bloodV.progress = Float(Double(fight.currentBlood) / Double(fight.blood));
            lab.frame = CGRect.init(x: 0, y: 0, width: 100, height: 20)
        }) { (complete) in
            lab.removeFromSuperview();
        }
    }
}
