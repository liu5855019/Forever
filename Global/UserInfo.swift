//
//  UserInfo.swift
//  IOffice_Swift
//
//  Created by 西安旺豆电子信息有限公司 on 2018/3/7.
//  Copyright © 2018年 西安旺豆电子信息有限公司. All rights reserved.
//


import UIKit

let kUserInfoFile = "UserInfo.data"
let kNpcListFile = "NpcList.data"
let kHeroListFile = "HeroList.data"


let user = UserInfo.shareUser


class UserInfo: NSObject , NSCoding {
    

    var name : String?
    
    var username : String?
    var password : String?
    var token : String?
    
    var money:Int64 = 0;
    
    var npcList:[NpcModel]?
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
        self.readNpc();
        self.readHero();
        
        if heroList?.count ?? 0 < 1 {
            heroList = [];
            heroList?.append(self.createHero(name: "李逍遥"));
            
            self.writeHero();
        }
        
    }
    
    func readNpc() {
        let npcPath = UserInfo.getFilePath(file: kNpcListFile);
        
        let npcJson = try? String.init(contentsOfFile: npcPath);
        
        if npcJson != nil {
            let arr = DMJsonTool.arrayFromJson(npcJson!);
            for dict in arr {
                print(dict)
            }
            
        }
    }
    
    func readHero() {
        let heroPath = UserInfo.getFilePath(file: kHeroListFile);
        
        let json = try? String.init(contentsOfFile: heroPath);
        
        if json != nil {
            let arr = DMJsonTool.arrayFromJson(json!) as! [NSDictionary];
            
            var heros:[NpcModel] = [];
            for dict in arr {
                heros.append(NpcModel.init(basicName: dmString(dict["name"]), dict: dict as? [String : Any], person: true));
            }
            self.heroList = heros;
        }
    }
    
    func writeNpc() {
        
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
                print("写入成功");
            } catch {
                print(error);
                print("写入失败");
            }
        } else {
            print(json);
        }
    }
    
    func createHero(name:String) -> NpcModel {
        return NpcModel.init(basicName: name, dict: nil, person: true);
    }
    
//    func createGamePoint(<#parameters#>) -> <#return type#> {
//        <#function body#>
//    }
    
    
}
