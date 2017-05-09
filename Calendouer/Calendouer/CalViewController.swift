//
// CalViewController.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/3/2.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit
import Foundation
import SnapKit
import CoreLocation
import SwipeableTabBarController
import SDWebImage

class CalViewController: UIViewController {
    
    let bakView: UIView = {
        let bakView: UIView = UIView()
        bakView.backgroundColor = RGBA(r: 76, g: 175, b: 80, a: 1)
        bakView.layer.shadowColor = UIColor.gray.cgColor
        bakView.layer.shadowOffset = CGSize(width: 2, height: 2)
        bakView.layer.shadowOpacity = 0.4
        bakView.layer.shadowRadius = 2
        return bakView
    }()
    
    let monthLabel: UILabel = {
        let _label: UILabel = UILabel()
        _label.text = " "
        _label.textColor = .white
        _label.textAlignment = .left
        _label.font = DouDefalutFont
        return _label
    }()
    
    let weekdayLabel: UILabel = {
        let _label: UILabel = UILabel()
        _label.text = " "
        _label.textColor = .white
        _label.textAlignment = .center
        _label.font = DouDefalutFont
        return _label
    }()
    let weekdayView: UIView = UIView()
    
    let lunarLabel: UILabel = {
        let _label: UILabel = UILabel()
        _label.text = " "
        _label.textColor = .white
        _label.textAlignment = .right
        _label.font = DouDefalutFont
        _label.sizeToFit()
        return _label
    }()
    
    let dayLabel: UILabel = {
        let _label: UILabel = UILabel()
        _label.text = " "
        _label.textColor = .white
        _label.textAlignment = .center
        _label.font = DouCalendarFont
        _label.sizeToFit()
        return _label
    }()
    
    let cityLabel: UILabel = {
        let _label: UILabel = UILabel()
        _label.text = " "
        _label.textColor = .white
        _label.textAlignment = .right
        _label.font = DouDefalutFont
        return _label
    }()
    
    let updateTimeLabel: UILabel = {
        let _label: UILabel = UILabel()
        _label.text = " "
        _label.textColor = .white
        _label.textAlignment = .right
        _label.font = DouDefalutFont
        return _label
    }()
    
    let weatherLabel: UILabel = {
        let _label: UILabel = UILabel()
        _label.text = " "
        _label.textColor = .white
        _label.textAlignment = .left
        _label.font = DouDefalutFont
        return _label
    }()
    
    let degreeLabel: UILabel = {
        let _label: UILabel = UILabel()
        _label.text = " "
        _label.textColor = .white
        _label.textAlignment = .left
        _label.font = DouDefalutFont
        return _label
    }()
    
    let weatherImageView: UIImageView = {
        let _imageView: UIImageView = UIImageView(image: UIImage(named: "cloudy"))
        _imageView.contentMode = .scaleAspectFit
        return _imageView
    }()
    
    var tableView: UITableView = UITableView()
    
    // Location Manager
    let locationManager: CLLocationManager = CLLocationManager()
    var lock = NSLock()
    var currentLocation: CLLocation? = nil
    
    // Process Manager
    let process: ProcessManager = ProcessManager()
    var cardData: [NSObject] = []
    
    // Database Manager
    
    // Refresh Controller
    var refreshControl: UIRefreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        setNotification()
        initialView()
        addViews()
        settingLayout()
        setupData()
    }
    
    // User Default
    let Preferences = PreferenceManager.shared
    var userInfo: UserInfo = UserInfo()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        
        // 切换页面时刷新 tableView
        self.updateData {}
        setTabBarSwipe(enabled: false)
        
        // Animated
        Animated.getExplosion(view: self.weatherImageView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else if CLLocationManager.authorizationStatus() == .denied {
            
        } else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(toMoviePage(notification:)), name: NSNotification.Name(rawValue: "movie"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toWeatherDetail), name: NSNotification.Name(rawValue: "lifescore"), object: nil)
    }
    
    private func configureLocation() {
        let isLocationAlertViewControllerShown = "isLocationAlertViewControllerShown"
        guard UserDefaults.standard.object(forKey: isLocationAlertViewControllerShown) == nil
            || UserDefaults.standard.object(forKey: isLocationAlertViewControllerShown) as! Bool == false else {
            return
        }
        
        let alertController: UIAlertController = UIAlertController(title: "提示", message: "Calendouer 接下来将请求您的授权，获得在打开应用时使用地理位置的权限，否则本应用不能正常使用", preferredStyle: .alert)
        let cancelAction: UIAlertAction        = UIAlertAction(title: "确定", style: .cancel, handler: { [unowned self] _ in
            self.locationManager.requestWhenInUseAuthorization()
        })
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.present(alertController, animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: isLocationAlertViewControllerShown)
        }
    }
    
    private func initialView() {
        view.backgroundColor = DouBackGray
        
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.plain)
        tableView.backgroundColor = DouBackGray
        tableView.separatorColor = UIColor.clear
        tableView.dataSource = self
        tableView.delegate = self
        
        // Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.attributedTitle = NSAttributedString(string: "\u{1F680}")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        tableView.register(UINib(nibName: CardTableViewCellId, bundle: nil), forCellReuseIdentifier: CardTableViewCellId)
        tableView.register(UINib(nibName: DownloadCardTableViewCellId, bundle: nil), forCellReuseIdentifier: DownloadCardTableViewCellId)
        
        // Core Location
        locationManager.delegate        = self
        locationManager.distanceFilter  = kCLLocationAccuracyNearestTenMeters
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter  = 10000
        self.configureLocation()
        self.locationManager.startUpdatingLocation()
      
        // Userdefault
        let userInfo: UserInfo = Preferences[.userInfo]!
        self.userInfo = userInfo
    
        //
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toWeatherDetail))
        weatherImageView.isUserInteractionEnabled = true
        weatherImageView.addGestureRecognizer(tapGestureRecognizer)
        
        self.tabBarController?.tabBar.barTintColor = UIColor.white
        
    }
    
    private func addViews() {
        view.addSubview(tableView)
        view.addSubview(bakView)
        bakView.addSubview(monthLabel)
        bakView.addSubview(weekdayView)
        bakView.addSubview(weekdayLabel)
        bakView.addSubview(lunarLabel)
        bakView.addSubview(dayLabel)
        bakView.addSubview(cityLabel)
        bakView.addSubview(weatherLabel)
        bakView.addSubview(degreeLabel)
        bakView.addSubview(updateTimeLabel)
        bakView.addSubview(weatherImageView)
    }
    
    private func setupData() {
        self.cardData = []
        let isReceiveMovie = self.userInfo.isReceiveMovie
        let isCacheMovieList = self.userInfo.isCacheMovieList
        
        self.process.GetDay(Switch: true) { [unowned self](day) in
            self.monthLabel.changeText(data: day.getMonth())
            self.weekdayLabel.changeText(data: day.getWeekDay())
            self.lunarLabel.changeText(data: day.getLunnerDay())
            self.dayLabel.changeText(data: day.getDay())
        }
       
        if isReceiveMovie && isCacheMovieList {
            self.process.getMovieFromCache(Switch: true, handle: { [unowned self](movie) in
                self.cardData.append(movie)
                self.tableView.reloadData(animated: true)
            })
        }
        
        if isReceiveMovie && !isCacheMovieList {
            let card: BlankCardObject = BlankCardObject(type: .movie)
            self.cardData.append(card)
        }
    }
    
    public func updateData(handle: @escaping () -> Void) {
        
        let userInfo: UserInfo = Preferences[.userInfo]!
        self.userInfo = userInfo
        
        self.cardData = []
        let isReceiveMovie = self.userInfo.isReceiveMovie
        let isCacheMovieList = self.userInfo.isCacheMovieList
        
        if isReceiveMovie && isCacheMovieList {
            self.process.getMovieFromCache(Switch: true, handle: { [unowned self](movie) in
                self.cardData.append(movie)
                self.tableView.reloadData(animated: true)
                handle()
                return
            })
        }
        
        if isReceiveMovie && !isCacheMovieList {
            let card: BlankCardObject = BlankCardObject(type: .movie)
            self.cardData.append(card)
        }
        self.tableView.reloadData(animated: true)
        handle()
    }
    
    private func settingLayout() {
        bakView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(260)
        }
        weekdayView.snp.makeConstraints { (make) in
            make.top.equalTo(bakView.snp.top).offset(40)
            make.centerX.equalTo(bakView)
            make.width.equalTo(bakView).multipliedBy(0.5)
            make.height.equalTo(20)
        }
        weekdayLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(weekdayView)
            make.centerY.equalTo(monthLabel)
        }
        monthLabel.snp.makeConstraints { (make) in
            make.right.equalTo(weekdayView.snp.left).offset(-10)
            make.centerY.equalTo(weekdayView)
        }
        lunarLabel.snp.makeConstraints { (make) in
            make.left.equalTo(weekdayView.snp.right).offset(-20)
            make.centerY.equalTo(weekdayView)
        }
        dayLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(bakView)
            make.top.equalTo(weekdayLabel.snp.bottom).offset(15)
        }
        weatherImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(dayLabel)
            make.height.equalTo(40)
            make.bottom.equalTo(updateTimeLabel.snp.bottom)
        }
        cityLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dayLabel.snp.bottom)
            if kIsIPhone5Size {
                make.right.equalTo(weatherImageView.snp.left).offset(110)
            } else {
                make.right.equalTo(weatherImageView.snp.left).offset(105)
            }
        }
        updateTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cityLabel.snp.bottom).offset(15)
            make.right.equalTo(cityLabel.snp.right)
            if kIsIPhone5Size {
                make.right.equalTo(weatherImageView.snp.left).offset(110)
            } else {
                make.right.equalTo(weatherImageView.snp.left).offset(105)
            }
        }
        weatherLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(cityLabel)
            if kIsIPhone5Size {
                make.left.equalTo(weatherImageView.snp.right).offset(-110)
            } else {
                make.left.equalTo(weatherImageView.snp.right).offset(-105)
            }
        }
        degreeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(updateTimeLabel)
            make.left.equalTo(weatherLabel)
            if kIsIPhone5Size {
                make.left.equalTo(weatherImageView.snp.right).offset(-110)
            } else {
                make.left.equalTo(weatherImageView.snp.right).offset(-105)
            }
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(bakView.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.bottom.equalTo(view.snp.bottom)
            make.right.equalTo(view.snp.right)
        }
    }
    
    @objc private func refresh(sender: AnyObject) {
        self.updateData {
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc private func toWeatherDetail() {
        let weatherDetailViewController             = WeatherDetailViewController()
        weatherDetailViewController.currentLocation = self.currentLocation
        self.navigationController?.pushViewController(weatherDetailViewController, animated: true)
    }
    
    @objc func toMoviePage(notification: NSNotification) {
        let movieDetailVC = MovieDetailViewController()
        var movie = MovieObject(Dictionary: [:])
        if self.cardData.count > 0 {
            movie = self.cardData[0] as! MovieObject
        }
        movieDetailVC.movie = movie
        self.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}

extension CalViewController: UITableViewDelegate {
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardData.count
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let favorite = UITableViewRowAction(style: .normal, title: "\u{267A}") { action, index in
            printLog(message: "favorite button tapped")
        }
        favorite.backgroundColor = .clear
        UIButton.appearance().setTitleColor(.gray, for: .normal)
        
        return [favorite]
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
}

extension CalViewController: UITableViewDataSource {
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cardData.count > 0 {
            if cardData[indexPath.row].classForCoder == MovieObject.self {
                let cell: CardTableViewCell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCellId, for: indexPath) as! CardTableViewCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                let movie: MovieObject = self.cardData[indexPath.row] as! MovieObject
                cell.movie = movie
                return cell
            }
            else if cardData[indexPath.row].classForCoder == BlankCardObject.self {
                let cell: DownloadCardTableViewCell = tableView.dequeueReusableCell(withIdentifier: DownloadCardTableViewCellId, for: indexPath) as! DownloadCardTableViewCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.setProcessHandle(handle: { [unowned self]() -> Bool in
                    let result = true
                    self.process.cacheMovies(Switch: true, handle: { [unowned self](status) in
                        if status {
                            self.userInfo.isCacheMovieList = true
                            self.Preferences[.userInfo] = self.userInfo
                            self.updateData(handle: {
                            })
                        }
                    })
                    return result
                })
                return cell
            }
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if cardData[indexPath.row].classForCoder == MovieObject.self {
            let movieDetailVC = MovieDetailViewController()
            let movie: MovieObject = self.cardData[indexPath.row] as! MovieObject
            movieDetailVC.movie = movie
            self.navigationController?.pushViewController(movieDetailVC, animated: true)
        }
    }
    
}



// Shadow Changed Effect 
extension CalViewController: UIScrollViewDelegate {
    @available(iOS 2.0, *)
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y > 0) {
            let c: Float = 0.01
            if self.bakView.layer.shadowOpacity <= 0.8 {
                self.bakView.layer.shadowOpacity = 0.4 + Float(scrollView.contentOffset.y) * c
            }
        } else {
            self.bakView.layer.shadowOpacity = 0.4
        }
    }
}

// Core Location
extension CalViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lock.lock()
        if let currentLocation = locations.last {
            self.currentLocation = currentLocation
            printLog(message: "\(currentLocation.coordinate.latitude), \(currentLocation.coordinate.longitude)")
            let geocoder: CLGeocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(currentLocation, completionHandler: { (place, error) in
                if place != nil {
                    if let city = place?.last {
                        // 暂时更改 UI 方法
                        // TODO: 通用方法修改视图回调接口
                        let cityName = city.locality ?? ""
                        self.cityLabel.changeText(data: cityName)
                        
                        // 根据时间缓存判断是否更新天气
                        let last = self.userInfo.timestamp
                        let now = Int(Date().timeIntervalSince1970)
                        printLog (message: "时间戳 - Now: \(now) Last: \(last)")
                        
                        if last > 0 {
                            // 暂时设置为2小时
                            if now - last < 60 * 60 * 2 && self.userInfo.weatherMsg.count == 4{
                                printLog(message: "无需更新")
                                self.degreeLabel.text = self.userInfo.weatherMsg[0]
                                self.weatherLabel.text = self.userInfo.weatherMsg[1]
                                self.updateTimeLabel.text = self.userInfo.weatherMsg[2]
                                self.weatherImageView.image = UIImage(named: self.userInfo.weatherMsg[3])
                                return
                            }
                        }
                        
                        let la = currentLocation.coordinate.latitude
                        let lo = currentLocation.coordinate.longitude
                        self.process.GetWeather(Switch: true, latitude: CGFloat(la), longitude: CGFloat(lo), handle: { [unowned self](weather) in
                            self.degreeLabel.changeText(data: "\(weather.low)°C | \(weather.high)°C")
                            self.weatherLabel.changeText(data: "\(weather.text_day)，\(weather.text_night)")
                            self.updateTimeLabel.changeText(data: "更新：\(weather.last_update)")
                            self.weatherImageView.image = UIImage(named: weather.getWeatherIcon())
                            let weatherMsgs: Array<String> = [
                                "\(weather.low)°C | \(weather.high)°C",
                                "\(weather.text_day)，\(weather.text_night)",
                                "更新：\(weather.last_update)",
                                weather.getWeatherIcon(),
                            ]
                            self.userInfo.timestamp = now
                            self.userInfo.weatherMsg = weatherMsgs
                            self.Preferences[.userInfo] = self.userInfo
                            
                            // 更新 Widget
                            widgetHelper.shareDegree(low: weather.low, high: weather.high)
                            widgetHelper.shareStatus(text_day: weather.text_day, text_nigth: weather.text_night)
                            widgetHelper.shareCity(city: city.locality!)
                            widgetHelper.shareWeatherImg(image: weather.getWeatherIcon())
                        })
                        
                        self.process.GetAir(Switch: true, city: cityName, handle: { (air) in
                            // 更新 Widget
                            widgetHelper.shareAirQlty(air: air.qlty)
                            widgetHelper.shareAirMsgs(aqi: air.aqi, pm25: air.pm25)
                        })
                    }
                }
            })
        }
        self.locationManager.stopUpdatingHeading()
        lock.unlock()
    }
}
