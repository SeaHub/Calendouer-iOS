//
//  DegreeLineTableViewCell.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/4/21.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit
import SnapKit

class DegreeLineTableViewCell: UITableViewCell {

    var lineChart: LineChart!
    let xLabels: [String] = ["03-01", "03-02", "03-03"]
    
    var showLabel: UILabel = {
        var label = UILabel()
        label.textColor = DouGreen
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 24)
        label.textAlignment = .center
        return label
    }()
    
    var tintLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(value: 0xD6D6D6, alpha: 1)
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 14)
        label.text = "Today"
        label.textAlignment = .center
        return label
    }()
    
    @IBOutlet weak var bakView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialViews()
        setLayouts()
    }
    
    private func initialViews() {
        let highDatas: [CGFloat] = [22, 27, 25,];
        let lowDatas: [CGFloat] = [9, 9, 11,];
        
        lineChart = LineChart()
        lineChart.animation.enabled = true
        lineChart.area = true
        lineChart.x.labels.visible = true
        lineChart.y.labels.visible = false
        lineChart.x.grid.count = 4
        lineChart.y.grid.count = 4
        lineChart.x.labels.values = xLabels
        lineChart.addLine(lowDatas)
        lineChart.addLine(highDatas)
        
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.delegate = self
        
        showLabel.text = "\(((highDatas[0] + lowDatas[0]) / 2))°C"
        
        self.bakView.addSubview(lineChart)
        self.bakView.addSubview(showLabel)
        self.bakView.addSubview(tintLabel)
    }
    
    private func setLayouts() {
        lineChart.snp.makeConstraints { (make) in
            make.top.equalTo(self.bakView.snp.top).offset(0)
            make.left.equalTo(self.bakView.snp.left).offset(100)
            make.right.equalTo(self.bakView.snp.right).offset(-10)
            make.bottom.equalTo(self.bakView.snp.bottom).offset(-20)
        }
        
        showLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.lineChart).offset(20)
            make.right.equalTo(self.lineChart.snp.left)
        }
        
        tintLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.showLabel)
            make.bottom.equalTo(self.showLabel.snp.top)
        }
    }
}

extension DegreeLineTableViewCell: LineChartDelegate {
    func didSelectDataPoint(_ x: CGFloat, yValues: [CGFloat]) {
        if yValues.count == 2 {
            let showData = (yValues[0] + yValues[1]) / 2;
            showLabel.changeText(data: "\(showData)°C")
            
            if Int(x) == 0 {
                self.tintLabel.changeText(data: "Today")
            }
            else if Int(x) == 1 {
                self.tintLabel.changeText(data: "Tomorrow")
            }
            else {
                self.tintLabel.changeText(data: "3rd Day")
            }
        }
    }
}
