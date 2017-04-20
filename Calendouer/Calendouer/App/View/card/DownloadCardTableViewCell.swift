//
//  DownloadCardTableViewCell.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/4/20.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit

class DownloadCardTableViewCell: UITableViewCell {

    @IBOutlet weak var bakView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cardButton: UIButton!
    
    private var processBackView: UIView?
    
    var clickCallback: (_ status: Bool) -> Void = { status in
        if status == true {
            print("下载成功")
        } else {
            print("下载失败")
        }
    }
    
    var clickProcess: () -> Bool = {
        return false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialView()
    }
    
    private func initialView() {
        self.backgroundColor = .clear
        bakView.layer.masksToBounds = true
        bakView.layer.cornerRadius = 3
        bakView.layer.shadowOpacity = 0.5
        bakView.layer.shadowColor = UIColor.black.cgColor
        bakView.layer.shadowRadius = 3
        bakView.layer.shadowOffset = CGSize(width: 1, height: 1)
        bakView.clipsToBounds = false
        
        cardButton.layer.masksToBounds = true
        cardButton.layer.cornerRadius = 3
        
        titleLabel.alpha = 0.4
    }
    
    private func initialDownload() {
        processBackView = UIView(frame: bakView.frame)
        if let processBackView = processBackView {
            processBackView.backgroundColor = .black
            processBackView.alpha = 0.3
            processBackView.layer.masksToBounds = true
            processBackView.layer.cornerRadius = 3
            
            self.addSubview(processBackView)
        }
    }
    
    public func setProcessHandle(handle: @escaping() -> Bool) {
        self.clickProcess = handle
    }
    
    public func setClickCallback(callback: @escaping(_ status: Bool) -> Void) {
        self.clickCallback = callback
    }
    
    @IBAction func download(_ sender: Any) {
        let status = self.clickProcess()
        initialDownload()
        
        if status {
            UIView.animate(withDuration: 2, animations: {
                self.processBackView?.transform = CGAffineTransform(scaleX: 0.0001, y: 1)
            }) { (finish) in
                self.processBackView?.removeFromSuperview()
                self.clickCallback(status)
            }
        } else {
            self.processBackView?.transform = CGAffineTransform(translationX: -10, y: 0)
            self.bakView.transform = CGAffineTransform(translationX: -10, y: 0)
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.15, initialSpringVelocity: 0, options: .allowAnimatedContent, animations: {
                self.processBackView?.alpha = 0
                self.processBackView?.transform = .identity
                self.bakView.transform = .identity
            }, completion: { (finish) in
                self.processBackView?.removeFromSuperview()
            })
            self.clickCallback(status)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
