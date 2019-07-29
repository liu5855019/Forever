//
//  Son.swift
//  IOffice_Swift
//
//  Created by 西安旺豆电子信息有限公司 on 2018/3/7.
//  Copyright © 2018年 西安旺豆电子信息有限公司. All rights reserved.
//

import UIKit

class Son: Person {

    var sex :Bool;
    
    
    override init() {
        
        sex = true
        
        super.init()
        
        self.name = "bbb"
    }
    
    
    override var readonly: String
    {
        return "son"
    }
    
    override class func think() -> String{
        
        return "son think"
    }
    
    
}
