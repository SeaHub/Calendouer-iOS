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
    var refreshButton: UIButton!
    var refreshBarButton: UIBarButtonItem!
    let userInfo                        = PreferenceManager.shared[.userInfo]!
    let process: ProcessManager         = ProcessManager()
    var weatherData: [WeatherObject]    = []
    var lifeScoreData: LifeScoreObject? = nil
    var currentLocation: CLLocation?    = nil
    
    // MARK: - View related -
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViews()
        addViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden            = true
        self.updateData()
    }

    private func initialViews() {
        self.title                = "\u{2600} 天气"
        self.view.backgroundColor = DouBackGray
        let barbak                = UIImage(color: DouGreen)
        self.navigationController?.navigationBar.setBackgroundImage(barbak, for: .default)
        
        tableView                          = UITableView(frame: view.bounds, style: UITableViewStyle.grouped)
        tableView.backgroundColor          = UIColor.clear
        tableView.separatorColor           = UIColor.clear
        tableView.estimatedRowHeight       = 30
        tableView.rowHeight                = 30
        tableView.rowHeight                = UITableViewAutomaticDimension
        tableView.dataSource               = self
        tableView.delegate                 = self
        tableView.allowsSelection          = false
        tableView.register(UINib(nibName: DegreeRadarTableViewCellId, bundle: nil),
                           forCellReuseIdentifier: DegreeRadarTableViewCellId)
        tableView.register(UINib(nibName: DegreeLifeTableViewCellId, bundle: nil),
                           forCellReuseIdentifier: DegreeLifeTableViewCellId)
        
        refreshButton       = UIButton(type: .custom)
        refreshButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let bgImage         = UIImage(named: "refresh")
        refreshBarButton    = UIBarButtonItem(customView: refreshButton)
        refreshButton.setBackgroundImage(bgImage, for: .normal)
        refreshButton.setBackgroundImage(bgImage, for: .highlighted)
        refreshButton.addTarget(self, action: #selector(updateData), for: .touchUpInside)
    }
    
    private func addViews() {
        view.addSubview(tableView)
        self.navigationItem.rightBarButtonItem = refreshBarButton
    }
    
    // MARK: - Data related -
    @objc private func updateData() {
        // Refresh button rotates
        UIView.animate(withDuration:0.5, animations: { () -> Void in
            self.refreshButton.transform = CGAffineTransform(rotationAngle: .pi)
        })
        
        // TODO: We should check network status here...
        
        UIView.animate(withDuration: 0.5, delay: 0.45, options: .curveEaseIn, animations: { () -> Void in
            self.refreshButton.transform = CGAffineTransform(rotationAngle: .pi * 2)
        }, completion: nil)
        
        // Update data from cache or network
        guard userInfo.isReceive3DayWeather else {
            return
        }
        
        // 12小时过期
        let kCacheExistedTimeout = 60 * 60 * 12
        guard userInfo.isCacheLifeScore
            && userInfo.isCache3DayWeather
            && userInfo.weatherDetailedCacheExistedTime > 0
            && userInfo.weatherDetailedCacheExistedTime < kCacheExistedTimeout else {
                
            self.updateDataFromNetwork { [unowned self] in
                self.cacheWriting {
                    printLog(message: "updateDataFromNetwork and cacheWriting now")
                }
            }
                
            return
        }
        
        self.updateDataFromCache {
            printLog(message: "updateDataFromCache")
        }
    }
    
    private func cacheWriting(handle: @escaping () -> Void) {
        userInfo.weatherDetailedTimestamp   = Int(Date().timeIntervalSince1970)
        userInfo._3DayWeather               = self.weatherData
        userInfo.isCache3DayWeather         = true
        userInfo.lifeScore                  = self.lifeScoreData ?? LifeScoreObject()
        userInfo.isCacheLifeScore           = true
        PreferenceManager.shared[.userInfo] = userInfo
        
        // TODO: widget data update
        
        handle()
    }
    
    private func updateDataFromCache(handle: @escaping () -> Void) {
        self.weatherData   = userInfo._3DayWeather
        self.lifeScoreData = userInfo.lifeScore
        
        self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0)], with: UITableViewRowAnimation.fade)
        handle()
    }
    
    private func updateDataFromNetwork(handle: @escaping () -> Void) {
        self.weatherData = []
        
        if let currentLocation = self.currentLocation {
            self.process.Get3DaysWeather(Switch: true,
                                         latitude: CGFloat(currentLocation.coordinate.latitude),
                                         longitude: CGFloat(currentLocation.coordinate.longitude)) {
                                            [unowned self](weathers) in
                                            
                self.weatherData = weathers
                self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: UITableViewRowAnimation.fade)
                                            
                self.process.GetLifeScore(Switch: true, city: (self.weatherData.first)!.city,
                                          handle: {
                                            [unowned self](lifeScore) in
                                            
                    self.lifeScoreData = lifeScore
                    self.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: UITableViewRowAnimation.fade)
                                            
                    handle()
                                            
                    // Widget 暂时
                    let (title, state, txt, img) = lifeScore.randomLifeScore()
                    widgetHelper.shareLifeScoreMsg(type: title, state: state)
                    widgetHelper.shareLifeScoreDetail(text: txt)
                    widgetHelper.shareLifeScoreImage(image: img)
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

// MARK: - UITableViewDelegate -
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

// MARK: - UITableViewDataSource -
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
