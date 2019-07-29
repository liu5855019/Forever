//
//  Person.swift
//  IOffice_Swift
//
//  Created by 西安旺豆电子信息有限公司 on 2018/3/7.
//  Copyright © 2018年 西安旺豆电子信息有限公司. All rights reserved.
//

import UIKit

class Person: NSObject {

    var name : String
    var age : Int
    var test : String?
    
    var birthYear: Int {
        get {
            return Date().year - age;
        }
        set {
            age = Date().year - newValue;
        }
    }
    
    var readonly: String {
        return "person";
    }
    
    
    
    override init() {
        name = "init";
        age = 0;
    }
    
    init(name:String) {
        self.name = name;
        age = 0;
    }
    
    
    
    override var description: String
    {
        return "\(name)\(age)";
    }
    
    class func think() -> String {
        return "person think"
    }
}
