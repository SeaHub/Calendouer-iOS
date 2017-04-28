//
//  SettingViewController.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/3/6.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var titleBarButton: UIButton!
    
    let SettingSectionType: [String: Int] = [
        "WeatherSection": 0,
        "MovieSection": 1,
        "AboutSection": 2,
    ]
    
    let SettingWeatherCell: [String: Int] = [
        "FrequencyWeather": 1,
    ]
    
    let SettingMovieCell: [String: Int] = [
        "IrMovie": 1,
    ]
    
    let SettingAboutCell: [String: Int] = [
        "AboutApp": 1,
        "CommentApp": 2,
        "ShareApp": 3,
        "DevelopeApp": 4,
    ]
    
    let SectionHeaderHeight: CGFloat = 5
    let SectionFooterHeight: CGFloat = 5
    let Preferences = PreferenceManager.shared
    
    var userInfo: UserInfo = UserInfo()
    
    var tableView: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()
        addViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        self.titleBarButton.setTitleColor(.white, for: .normal)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "Ubuntu-Light", size: 17) ?? UIFont.systemFont(ofSize: 17),
            NSForegroundColorAttributeName: UIColor.white,
        ]
    }
    
    private func initialView() {
        view.backgroundColor = DouBackGray
        
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.grouped)
        tableView.backgroundColor = DouBackGray
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        
        // Table View Register
        tableView.register(UINib(nibName: SwitchSettingTableViewCellId, bundle: nil), forCellReuseIdentifier: SwitchSettingTableViewCellId)
        tableView.register(UINib(nibName: TextSettingTableViewCellId, bundle: nil), forCellReuseIdentifier: TextSettingTableViewCellId)
        tableView.register(UINib(nibName: TitleSettingTableViewCellId, bundle: nil), forCellReuseIdentifier: TitleSettingTableViewCellId)
        tableView.register(UINib(nibName: AboutSettingTableViewCellId, bundle: nil), forCellReuseIdentifier: AboutSettingTableViewCellId)
        
        // Userdefault
        let userInfo: UserInfo = Preferences[.userInfo]!
        self.userInfo = userInfo
        
        // Hide Model
        let thirdTap = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.thirdTap))
        thirdTap.numberOfTapsRequired = 3
        thirdTap.numberOfTouchesRequired = 1
        self.titleBarButton.addGestureRecognizer(thirdTap)
    }
    
    private func addViews() {
        view.addSubview(tableView)
    }
    
    public func thirdTap() {
        let debugin = DebugInViewViewController()
        navigationController?.pushViewController(debugin, animated: true)
    }

}

extension SettingViewController: UITableViewDelegate {
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 30
        }
        return 42
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.SettingSectionType.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case SettingSectionType["WeatherSection"]!:
            return SettingWeatherCell.count + 1
        case SettingSectionType["MovieSection"]!:
            return SettingMovieCell.count + 1
        case SettingSectionType["AboutSection"]!:
            return SettingAboutCell.count + 1
        default:
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SectionHeaderHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return SectionFooterHeight
    }
}

extension SettingViewController: UITableViewDataSource {
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case SettingSectionType["WeatherSection"]!:
            if indexPath.row == 0 {
                let cell: TitleSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: TitleSettingTableViewCellId, for: indexPath) as! TitleSettingTableViewCell
                cell.initialCell(title: "天气")
                cell.selectionStyle = .none
                return cell
            }
            else if indexPath.row == SettingWeatherCell["FrequencyWeather"]! {
                let cell: TextSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: TextSettingTableViewCellId, for: indexPath) as! TextSettingTableViewCell
                cell.initialCell(title: "推送频率", target: "3小时")
                return cell
            }
        case SettingSectionType["MovieSection"]!:
            if indexPath.row == 0 {
                let cell: TitleSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: TitleSettingTableViewCellId, for: indexPath) as! TitleSettingTableViewCell
                cell.initialCell(title: "电影")
                cell.selectionStyle = .none
                return cell
            }
            else if indexPath.row == SettingMovieCell["IrMovie"]! {
                let cell: SwitchSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: SwitchSettingTableViewCellId, for: indexPath) as! SwitchSettingTableViewCell
                cell.selectionStyle = .none
                cell.initialCell(title: "电影推送", status: self.userInfo.isReceiveMovie,  switchAction: { (status) in
                    self.userInfo.isReceiveMovie = status
                    self.Preferences[.userInfo] = self.userInfo
                })
                return cell
            }
        case SettingSectionType["AboutSection"]!:
            if indexPath.row == 0 {
                let cell: TitleSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: TitleSettingTableViewCellId, for: indexPath) as! TitleSettingTableViewCell
                cell.initialCell(title: "关于")
                cell.selectionStyle = .none
                return cell
            }
            else if indexPath.row == SettingAboutCell["AboutApp"] {
                let cell: AboutSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: AboutSettingTableViewCellId, for: indexPath) as! AboutSettingTableViewCell
                cell.initialCell(title: "关于")
                return cell
            }
            else if indexPath.row == SettingAboutCell["CommentApp"] {
                let cell: AboutSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: AboutSettingTableViewCellId, for: indexPath) as! AboutSettingTableViewCell
                cell.initialCell(title: "吐槽")

                return cell
            }
            else if indexPath.row == SettingAboutCell["ShareApp"] {
                let cell: AboutSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: AboutSettingTableViewCellId, for: indexPath) as! AboutSettingTableViewCell
                cell.initialCell(title: "支持")

                return cell
            }
            else if indexPath.row == SettingAboutCell["DevelopeApp"] {
                let cell: AboutSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: AboutSettingTableViewCellId, for: indexPath) as! AboutSettingTableViewCell
                cell.initialCell(title: "一起开发")
                return cell
            }
            
        default:
            break
        }
        let cell: TextSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: TextSettingTableViewCellId, for: indexPath) as! TextSettingTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case SettingSectionType["AboutSection"]!:
            if indexPath.row == SettingAboutCell["AboutApp"] {
                navigationController?.pushViewController(AboutAppViewController(), animated: true)
            }
            else if indexPath.row == SettingAboutCell["CommentApp"] {
                
            }
            else if indexPath.row == SettingAboutCell["ShareApp"] {
                navigationController?.pushViewController(AboutSupportViewController(), animated: true)
            }
            else if indexPath.row == SettingAboutCell["DevelopeApp"] {
            }
        default:
            break
        }
    }
}
