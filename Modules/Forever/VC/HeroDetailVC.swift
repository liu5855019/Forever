//
//  HeroDetailVC.swift
//  Forever
//
//  Created by iMac-03 on 2019/8/1.
//  Copyright © 2019 daimu. All rights reserved.
//

import UIKit

class HeroDetailVC: DMBaseViewController {
    
    var hero:NpcModel;
    
    init(model:NpcModel) {
        self.hero = model;
        super.init(nibName: nil, bundle: nil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var leaveLab: UILabel!
    @IBOutlet weak var foreverLeaveLab: UILabel!
    @IBOutlet weak var currentExp: UILabel!
    @IBOutlet weak var needExp: UILabel!
    
    
    @IBOutlet weak var surplusSkill: UILabel!
    
    @IBOutlet weak var attackLeaveLab: UILabel!
    @IBOutlet weak var defenseLeaveLab: UILabel!
    @IBOutlet weak var bloodLeaveLab: UILabel!
    @IBOutlet weak var speedLeaveLab: UILabel!
    
    
    @IBOutlet weak var attackLab: UILabel!
    @IBOutlet weak var defenseLab: UILabel!
    @IBOutlet weak var bloodLab: UILabel!
    @IBOutlet weak var speedLab: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgV.image = UIImage.init(named: hero.basic.imgName.appending("_1.png"));
        nameLab.text = hero.basic.name;
        leaveLab.text = "\(hero.level)";
        foreverLeaveLab.text = "\(hero.foreverLevel)";
        currentExp.text = "\(hero.exp)";
        needExp.text = "\(hero.getNeedExp())";
        
        self.updateValues();
    }
    
    func updateValues() {
        
        hero.updateValues();
        
        surplusSkill.text = "\(hero.surplusSkillLeave)";
        
        attackLeaveLab.text = "\(hero.attackLevel)";
        defenseLeaveLab.text = "\(hero.defenseLevel)";
        bloodLeaveLab.text = "\(hero.bloodLevel)";
        speedLeaveLab.text = "\(hero.speedLevel)";
        
        attackLab.text = "\(hero.attack)";
        defenseLab.text = "\(hero.defense)";
        bloodLab.text = "\(hero.blood)";
        speedLab.text = "\(hero.speed)";
        
    }


    @IBAction func attackAction(_ sender: Any) {
        if hero.surplusSkillLeave > 0 {
            hero.surplusSkillLeave -= 1;
            hero.attackLevel += 1;
            self.updateValues();
            user.writeHero();
        }
    }
    
    @IBAction func defenseAction(_ sender: Any) {
        if hero.surplusSkillLeave > 0 {
            hero.surplusSkillLeave -= 1;
            hero.defenseLevel += 1;
            self.updateValues();
            user.writeHero();
        }
    }
    
    @IBAction func bloodAction(_ sender: Any) {
        if hero.surplusSkillLeave > 0 {
            hero.surplusSkillLeave -= 1;
            hero.bloodLevel += 1;
            self.updateValues();
            user.writeHero();
        }
    }
    
    @IBAction func speedAction(_ sender: Any) {
        print("speed");
        if hero.surplusSkillLeave > 0 {
            hero.surplusSkillLeave -= 1;
            hero.speedLevel += 1;
            self.updateValues();
            user.writeHero();
        }
    }
    

}
