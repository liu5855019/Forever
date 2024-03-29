//
//  UserInfo.swift
//  IOffice_Swift
//
//  Created by 西安旺豆电子信息有限公司 on 2018/3/7.
//  Copyright © 2018年 西安旺豆电子信息有限公司. All rights reserved.
//


import UIKit

let kUserInfoFile = "UserInfo.data"
let kPointListFile = "PointList.data"
let kHeroListFile = "HeroList.data"


let user = UserInfo.shareUser


class UserInfo: NSObject , NSCoding {
    

    var name : String?
    
    var username : String?
    var password : String?
    var token : String?
    
    var money:Int64 = 0;
    
    var pointList:[GamePointModel]?
    var heroList:[NpcModel]?
    
    
    
//MARK: - INIT
    private override init() {}
    
    // {} 中间的只会在第一次调用shareUser的时候会调用
    // 并且遵循了dispatch_once  已经测试过
    static let shareUser: UserInfo = {
        let info = NSKeyedUnarchiver.unarchiveObject(withFile: getFilePath(file: kUserInfoFile)) as? UserInfo
        if (info != nil) {
            info?.initNpc();
            return info!
        } else {
            let tmpInfo = UserInfo();
            tmpInfo.initNpc()
            return tmpInfo
        }
    }()
    
    
    static func getFilePath(file:String) -> String {
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        path += "/\(file)"
        return path
    }

    func write() -> Void {
        let result = NSKeyedArchiver.archiveRootObject(user, toFile: UserInfo.getFilePath(file: kUserInfoFile))
        if result {
            print("write ok")
        } else {
            print("write error")
        }
    }
    
    
//MARK: - 归档解档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(username, forKey: "username");
        aCoder.encode(password, forKey: "password");
        aCoder.encode(token, forKey: "token");
        aCoder.encode(money,forKey: "money");
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.username = aDecoder.decodeObject(forKey: "username") as? String;
        self.password = aDecoder.decodeObject(forKey: "password") as? String;
        self.token = aDecoder.decodeObject(forKey: "token") as? String;
        self.money = aDecoder.decodeInt64(forKey: "money");
    }
    
    //MARK: - NPC
    
    func initNpc() {
        self.readPoints();
        self.readHero();
        
        if heroList?.count ?? 0 < 1 {
            heroList = [];
            heroList?.append(self.createHero(name: "李逍遥"));
            
            self.writeHero();
        }
        
        if pointList?.count ?? 0 < 1 {
            self.createPoints();
        }
        
    }
    
    func readPoints() {
        let npcPath = UserInfo.getFilePath(file: kPointListFile);
        
        let npcJson = try? String.init(contentsOfFile: npcPath);
        
        if npcJson != nil {
            let arr = DMJsonTool.arrayFromJson(npcJson!) as! [[String:Any]];
            
            var points:[GamePointModel] = [];
            for dict in arr {
                points.append(GamePointModel.init(dict: dict));
            }
            self.pointList = points;
        }
    }
    
    func readHero() {
        let heroPath = UserInfo.getFilePath(file: kHeroListFile);
        
        let json = try? String.init(contentsOfFile: heroPath);
        
        if json != nil {
            let arr = DMJsonTool.arrayFromJson(json!) as! [[String:Any]];
            
            var heros:[NpcModel] = [];
            for dict in arr {
                heros.append(NpcModel.init(basicName: dmString(dict["name"]), dict: dict, person: true));
            }
            self.heroList = heros;
        }
    }
    
    func writePoints() {
        let pointPath = UserInfo.getFilePath(file: kPointListFile);
        
        var pointDictList:[[String:Any]] = [];
        for point in self.pointList! {
            pointDictList.append(point.toDict());
        }
        
        let json = DMJsonTool.jsonStringFromDictOrArray(obj: pointDictList);
        
        if json.count > 0 {
            do {
                try json.write(toFile: pointPath, atomically: true, encoding: .utf8);
                print("关卡 写入成功");
            } catch {
                print(error);
                print("关卡 写入失败");
            }
        } else {
            print(json);
        }
    }
    
    func writeHero() {
        let heroPath = UserInfo.getFilePath(file: kHeroListFile);
        
        var heroDictList:[[String:Any]] = [];
        for hero in self.heroList! {
            heroDictList.append(hero.toDict());
        }
        
        let json = DMJsonTool.jsonStringFromDictOrArray(obj: heroDictList);
        
        if json.count > 0 {
            do {
                try json.write(toFile: heroPath, atomically: true, encoding: .utf8);
                print("hero 写入成功");
            } catch {
                print(error);
                print("hero 写入失败");
            }
        } else {
            print(json);
        }
    }
    
    func createHero(name:String) -> NpcModel {
        let npc = NpcModel.init(basicName: name, dict: nil, person: true);
        npc.surplusSkillLeave = 10;
        return npc;
    }
    
    func createPoints() {
        pointList = [];
        for i in 1...500 {
            let point = self.createGamePoint(point: i);
            pointList?.append(point);
        }
        self.writePoints();
    }
    
    func createGamePoint(point:Int) -> GamePointModel {
        
        let model = GamePointModel.init(dict: ["name":"怪物1"]);
        
        model.point = point;
        
        model.isOver = false;
        
        model.money = valueWith(num: point, base: 1000, growth: 5);
        model.exp = valueWith(num: point, base: 1000, growth: 2);
        
        model.npc.level = point;
        model.npc.attackLevel = point * 2;
        model.npc.defenseLevel = point * 2;
        model.npc.bloodLevel = point * 2;
        model.npc.speedLevel = point * 2;
    
        return model;
    }
    
    
    func valueWith(num:Int , base:Int , growth:Double) -> Int {
        
        var value = base;
        
        for _ in 1...num {
            value += Int(growth * Double(100));
        }
        
        let random = arc4random()%400;
        let scale = Double(random + 801)/1000.0;  // 0.8 ~ 1.2
        
        value = Int(scale * Double(value));

        return value;
    }
    
    
}
