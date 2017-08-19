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
    fileprivate var pushingRateCell: TextSettingTableViewCell!
    fileprivate let pushingRatePickerBgView = UIView()
    fileprivate let pushingRatePickerView   = UIPickerView()
    
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
        "Develop": 4,
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
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
        
        // Pushing Rate Picker View
        self.pushingRatePickerView.delegate                = self
        self.pushingRatePickerView.dataSource              = self
        self.pushingRatePickerView.showsSelectionIndicator = false
    }
    
    private func addViews() {
        self.view.addSubview(self.tableView)
        self.pushingRatePickerBgView.addSubview(self.pushingRatePickerView)
        self.pushingRatePickerView.snp.makeConstraints { (make) in
            make.width.equalTo(self.pushingRatePickerBgView)
            make.top.equalTo(self.pushingRatePickerBgView).offset(44.0)
        }
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
                self.pushingRateCell = tableView.dequeueReusableCell(withIdentifier: TextSettingTableViewCellId, for: indexPath) as! TextSettingTableViewCell
                self.pushingRateCell.initialCell(title: "推送频率", target: "2小时")
                
                return self.pushingRateCell
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
            else if indexPath.row == SettingAboutCell["Develop"] {
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
        case SettingSectionType["WeatherSection"]!:
            if indexPath.row == SettingWeatherCell["FrequencyWeather"] {
                self.showPushingRatePickerViewInRow(cell: self.tableView.cellForRow(at: indexPath)!)
            }
        case SettingSectionType["AboutSection"]!:
            if indexPath.row == SettingAboutCell["AboutApp"] {
                navigationController?.pushViewController(AboutAppViewController(), animated: true)
            }
            else if indexPath.row == SettingAboutCell["CommentApp"] {
                let mailComposeViewController = emailHelper.configuredMailComposeViewController()
                if emailHelper.canSendMail() {
                    self.present(mailComposeViewController, animated: true, completion: {})
                } else {
                    emailHelper.showSendmailErrorAlert()
                }
            }
            else if indexPath.row == SettingAboutCell["ShareApp"] {
                navigationController?.pushViewController(AboutSupportViewController(), animated: true)
            }
            else if indexPath.row == SettingAboutCell["Develop"] {
                let url = "https://github.com/Desgard/Calendouer-iOS"
                UIApplication.shared.open(URL.init(string: url)!, options: [:], completionHandler: { (finished) in })
            }
        default:
            break
        }
    }
}

// MARK: Pushing Rate Picker
extension SettingViewController {
    fileprivate var pickerViewData: [String] {
        get {
            return ["2小时", "半天", "一天"]
        }
    }
    
    fileprivate func showPushingRatePickerViewInRow(cell: UITableViewCell) {
        guard (!self.tableView.subviews.contains(self.pushingRatePickerBgView)) else {
            self.removePickerBgViewWithAnimation()
            return
        }
        
        self.addPickerBgViewWithAnimation(view: cell)
    }
    
    fileprivate func addPickerBgViewWithAnimation(view: UIView) {
        self.pushingRatePickerBgView.backgroundColor    = DouBackGray
        self.pushingRatePickerBgView.alpha              = 0
        self.tableView.addSubview(self.pushingRatePickerBgView)
        UIView.animate(withDuration: 0.5) {
            self.pushingRatePickerBgView.alpha          = 1
        }
        
        self.pushingRatePickerBgView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.bottom).offset(10.0)
            make.width.equalTo(self.tableView.snp.width)
            make.height.equalTo(self.tableView.snp.height)
        }
    }
    
    fileprivate func removePickerBgViewWithAnimation() {
        UIView.animate(withDuration: 0.5, animations: {
            self.pushingRatePickerBgView.alpha          = 0
        }, completion: { _ in
            self.pushingRatePickerBgView.removeFromSuperview()
        })
    }
}

// MARK: Pushing Rate Picker Delegate
extension SettingViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = self.pickerViewData[row]
        return NSAttributedString(string: title, attributes:[NSForegroundColorAttributeName: DouGreen])
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44.0
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pushingRateCell.initialCell(title: "推送频率", target: "\(self.pickerViewData[row])")
        self.removePickerBgViewWithAnimation()
    }
}

// MARK: Pushing Rate Picker DataSource
extension SettingViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerViewData.count
    }
}
