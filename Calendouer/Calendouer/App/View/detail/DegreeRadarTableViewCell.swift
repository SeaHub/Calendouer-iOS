//
//  DegreeRadarTableViewCell.swift
//  Calendouer
//
//  Created by Seahub on 2017/4/24.
//  Copyright © 2017年 Seahub. All rights reserved.
//

import UIKit

class DegreeRadarTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var lastUpdatedTimeLabel: UILabel!
    @IBOutlet weak var lastUpdatedDateLabel: UILabel!
    
    @IBOutlet weak var todayWeatherLabel: UILabel!
    @IBOutlet weak var todayWeatherImageView: UIImageView!
    @IBOutlet weak var todayTemperatureLabel: UILabel!
    @IBOutlet weak var todayWindLabel: UILabel!
    
    @IBOutlet weak var tomorrowWeatherImageView: UIImageView!
    @IBOutlet weak var tomorrowWeatherLabel: UILabel!
    
    @IBOutlet weak var twoDaysAfterWeatherImageView: UIImageView!
    @IBOutlet weak var twoDaysAfterWeatherLabel: UILabel!
    
    var weatherToday: WeatherObject? {
        didSet {
            if let weather = weatherToday {
                self.todayWeatherLabel.text       = weather.text_day
                self.todayWeatherImageView.image  = UIImage(named: weather.getWeatherIcon())
                self.todayTemperatureLabel.text   = "\(weather.high)°C | \(weather.low)°C"
                self.todayWindLabel.text          = "\(weather.wind_speed)kph \(weather.wind_direction)"
            }
        }
    }
    
    var weatherTomorrow: WeatherObject? {
        didSet {
            if let weather = weatherTomorrow {
                self.todayWeatherImageView.image  = UIImage(named: weather.getWeatherIcon())
                self.tomorrowWeatherLabel.text    = "\(weather.text_day) \(weather.high)°C | \(weather.low)°C"
            }
        }
    }
    
    var weatherTwoDaysAfter: WeatherObject? {
        didSet {
            if let weather = weatherTwoDaysAfter {
                self.twoDaysAfterWeatherImageView.image  = UIImage(named: weather.getWeatherIcon())
                self.twoDaysAfterWeatherLabel.text       = "\(weather.text_day) \(weather.high)°C | \(weather.low)°C"
            }
        }
    }
    
    public func configure(threeDaysWeathers weathers: [WeatherObject]) {
        if weathers.count > 2 {
            self.weatherToday        = weathers.first
            self.weatherTomorrow     = weathers[1]
            self.weatherTwoDaysAfter = weathers.last
            
            self.cityLabel.text            = self.weatherToday?.city
            self.lastUpdatedDateLabel.text = self.weatherToday?.date
            let updatedTimeStr             = self.weatherToday!.last_update
            let startIndex                 = updatedTimeStr.index(updatedTimeStr.startIndex, offsetBy: 11)
            let endIndex                   = updatedTimeStr.index(updatedTimeStr.endIndex, offsetBy: -6)
            let substringUpdatedTimeStr    = updatedTimeStr.substring(with: startIndex ..< endIndex)
            self.lastUpdatedTimeLabel.text = "更新: \(substringUpdatedTimeStr)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
