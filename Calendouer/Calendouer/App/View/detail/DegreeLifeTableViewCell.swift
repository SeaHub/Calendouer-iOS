//
//  DegreeLifeTableViewCell.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/4/23.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit
import Charts

class DegreeLifeTableViewCell: UITableViewCell {

    @IBOutlet weak var bakView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension DegreeLifeTableViewCell: ChartViewDelegate {
    
}
