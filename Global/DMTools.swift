//
//  DMTools.swift
//  IOffice_Swift
//
//  Created by 西安旺豆电子信息有限公司 on 2018/3/15.
//  Copyright © 2018年 西安旺豆电子信息有限公司. All rights reserved.
//

import UIKit

class DMTools: NSObject {

    private override init() {}
    
    //MARK: - Documents
    
    /** 给出文件名获得其在doc中的路径 */
    static func filePathInDocument(file:String) -> String
    {
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        path += "/\(file)"
        return path
    }
    
    /** 给出文件名获得其在Cache中的路径 */
    static func filePathInCaches(file:String) -> String
    {
        var path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
        path += "/\(file)"
        return path
    }
    
    /** 给出文件名获得其在Tmp中的路径 */
    static func filePathInTmp(file:String) -> String
    {
        var path = NSTemporaryDirectory()
        path += "\(file)"
        return path
    }
    
    
    //MARK: - AdjustScroll
    static func AdjustsScrollViewInsetNever(_ vc:UIViewController? , _ scrollView:UIScrollView)
    {
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never;
        } else {
            if (vc != nil) {
                vc?.automaticallyAdjustsScrollViewInsets = false;
            }
        }
    }
    
    
    
    
    //MARK: - JSON
    
//    static func jsonToObject(json:String) -> Any
//    {
//        let jsonStr = "[{\"name\":\"小炮\",\"age\":21},{\"name\":\"大头\",\"age\":21}]"
//        //转data
//        if let jsonData = jsonStr.data(using: .utf8){
//            //一：原生解析方法
//            //获取需要的内容，需要考虑数据是否存在，是否拆包
//            let dicArr = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [[String:AnyObject]]
//            print("打印所有数据:\(dicArr)")
//            let name = dicArr[0]["name"] as! String
//            print("原生获取name \(name)")
//            
////            //二：第三方SwiftyJSON解析，不许考虑拆包
////            let json = JSON(jsonData)
////            print("SwiftyJSON打印所有数据:\(json)")
////            if let sName = json[0]["name"].string{
////                print("SwiftyJSON获取name \(sName)")
////            }
//        }
//    }
//    
//    static func objectToJson(obj:Any) -> String
//    {
//        
//    }
}
