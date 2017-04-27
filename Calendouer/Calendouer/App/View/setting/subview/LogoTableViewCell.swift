//
//  LogoTableViewCell.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/4/27.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit

class LogoTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        logoImage.layer.shadowOpacity = 0.5
        logoImage.layer.shadowColor = UIColor.black.cgColor
        logoImage.layer.shadowOffset = CGSize(width: 0, height: 2)
        logoImage.clipsToBounds = false
        
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
