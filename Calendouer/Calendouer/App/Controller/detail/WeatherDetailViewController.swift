//
//  WeatherDetailViewController.swift
//  Calendouer
//
//  Created by Seahub on 2017/4/24.
//  Copyright © 2017年 Seahub. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherDetailViewController: UIViewController {
    var tableView: UITableView!
    let process: ProcessManager         = ProcessManager()
    var weatherData: [WeatherObject]    = []
    var lifeScoreData: LifeScoreObject? = nil
    var currentLocation: CLLocation?    = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViews()
        addViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden            = true
        self.updateData { }
    }

    private func initialViews() {
        self.title = "\u{2600} 天气"
        self.view.backgroundColor = DouBackGray
        
        let barbak = UIImage(color: DouGreen)
        self.navigationController?.navigationBar.setBackgroundImage(barbak, for: .default)
        
        tableView                 = UITableView(frame: view.bounds, style: UITableViewStyle.grouped)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor  = UIColor.clear
        
        tableView.estimatedRowHeight       = 30
        tableView.rowHeight                = 30
        tableView.rowHeight                = UITableViewAutomaticDimension
        tableView.dataSource               = self
        tableView.delegate                 = self
        tableView.allowsSelection          = false
        
        tableView.register(UINib(nibName: TitleSettingTableViewCellId, bundle: nil), forCellReuseIdentifier: TitleSettingTableViewCellId)
        tableView.register(UINib(nibName: DegreeRadarTableViewCellId, bundle: nil), forCellReuseIdentifier: DegreeRadarTableViewCellId)
        tableView.register(UINib(nibName: DegreeLifeTableViewCellId, bundle: nil), forCellReuseIdentifier: DegreeLifeTableViewCellId)
    }
    
    private func addViews() {
        view.addSubview(tableView)
    }
    
    // TODO: 缓存机制
    private func updateData(handle: @escaping () -> Void) {
        self.weatherData = []
        
        if let currentLocation = self.currentLocation {
            self.process.Get3DaysWeather(Switch: true,
                                         latitude: CGFloat(currentLocation.coordinate.latitude),
                                         longitude: CGFloat(currentLocation.coordinate.longitude)) { [unowned self](weathers) in
                self.weatherData = weathers
                self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: UITableViewRowAnimation.fade)
                                            
                self.process.GetLifeScore(Switch: true, city: (self.weatherData.first)!.city, handle: { [unowned self](lifeScore) in
                    self.lifeScoreData = lifeScore
                    self.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: UITableViewRowAnimation.fade)
                    handle()
                })
            }
            
        } else {
            printLog(message: "Can`t get user`s location")
            let alertVC      = UIAlertController(title: "提示", message: "本步骤需要使用定位信息，请打开定位后进行操作", preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel, handler: { (alert) in
                self.navigationController?.popToRootViewController(animated: true)
            })
            alertVC.addAction(cancelAction)
            self.present(alertVC, animated: true, completion:nil)
        }
    }
}

extension WeatherDetailViewController: UITableViewDelegate {
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
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
        if indexPath.row        == 0 {
            let cell: DegreeRadarTableViewCell = tableView.dequeueReusableCell(withIdentifier: DegreeRadarTableViewCellId, for: indexPath) as! DegreeRadarTableViewCell
            cell.configure(threeDaysWeathers: self.weatherData)
            return cell
        
        } else if indexPath.row == 1 {
            let cell: DegreeLifeTableViewCell  = tableView.dequeueReusableCell(withIdentifier: DegreeLifeTableViewCellId, for: indexPath)  as! DegreeLifeTableViewCell
            cell.configure(lifeScore: self.lifeScoreData)
            return cell
        
        } else {
            return UITableViewCell()
        }
    }
}
