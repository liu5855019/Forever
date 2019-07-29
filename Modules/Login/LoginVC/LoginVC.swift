//
//  LoginVC.swift
//  IOffice_Swift
//
//  Created by 西安旺豆电子信息有限公司 on 2018/3/7.
//  Copyright © 2018年 西安旺豆电子信息有限公司. All rights reserved.
//

import UIKit
import SnapKit
import PKHUD

class LoginVC: DMBaseViewController {

  
    let unameTF = UITextField();
    let pwdTF   = UITextField();
    let loginBtn = UIButton();


    //MARK: - SETUP
    override func viewDidLoad()
    {
        super.viewDidLoad();
        
        self.navigationController?.navigationBar.isHidden = true;
        
        self.view.backgroundColor = UIColor.orange;
        
        setupViews();
        setupLayouts();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.navigationController?.navigationBar.isHidden = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.navigationController?.navigationBar.isHidden = false;
    }
    
    func setupViews()
    {

        self.view.addSubview(unameTF)
        self.view.addSubview(pwdTF)
        self.view.addSubview(loginBtn)

        
     
        unameTF.textColor = UIColor.white
        unameTF.placeholder = "请输入账号"
        unameTF.font = UIFont.systemFont(ofSize: kScaleW(17))
        unameTF.textAlignment = NSTextAlignment.center
        unameTF.setValue(UIColor.white.withAlphaComponent(0.5), forKeyPath: "_placeholderLabel.textColor")
        
        
        
        pwdTF.textColor = UIColor.white
        pwdTF.placeholder = "请输入密码"
        pwdTF.font = UIFont.systemFont(ofSize: kScaleW(17))
        pwdTF.textAlignment = NSTextAlignment.center
        pwdTF.setValue(UIColor.white.withAlphaComponent(0.5), forKeyPath: "_placeholderLabel.textColor")
        pwdTF.isSecureTextEntry = true
        
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setBackgroundImage(UIImage.init(named: "login_loginbtn_bg.png"), for: .normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: kScaleW(17))
        loginBtn.addTarget(self, action:#selector(clickLoginBtn) , for: .touchUpInside)
        

        unameTF.text = user.username;
    }

    func setupLayouts()
    {
        unameTF.snp.makeConstraints { (make) in
            make.top.equalTo(64)
            make.left.equalTo(kScaleW(30))
            make.right.equalTo(kScaleW(-30))
            make.height.equalTo(kScaleW(44))
        }
        unameTF.layer.cornerRadius = 22
        unameTF.layer.borderColor = UIColor.white.cgColor
        unameTF.layer.borderWidth = 1
        
        pwdTF.snp.makeConstraints { (make) in
            make.top.equalTo(unameTF.snp.bottom).offset(kScaleW(30))
            make.left.equalTo(kScaleW(30))
            make.right.equalTo(kScaleW(-30))
            make.height.equalTo(44)
        }
        pwdTF.layer.cornerRadius = 22
        pwdTF.layer.borderColor = UIColor.white.cgColor
        pwdTF.layer.borderWidth = 1
        
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(pwdTF.snp.bottom).offset(kScaleW(44))
            make.left.equalTo(kScaleW(30))
            make.right.equalTo(kScaleW(-30))
            make.height.equalTo(44)
        }
    }
    
//MARK: - ACTIONS
    @objc func clickLoginBtn() -> Void
    {
        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate;
        delegate.login();
    }
    
    
   
    
    
//MARK: - NET
    
    func login(uname:String,pwd:String)
    {
        HUD.show(.systemActivity, onView: self.view);
        
        let para : [String:Any] = [
            "username":uname,
            "password":pwd
        ];
        
        print(para);
        post(url: kLoginUrl, para: para, success: {[weak self] (value) in
            print(value);
            let dict = dmDict(value);
            let code = dmInt(dict["code"]);
            
            if (code == 200) {
                user.username = uname;
                user.password = pwd;
                
                let objDict = dmDict(dict["obj"]);
                user.token = dmString(objDict["token"]);
                
                user.write();
                
                let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate;
                delegate.login();
            } else {
                self?.view.makeToast(dmString(dict["msg"]));
            }
            HUD.hide();
        }) { (err, code, desc) in
            print(desc);
            HUD.hide();
        }
    }
}



