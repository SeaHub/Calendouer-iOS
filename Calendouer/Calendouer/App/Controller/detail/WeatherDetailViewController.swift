//
//  WeatherDetailViewController.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/4/21.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    var tableView: UITableView!
    let titleData = [
        "未来三日温度",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViews()
        addViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func initialViews() {
        self.title = "\u{2600} 天气"
        self.view.backgroundColor = DouBackGray
        
        let barbak = UIImage(color: DouGreen)
        self.navigationController?.navigationBar.setBackgroundImage(barbak, for: .default)
        
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.grouped)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.clear
        
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = 30
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: TitleSettingTableViewCellId, bundle: nil), forCellReuseIdentifier: TitleSettingTableViewCellId)
    }
    
    private func addViews() {
        view.addSubview(tableView)
    }
}

extension WeatherDetailViewController: UITableViewDelegate {
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

extension WeatherDetailViewController: UITableViewDataSource {
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}
