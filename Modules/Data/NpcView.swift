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
    let img = UIImageView();
    let bloodV = UIProgressView();
    let bloodLab = UILabel();
    
    var model:NpcModel? = nil;
    
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 180));
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        nameLab.textColor = UIColor.green;
        nameLab.font = UIFont.systemFont(ofSize: 15);
        
        bloodLab.textColor = UIColor.red;
        bloodLab.font = UIFont.systemFont(ofSize: 15);
        
        bloodV.progressTintColor = UIColor.red;
        bloodV.trackTintColor = UIColor.lightGray;
        
    }
    
    func setupLayouts() {
        
        nameLab.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0);
        };
        
        bloodLab.snp.makeConstraints { (make) in
            make.top.equalTo(nameLab.snp.bottom).offset(2);
            make.left.right.equalTo(0);
        };
        
        bloodV.snp.makeConstraints { (make) in
            make.top.equalTo(bloodLab.snp.bottom).offset(2);
            make.height.equalTo(5);
            make.left.right.equalTo(0);
        };
        
    }

}
