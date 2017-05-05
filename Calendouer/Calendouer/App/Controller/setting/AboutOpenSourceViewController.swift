//
//  AboutOpenSourceViewController.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/4/27.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit

class AboutOpenSourceViewController: UIViewController {
    
    var tableView: UITableView!
    let repoDatas: [String] = [
        "SDWebImage",
        "SnapKit",
        "Alamofire",
        "SwiftyJSON",
        "lottie-ios",
        "TKSwitcherCollection",
        "Agrume",
    ]
    
    let urlDatas: [String] = [
        "https://github.com/rs/SDWebImage",
        "https://github.com/SnapKit/SnapKit",
        "https://github.com/Alamofire/Alamofire",
        "https://github.com/SwiftyJSON/SwiftyJSON",
        "https://github.com/airbnb/lottie-ios",
        "https://github.com/TBXark/TKSwitcherCollection",
        "https://github.com/JanGorman/Agrume",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        initialDatas()
        initialViews()
        addViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "Ubuntu-Light", size: 17) ?? UIFont.systemFont(ofSize: 17),
            NSForegroundColorAttributeName: UIColor.white,
        ]
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func initialDatas() {
        
    }
    
    private func initialViews() {
        view.backgroundColor = DouBackGray
        
        title = "开源协议"
        
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.grouped)
        tableView.backgroundColor = DouBackGray
        tableView.separatorColor = .clear
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: LogoTableViewCellId, bundle: nil), forCellReuseIdentifier: LogoTableViewCellId)
        tableView.register(UINib(nibName: TitleSettingTableViewCellId, bundle: nil), forCellReuseIdentifier: TitleSettingTableViewCellId)
        tableView.register(UINib(nibName: TextSettingTableViewCellId, bundle: nil), forCellReuseIdentifier: TextSettingTableViewCellId)
    }
    
    private func addViews() {
        view.addSubview(tableView)
    }
}

extension AboutOpenSourceViewController: UITableViewDelegate {
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + self.repoDatas.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

extension AboutOpenSourceViewController: UITableViewDataSource {
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: LogoTableViewCell = tableView.dequeueReusableCell(withIdentifier: LogoTableViewCellId, for: indexPath) as! LogoTableViewCell
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.row == 1 {
            let cell: TitleSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: TitleSettingTableViewCellId, for: indexPath) as! TitleSettingTableViewCell
            cell.initialCell(title: "感谢以下开源项目提供的帮助")
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell: TextSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: TextSettingTableViewCellId, for: indexPath) as! TextSettingTableViewCell
            cell.initialCell(title: self.repoDatas[indexPath.row - 2], target: "")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 || indexPath.row == 1 {
            return
        }
        else {
            let url = self.urlDatas[indexPath.row - 2]
            UIApplication.shared.open(URL.init(string: url)!, options: [:], completionHandler: { (finished) in })
        }
    }
}
