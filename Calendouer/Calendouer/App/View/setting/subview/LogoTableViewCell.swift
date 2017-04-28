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
        
        initialAnimate()
    }
    
    private func initialAnimate() {
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(popForLogo))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        logoImage.isUserInteractionEnabled = true
        logoImage.addGestureRecognizer(singleTap)
    }
    
    @objc private func popForLogo() {
        self.logoImage.transform = self.logoImage.transform.scaledBy(x: 1.3, y: 1.3)
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.3, options: [], animations: {
            self.logoImage.transform = .identity
        }, completion: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
