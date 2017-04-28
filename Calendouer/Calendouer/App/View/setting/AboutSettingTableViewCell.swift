//
//  AboutSettingTableViewCell.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/4/28.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit

class AboutSettingTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func initialCell(title: String) {
        self.titleLabel.text = title
    }
}
