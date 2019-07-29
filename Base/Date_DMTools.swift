//
//  File.swift
//  IOffice_Swift
//
//  Created by 西安旺豆电子信息有限公司 on 2018/3/7.
//  Copyright © 2018年 西安旺豆电子信息有限公司. All rights reserved.
//

import Foundation


let yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
let yyyyMMddHHmm = "yyyy-MM-dd HH:mm"
let yyyyMMdd = "yyyy-MM-dd"
let HHmmss = "HH:mm:ss"


extension Date
{
    var year: Int
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let date = formatter.string(from: self)
        return Int(date)!
    }
    
    func string(format:String) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    var detailString : String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = yyyyMMddHHmmss
        return formatter.string(from: self)
    }
    
    
}



