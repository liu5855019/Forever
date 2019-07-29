//
//  DMBaseModel.swift
//  IOffice_Swift
//
//  Created by iMac-03 on 2019/1/3.
//  Copyright © 2019 西安旺豆电子信息有限公司. All rights reserved.
//

import UIKit


func dmInt(_ value: Any?) -> Int {
    if value is Int {
        return value as! Int;
    } else {
        return 0;
    }
}

func dmString(_ value: Any?) -> String {
    if value is String {
        return value as! String;
    } else {
        return "";
    }
}

func dmDict(_ value: Any?) -> [String : Any] {
    if value is [String : Any] {
        return value as! [String : Any];
    } else {
        return [String:Any]();
    }
}

func dmArray(_ value: Any?) -> Array<Any> {
    if value is Array<Any> {
        return value as! Array<Any>;
    } else {
        return Array<Any>();
    }
}








class DMBaseModel: NSObject {

}
