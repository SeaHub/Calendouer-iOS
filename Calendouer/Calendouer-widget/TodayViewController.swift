//
//  TodayViewController.swift
//  Calendouer-widget
//
//  Created by 段昊宇 on 2017/3/12.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit
import NotificationCenter
import SDWebImage

let groupIdentifier: String = "group.desgard.calendouer"

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var airMsgsLabel: UILabel!
    @IBOutlet weak var airLabel: UILabel!
    
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var ablumImageView: UIImageView!
    
    @IBOutlet weak var lifeScoreTextLabel: UILabel!
    @IBOutlet weak var lifeScoreTitleLabel: UILabel!
    
    @IBOutlet weak var titleShowLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        initialData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func initialData() {
        let shared: UserDefaults = UserDefaults(suiteName: "group.desgard.calendouer")!
        let status      = shared.value(forKey: "status") as? String
        let degree      = shared.value(forKey: "degree") as? String
        let city        = shared.value(forKey: "city") as? String
        let image       = shared.value(forKey: "weather-img") as? String
        let air         = shared.value(forKey: "air-qlty") as? String
        let airMsgs     = shared.value(forKey: "air-msg") as? String
        let lifeScoreTitle = shared.value(forKey: "life-score-msg") as? String
        let lifeScoreDetail = shared.value(forKey: "life-score-detail") as? String
        let lifeScoreImage = shared.value(forKey: "life-score-image") as? String
        
        self.cityLabel.text = city ?? ""
        self.degreeLabel.text = degree ?? ""
        self.statusLabel.text = status ?? ""
        self.weatherImageView.image = UIImage(named: image ?? "")
        
        if air == "" || airMsgs == "" {
            self.airLabel.text =  ""
            self.airMsgsLabel.text =  ""
        } else {
            self.airLabel.text = air
            self.airMsgsLabel.text = airMsgs
        }
        self.ablumImageView.image = UIImage(named: lifeScoreImage ?? "")
        self.lifeScoreTitleLabel.text = lifeScoreTitle ?? ""
        self.lifeScoreTextLabel.text = lifeScoreDetail ?? ""
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        switch activeDisplayMode {
        case .compact:
            self.preferredContentSize = maxSize
            self.line.alpha = 0
            self.ablumImageView.alpha = 0
            self.lifeScoreTextLabel.alpha = 0
            self.lifeScoreTitleLabel.alpha = 0
            self.titleShowLabel.alpha = 0
        case .expanded:
            self.preferredContentSize = CGSize(width: UIScreen.main.bounds.size.width, height: 230)
            self.line.alpha = 1
            self.ablumImageView.alpha = 1
            self.lifeScoreTextLabel.alpha = 1
            self.lifeScoreTitleLabel.alpha = 1
            self.titleShowLabel.alpha = 1
        }
    }
}
