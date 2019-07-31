//
//  HomeVC.swift
//  IOffice_Swift
//
//  Created by 呆木 on 2018/3/13.
//  Copyright © 2018年 西安旺豆电子信息有限公司. All rights reserved.
//

import UIKit

class HomeVC: DMBaseViewController , UITableViewDataSource , UITableViewDelegate {
    

    let datas = ["FightVC"
                 ];
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Home VC"
        
        print(user.name) ;
        
        self.setupViews()
    }
    
    func setupViews()
    {
        self.view.addSubview(tabV);
        
        self.navigationItem.rightBarButtonItem = self.rightItem;
    }
    
    
    
    lazy var rightItem: UIBarButtonItem = {
        var _rightItem = UIBarButtonItem.init(title: "退出", style: .done, target: self, action: #selector(clickRightItem));
        return _rightItem;
    }();
    
    @objc func clickRightItem()
    {
        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate;
        delegate.animateLogout(nil);
    }

    //MARK: - TABLEVIEW
    lazy var tabV: UITableView = {
        let _tabV = UITableView.init(frame: CGRect.init(x: 0, y: kNavHeight, width: kScreenW, height: kScreenH - kNavHeight - kSafeBottomHeight), style: .plain);
        DMTools.AdjustsScrollViewInsetNever(self, _tabV);
        _tabV.delegate = self;
        _tabV.dataSource = self;
        _tabV.estimatedRowHeight = 60;
        _tabV.rowHeight = UITableView.automaticDimension;
        _tabV.tableFooterView = UIView.init(frame: CGRect.zero);
        _tabV.separatorStyle = .singleLine;
        return _tabV;
    }();
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return datas.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
        
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell");
        }
        
        cell?.textLabel?.text = datas[indexPath.row];
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true);
        
        let str = (Bundle.main.infoDictionary!["CFBundleName"] ?? "") as! String  + "." + datas[indexPath.row];
        let cls : AnyClass? = NSClassFromString(str);
        if cls != nil {
            if cls is UIViewController.Type {
                let vcCls = cls as! UIViewController.Type;
                let vc = vcCls.init();
                self.navigationController?.pushViewController(vc, animated: true);
            }
        }
        
        
    }
    
    
    var nums : [Int] = [];
    
    func test() {
        test2()
        test3()
        test4()
        test5()
        test6()
        test7()
        test8()
        test9()
    }
    
    func test2() {
        for num:Int in 1...10000 {
            let v = num % 2;
            if (v == 1) {
                nums.append(num);
            }
        }
        print(nums);
    }
    
    func test3() {
        var muarr : [Int] = [];
        for num:Int in nums {
            let v = num % 3;
            if (v == 0) {
                muarr.append(num);
            }
        }
        nums = muarr;
        print(nums);
    }
    func test4() {
        var muarr : [Int] = [];
        for num:Int in nums {
            let v = num % 4;
            if (v == 1) {
                muarr.append(num);
            }
        }
        nums = muarr;
        print(nums);
    }
    func test5() {
        var muarr : [Int] = [];
        for num:Int in nums {
            let v = num % 5;
            if (v == 4) {
                muarr.append(num);
            }
        }
        nums = muarr;
        print(nums);
    }
    
    func test6() {
        var muarr : [Int] = [];
        for num:Int in nums {
            let v = num % 6;
            if (v == 3) {
                muarr.append(num);
            }
        }
        nums = muarr;
        print(nums);
    }
    
    func test7() {
        var muarr : [Int] = [];
        for num:Int in nums {
            let v = num % 7;
            if (v == 0) {
                muarr.append(num);
            }
        }
        nums = muarr;
        print(nums);
    }
    func test8() {
        var muarr : [Int] = [];
        for num:Int in nums {
            let v = num % 8;
            if (v == 1) {
                muarr.append(num);
            }
        }
        nums = muarr;
        print(nums);
    }
    
    func test9() {
        var muarr : [Int] = [];
        for num:Int in nums {
            let v = num % 9;
            if (v == 0) {
                muarr.append(num);
            }
        }
        nums = muarr;
        print(nums);
    }
    
    
   
    
    
    
    
    
    
    

}
