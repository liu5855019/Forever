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
        
        self.addSubview(nameLab);
        self.addSubview(imgV);
        self.addSubview(bloodV);
        self.addSubview(bloodLab);
        
        nameLab.textColor = UIColor.green;
        nameLab.font = UIFont.systemFont(ofSize: 15);
        nameLab.textAlignment = NSTextAlignment.center;
        
        bloodLab.textColor = UIColor.red;
        bloodLab.font = UIFont.systemFont(ofSize: 15);
        bloodLab.textAlignment = NSTextAlignment.center;
        
        bloodV.progressTintColor = UIColor.red;
        bloodV.trackTintColor = UIColor.lightGray;
        
        imgV.animationRepeatCount = 1;
        imgV.animationDuration = 0.6;
        

        nameLab.text = _model.basic.name;
        bloodLab.text = "\(_model.currentBlood)/\(_model.blood)";
        bloodV.progress = Float(_model.currentBlood / _model.blood);
        
        let imgs = imagesWithName(name: _model.basic.imgName, num: 4);
        imgV.image = imgs.first;
        imgV.animationImages = imgs;
    }
    
    func setupLayouts() {
        
        nameLab.snp.makeConstraints { (make) in
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
        let newFrame = self._model.isPerson ? CGRect.init(x: 220, y: 90, width: self.frame.size.width, height: self.frame.size.height) : CGRect.init(x: 380, y: 90, width: self.frame.size.width, height: self.frame.size.height);

        self.imgV.startAnimating();
        UIView.animate(withDuration: 0.5, animations: {
//            self.frame = newFrame;
            
        }) { (complete) in
            if complete {
                UIView.animate(withDuration: 0.5, animations: {
                    //                self.frame = oldFrame;
                    npc.bloodV.progress = Float(npc._model.currentBlood / npc._model.blood);
                    npc.bloodLab.text = "\(Int(npc._model.currentBlood) )/\(Int(npc._model.blood))";
                })
            }
        }
        
        self._model.attackNpc(npc._model);
    }

}
