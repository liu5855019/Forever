//
//  File.swift
//  IOffice_Swift
//
//  Created by iMac-03 on 2018/12/28.
//  Copyright © 2018 西安旺豆电子信息有限公司. All rights reserved.
//

import Foundation
import UIKit

func imagesWithName(name:String,num:Int?) -> Array<UIImage> {
    var arr:[UIImage] = [];
    for i in 1...(num ?? 10) {
        let str = "\(name)_\(i)";
        let fileName = Bundle.main.path(forResource: str, ofType: "png");
        let img = UIImage.init(contentsOfFile: fileName ?? "");
        if (img != nil) {
            arr.append(img!);
        }
    }
    return arr;
}



