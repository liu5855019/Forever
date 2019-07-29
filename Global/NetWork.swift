//
//  UrlDefine.swift
//  IOffice_Swift
//
//  Created by iMac-03 on 2018/12/28.
//  Copyright © 2018 西安旺豆电子信息有限公司. All rights reserved.
//

import UIKit
import Alamofire


let kServerIP = "http://192.168.100.121:3000";

//let kServerIP = "http://47.105.171.135:3000";



let kRegistUrl = kServerIP + "/user/regist";
let kLoginUrl = kServerIP + "/user/login";

let kCreateRoleUrl = kServerIP + "/role/createRole";
let kGetRoleListUrl = kServerIP + "/role/roleList";

let kCreateCompanyUrl = kServerIP + "/dept/createCompany";
let kGetCompanyListUrl = kServerIP + "/dept/companyList";
let kCreateDeptUrl = kServerIP + "/dept/createDepartment";
let kGetDeptListUrl = kServerIP + "/dept/departmentList";

let kCreateModuleUrl = kServerIP + "/module/createModule";
let kGetModuleListUrl = kServerIP + "/module/moduleList";

let kCreateFlowUrl = kServerIP + "/flow/createFlow";
let kGetFlowListUrl = kServerIP + "/flow/flowList";

let kGetUserInfoUrl = kServerIP + "/userInfo/userInfo";
let kGetAccountListUrl = kServerIP + "/userInfo/accountList";
let kUpdateUserInfoUrl = kServerIP + "/userInfo/updateUserInfo";


func get(url:String,
         para:Parameters?,
         success:@escaping (_ result:Any) -> Void,
         failure:@escaping (_ err:Any ,_ code:Int , _ desc:String) -> Void) -> Void
{
    network(url: url,
            para: para,
            method: .get,
            encoding: URLEncoding.default,
            success: success,
            failure: failure);
}

func post(url:String,
          para:Parameters?,
          success:@escaping (_ result:Any) -> Void,
          failure:@escaping (_ err:Any ,_ code:Int , _ desc:String) -> Void) -> Void
{
    network(url: url,
            para: para,
            method: .post,
            encoding: JSONEncoding.default,
            success: success,
            failure: failure);
}

func network(url:String,
             para:Parameters?,
             method: HTTPMethod,
             encoding: ParameterEncoding,
             success:@escaping (_ result:Any) -> Void,
             failure:@escaping (_ err:Any ,_ code:Int , _ desc:String) -> Void) -> Void
{
    var headers : [String : String]? = nil;
    if user.token?.count ?? 0 > 0 {
        headers = ["token":user.token!];
    }
    
    request(url,
            method: method,
            parameters: para,
            encoding: encoding,
            headers: headers)
        .responseJSON(completionHandler: { (DataResponse) in
            switch DataResponse.result {
            case .success(let value) :
                print(value);
                if (DataResponse.response?.statusCode == 200) {
                    let dict = dmDict(value);
                    let code = dmInt(dict["code"]);
                    
                    if code == 401 {
                        DispatchQueue.main.async {
                            let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate;
                            delegate.animateLogout(true);
                        }
                    } else {
                        DispatchQueue.main.async {
                            success(value);
                        }
                    }
                    
                    
                } else {
                    DispatchQueue.main.async {
                        failure(value,(DataResponse.response?.statusCode)!,"");
                    }
                }
                break;
            case .failure(let err):
                //print(err);
                DispatchQueue.main.async {
                    failure(err,DataResponse.response?.statusCode ?? -1,err.localizedDescription);
                }
                break;
            }
        })
}






