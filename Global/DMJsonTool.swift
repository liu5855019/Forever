//
//  DMJsonTool.swift
//  Forever
//
//  Created by iMac-03 on 2019/7/31.
//  Copyright © 2019 daimu. All rights reserved.
//

import UIKit

class DMJsonTool: NSObject {

    // JSONString转换为字典
    static func dictFromJson(_ jsonString:String) -> NSDictionary
    {
        let jsonData = jsonString.data(using: .utf8);
        
        if jsonData != nil {
            let dict = try? JSONSerialization.jsonObject(with: jsonData!, options: .mutableContainers);
            if dict != nil {
                return dict as! NSDictionary;
            }
        }
        
        return NSDictionary();
    }
    
    //JSONString转换为数组
    static func arrayFromJson(_ jsonString:String) ->NSArray {
        
        let jsonData = jsonString.data(using: .utf8)
        
        if jsonData != nil {
            let array = try? JSONSerialization.jsonObject(with: jsonData!, options: .mutableContainers)
            if array != nil {
                return array as! NSArray
            }
        }
        return []
    }


    /**
        字典/数组转换为JSONString
     */
    static func jsonStringFromDictOrArray(obj:Any) -> String {
        if (!JSONSerialization.isValidJSONObject(obj)) {
            print("无法解析出JSONString")
            return ""
        }
        
        let data = try? JSONSerialization.data(withJSONObject: obj, options: [])
        if data != nil {
            let JSONString = NSString(data:data! , encoding: String.Encoding.utf8.rawValue);
            if JSONString != nil {
                return JSONString! as String
            }
        }
        return "";
    }
}
