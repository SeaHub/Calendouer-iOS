//
//  MoviePostTableViewCell.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/3/25.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit

class MoviePostTableViewCell: UITableViewCell {

    @IBOutlet weak var bakView: UIView!
    @IBOutlet weak var ablumImage: UIImageView!
    
    private var handleAblum: (UIImage) -> Void = {_ in}
    
    var movie: MovieObject? {
        didSet {
            if let thisMovie = movie {
                self.ablumImage.sd_setImage(with: URL(string: thisMovie.images))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bakView.backgroundColor = DouGreen
        
        ablumImage.layer.shadowColor = UIColor.black.cgColor
        ablumImage.layer.shadowOffset = CGSize(width: 1, height: 1)
        ablumImage.layer.shadowOpacity = 0.8
        ablumImage.layer.shadowRadius = 4
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toWeatherDetail))
        ablumImage.isUserInteractionEnabled = true
        ablumImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func toWeatherDetail() {
        if let image = ablumImage.image {
            self.handleAblum(image)
        }
    }
    
    public func setAblumClickAction(callBack: @escaping (UIImage) -> Void) {
        self.handleAblum = callBack
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
