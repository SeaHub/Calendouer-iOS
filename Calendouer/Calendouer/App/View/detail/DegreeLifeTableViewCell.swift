//
//  DegreeLifeTableViewCell.swift
//  Calendouer
//
//  Created by Seahub on 2017/4/25.
//  Copyright © 2017年 Seahub. All rights reserved.
//

import UIKit

class DegreeLifeTableViewCell: UITableViewCell {
    let badColor    = DouRed
    let normalColor = UIColor.orange
    let goodColor   = DouGreen
    
    var lifeScoreData: LifeScoreObject? {
        didSet {
            if let lifeScore = lifeScoreData {
                self.airQuantityBriefLabel.text        = lifeScore.air_brf
                self.airQuantityDetailedLabel.text     = lifeScore.air_txt
                self.comfortQuantityBriefLabel.text    = lifeScore.comf_brf
                self.comfortQuantityDetailedLabel.text = lifeScore.comf_txt
                self.carWashingBriefLabel.text         = lifeScore.cw_brf
                self.carWashingDetailedLabel.text      = lifeScore.cw_txt
                self.clothesDressingBriefLabel.text    = lifeScore.drsg_brf
                self.clothesDressingDetailedLabel.text = lifeScore.drsg_txt
                self.coldCatchingBriefLabel.text       = lifeScore.flu_brf
                self.coldCatchingDetailedLabel.text    = lifeScore.flu_txt
                self.sportsDoingBriefLabel.text        = lifeScore.sport_brf
                self.sportsDoingDetailedLabel.text     = lifeScore.sport_txt
                self.travellingBriefLabel.text         = lifeScore.trav_brf
                self.travellingDetailedLabel.text      = lifeScore.trav_txt
                self.ultravioletBriefLabel.text        = lifeScore.uv_brf
                self.ultravioletDetailedLabel.text     = lifeScore.uv_txt
            }
        }
    }
    
    @IBOutlet weak var airQuantityDetailedLabel: UILabel!
    @IBOutlet weak var comfortQuantityDetailedLabel: UILabel!
    @IBOutlet weak var carWashingDetailedLabel: UILabel!
    @IBOutlet weak var clothesDressingDetailedLabel: UILabel!
    @IBOutlet weak var coldCatchingDetailedLabel: UILabel!
    @IBOutlet weak var sportsDoingDetailedLabel: UILabel!
    @IBOutlet weak var travellingDetailedLabel: UILabel!
    @IBOutlet weak var ultravioletDetailedLabel: UILabel!
    
    @IBOutlet weak var airQuantityBriefLabel: UILabel!
    @IBOutlet weak var comfortQuantityBriefLabel: UILabel!
    @IBOutlet weak var carWashingBriefLabel: UILabel!
    @IBOutlet weak var clothesDressingBriefLabel: UILabel!
    @IBOutlet weak var coldCatchingBriefLabel: UILabel!
    @IBOutlet weak var sportsDoingBriefLabel: UILabel!
    @IBOutlet weak var travellingBriefLabel: UILabel!
    @IBOutlet weak var ultravioletBriefLabel: UILabel!
    
    // Maybe there are better solutions??？
    private func updateTextColor() {
        self.airQuantityBriefLabel.textColor     = self.chooseColorByContent(self.airQuantityBriefLabel.text!,     badStrs: ["较差，很差"],              goodStrs: ["优"])
        self.comfortQuantityBriefLabel.textColor = self.chooseColorByContent(self.comfortQuantityBriefLabel.text!, badStrs: ["不舒适", "不宜"], goodStrs: ["舒适", "较舒适"])
        self.carWashingBriefLabel.textColor      = self.chooseColorByContent(self.carWashingBriefLabel.text!,      badStrs: ["不宜"],          goodStrs: ["较适宜"])
        self.clothesDressingBriefLabel.textColor = self.chooseColorByContent(self.clothesDressingBriefLabel.text!, badStrs: ["不舒适", "不宜"], goodStrs: ["较舒适", "舒适"])
        self.coldCatchingBriefLabel.textColor    = self.chooseColorByContent(self.coldCatchingBriefLabel.text!,    badStrs: ["易发"], goodStrs: ["少发"])
        self.sportsDoingBriefLabel.textColor     = self.chooseColorByContent(self.sportsDoingBriefLabel.text!,     badStrs: ["不宜"], goodStrs: ["较适宜", "适宜"])
        self.travellingBriefLabel.textColor      = self.chooseColorByContent(self.travellingBriefLabel.text!,      badStrs: ["不宜"], goodStrs: ["较适宜", "适宜"])
        self.ultravioletBriefLabel.textColor     = self.chooseColorByContent(self.ultravioletBriefLabel.text!,     badStrs: ["强", "最强"],    goodStrs: ["最弱", "弱"])
    }
    
    // Maybe there are better algorithm??？
    private func chooseColorByContent(_ contentStr: String, badStrs: [String], goodStrs: [String]) -> UIColor {
        for str in badStrs {
            if contentStr.contains(str) {
                return self.badColor;
            }
        }
        
        for str in goodStrs {
            if contentStr.contains(str) {
                return self.goodColor
            }
        }
        
        return self.normalColor
    }
    
    public func configure(lifeScore data: LifeScoreObject?) {
        if let data = data {
            self.lifeScoreData = data
            self.updateTextColor()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

