//
//  HeroListVC.swift
//  Forever
//
//  Created by iMac-03 on 2019/8/1.
//  Copyright © 2019 daimu. All rights reserved.
//

import UIKit

class HeroListVC: DMBaseViewController , UITableViewDataSource , UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "hero";
        
        self.view.addSubview(self.tabV);
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
        return user.heroList?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
        
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell");
        }
        
        cell?.textLabel?.text = user.heroList?[indexPath.row].basic.name;
        cell?.textLabel?.textColor = UIColor.black;
        
        var imgPaht = user.heroList?[indexPath.row].basic.imgName ?? "";
        imgPaht.append("_1.png");
        
        cell?.imageView?.image = UIImage.init(named: imgPaht);
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true);
        
        let vc = HeroDetailVC.init(model: (user.heroList?[indexPath.row])!);
    
        self.navigationController?.pushViewController(vc, animated: true);
    }
}
