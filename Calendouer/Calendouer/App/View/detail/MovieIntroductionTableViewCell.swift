//
//  MovieIntroductionTableViewCell.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/3/26.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit

class MovieIntroductionTableViewCell: UITableViewCell {

    @IBOutlet weak var ratingCardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var basicInfoLabel: UILabel!
    @IBOutlet weak var officalNameLabel: UILabel!
    @IBOutlet weak var releaseTimeLabel: UILabel!
    @IBOutlet weak var videoLenLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingCountLabel: UILabel!
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    private var starArray = [UIImageView]()
    
    var movie: MovieObject? {
        didSet {
            if let movie = movie {
                self.titleLabel.text = movie.title
                self.basicInfoLabel.text = movie.showType()
                self.officalNameLabel.text = "原名：\(NSString(string: movie.title))"
                self.releaseTimeLabel.text = "上映时间：\(NSString(string: movie.year))"
                self.videoLenLabel.text = "导演: \(NSString(string: movie.director))"
                self.ratingLabel.text = movie.rating
                self.setRatingStar(rating: NSString(string: movie.rating).doubleValue)
                self.ratingCountLabel.text = "\(movie.ratings_count) 人"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ratingCardView.layer.shadowColor = UIColor.black.cgColor
        ratingCardView.layer.shadowOffset = CGSize(width: 1, height: 1)
        ratingCardView.layer.shadowOpacity = 0.6
        ratingCardView.layer.shadowRadius = 4
        
        starArray.append(star1)
        starArray.append(star2)
        starArray.append(star3)
        starArray.append(star4)
        starArray.append(star5)
        
        for star in starArray {
            let starView: UIImageView = star
            starView.tintColor = DouStarYellow
        }
    }
    
    // 计算评分星级
    public func setRatingStar(rating: Double) {
        var index: Int = 0
        let score: Double = rating * 10
        let count: Int = Int(score) / 10
        let starCnt: Int = count / 2
        let halfStarCnt: Int = count % 2
        for _ in 0..<starCnt {
            let starView = starArray[index]
            starView.image = UIImage(named: "ca_star")
            index += 1
        }
        if halfStarCnt == 1 {
            let starView = starArray[index]
            starView.image = UIImage(named: "ca_star_half")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
