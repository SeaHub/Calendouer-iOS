//
//  AboutTextTableViewCell.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/4/27.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit

class AboutTextTableViewCell: UITableViewCell {
    
    var toSupportPage: () -> Void = {}
    var toOpenSourcePage: () -> Void = {}
    
    @IBOutlet weak var aboutLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        initialViews()
    }
    
    private func initialViews() {
        let attriStr = NSMutableAttributedString()
        let name = "Calendouer"
        let introduce = aboutLabel.text
        let email = " gua@desgard.com\n"
        
        attriStr.mutableString.append(name)
        attriStr.mutableString.append(introduce!)
        attriStr.mutableString.append(email)
        
        attriStr.addAttribute(NSForegroundColorAttributeName,
                              value: DouGreen,
                              range: NSMakeRange(0, name.length))
        attriStr.addAttribute(NSForegroundColorAttributeName,
                              value: UIColor.black,
                              range: NSMakeRange(name.length, attriStr.mutableString.length - name.length))
        attriStr.addAttribute(NSFontAttributeName,
                              value: UIFont.init(name: "LithosPro-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14),
                              range: NSMakeRange(0, name.length))
        attriStr.addAttribute(NSFontAttributeName,
                              value: UIFont.init(name: "PingFangSC-Thin", size: 14) ?? UIFont.systemFont(ofSize: 14),
                              range: NSMakeRange(name.length, introduce!.length))
        attriStr.addAttribute(NSFontAttributeName,
                              value: UIFont.init(name: "PingFangSC-Thin", size: 14) ?? UIFont.systemFont(ofSize: 14),
                              range: NSMakeRange(name.length + (introduce?.length)!, email.length))
        attriStr.addAttribute(NSLinkAttributeName,
                              value: "gua@desgard.com",
                              range: NSMakeRange(name.length + (introduce?.length)!, email.length))
        
        aboutLabel.attributedText = attriStr
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setToSupport(callback: @escaping () -> Void) {
        toSupportPage = callback
    }
    
    public func setToOpenSource(callback: @escaping () -> Void) {
        toOpenSourcePage = callback
    }
    
    @IBAction func supportAction(_ sender: Any) {
        toSupportPage()
    }
    
    @IBAction func openSourceAction(_ sender: Any) {
        toOpenSourcePage()
    }
    
    
}
