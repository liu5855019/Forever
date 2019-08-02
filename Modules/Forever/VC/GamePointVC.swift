//
//  GamePointVC.swift
//  Forever
//
//  Created by iMac-03 on 2019/8/1.
//  Copyright © 2019 daimu. All rights reserved.
//

import UIKit

class GamePointVC: DMBaseViewController , UITableViewDelegate , UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tabV);
        
        var index = 0;
        for i in 0...(user.pointList?.count ?? 0) {
            if !(user.pointList?[i].isOver ?? false) {
                index = i;
                break;
            }
        }
        self.tabV.scrollToRow(at: IndexPath.init(row: index, section: 0), at: .middle, animated: false);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.tabV.reloadData();
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
        return _tabV;
    }();
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return user.pointList?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
        
        if cell == nil {
            cell = UITableViewCell.init(style: .value2, reuseIdentifier: "cell");
        }
        
        let point = user.pointList![indexPath.row];
        
        cell?.textLabel?.text = "\(point.point)";
        cell?.textLabel?.textColor = point.isOver ? UIColor.green : UIColor.black;
        
        cell?.detailTextLabel?.text = "money:\(point.money) --- exp:\(point.exp)";
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true);
        
        let backPoint = indexPath.row == 0 ? nil : user.pointList![indexPath.row-1];
        
        if backPoint == nil || backPoint?.isOver == true {
            let vc = FightVC.init(person: (user.heroList?.first)!, point: user.pointList![indexPath.row]);
            
            self.present(vc, animated: true, completion: nil);
        } else {
            self.view.makeToast("请先打通上一关");
        }
    }

}
