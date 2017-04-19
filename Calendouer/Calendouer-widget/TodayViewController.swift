//
//  TodayViewController.swift
//  Calendouer-widget
//
//  Created by 段昊宇 on 2017/3/12.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit
import NotificationCenter

let groupIdentifier: String = "group.desgard.calendouer"

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialData()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
    private func initialData() {
        let shared: UserDefaults = UserDefaults(suiteName: "group.desgard.calendouer")!
        let status = shared.value(forKey: "status") as? String
        let degree = shared.value(forKey: "degree") as? String
        let city = shared.value(forKey: "city") as? String
        let image = shared.value(forKey: "image") as? String
        
        self.cityLabel.text = city ?? ""
        self.degreeLabel.text = degree ?? ""
        self.statusLabel.text = status ?? ""
        self.weatherImageView.image = UIImage(named: image ?? "")
    }
}
