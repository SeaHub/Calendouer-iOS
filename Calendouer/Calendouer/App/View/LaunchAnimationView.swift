//
//  LaunchAnimationView.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/4/18.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit
import SnapKit
import Lottie

class LaunchAnimationView: UIView {
    private let bakView: UIView = {
        let bakView: UIView = UIView(frame: UIScreen.main.bounds)
        bakView.backgroundColor = .white
        return bakView
    }()
    
    private let title_ch: UILabel = {
        let label = UILabel()
        label.text = "豆瓣日历"
        label.font = UIFont(name: "BodoniSvtyTwoITCTT-Bold", size: 18)
        label.textColor = DouGreen
        label.alpha = 0
        return label
    }()
    
    private let title_en: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "launch-text"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let animationView: LOTAnimationView = {
        let animation = LOTAnimationView.animationNamed("refresh-cal.json")
        return animation!
    }()
    
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        self.addSubview(bakView)
        self.bakView.addSubview(title_ch)
        self.bakView.addSubview(title_en)
        self.bakView.addSubview(animationView)
        
        setLayout()
        
    }
    
    private func setLayout() {
        
        bakView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
        }
        
        title_en.snp.makeConstraints { (make) in
            make.height.equalTo(18)
            make.width.equalTo(115)
            make.bottom.equalTo(self.bakView.snp.bottom).offset(-55)
            make.centerX.equalTo(self.bakView)
        }
        
        title_ch.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.bakView)
            make.bottom.equalTo(self.title_en.snp.top).offset(-10)
        }
        
        animationView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.bakView)
            make.bottom.equalTo(self.title_ch.snp.top).offset(-20)
            make.top.equalTo(self.bakView.snp.top)
            make.width.equalTo(self.bakView.snp.width)
        }
    }
    
    public func animationBegin() {
        self.animationView.play(completion: {finished in
            printLog(message: "animation end")
        })
        UIView.animate(withDuration: 0.6, delay: 2.5, options: .allowUserInteraction, animations: {
            self.alpha = 0
        }) { (finish) in
            
        }
    }
}
