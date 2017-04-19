//
//  AppDefault.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/3/2.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit
import Spring
import RealmSwift

// Realm Database

// Log Function
func printLog<T>(message: T,
              file: String = #file,
              method: String = #function,
              line: Int = #line) {
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}

// Color Quick Function
func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red:   r / 255.0,
                   green: g / 255.0,
                   blue:  b / 255.0,
                   alpha: a)
}

// Color Quick Constructor
extension UIColor {
    convenience init(value: UInt, alpha: CGFloat) {
        self.init (
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

// Color
let DouGreen: UIColor = UIColor(value: 0x4CAF50, alpha: 1)
let DouDarkGreen: UIColor = UIColor(value: 0x388E3C, alpha: 1)
let DouCardTextGray: UIColor = RGBA(r: 122, g: 122, b: 122, a: 1)
let DouBackGray: UIColor = UIColor(value: 0xFAFAFA, alpha: 1)
let DouStarYellow: UIColor = UIColor(value: 0xFFD021, alpha: 1)

// Font
let DouDefalutFontName: String = ".PingFangSC-Medium"
let DouIncFontName: String = ".PingFangSC-Regular"
let DouCalendarFontName: String = "Arial-BoldMT"
let DouDefalutFont: UIFont = UIFont(name: DouDefalutFontName, size: 15)!
let DouIncFont: UIFont = UIFont(name: DouIncFontName, size: 14)!
let DouCalendarFont: UIFont = UIFont(name: DouCalendarFontName, size: 90)!

// Identity
let CardTableViewCellId: String = "CardTableViewCell"
let SwitchSettingTableViewCellId: String = "SwitchSettingTableViewCell"
let TextSettingTableViewCellId: String = "TextSettingTableViewCell"
let TitleSettingTableViewCellId: String = "TitleSettingTableViewCell"
let MoviePostTableViewCellId: String = "MoviePostTableViewCell"
let MovieIntroductionTableViewCellId: String = "MovieIntroductionTableViewCell"
let MovieSummaryTableViewCellId: String = "MovieSummaryTableViewCell"


// NSObject
extension NSObject {
    public func selfType() -> String {
        return "\(self.classForCoder)"
    }
}

// UITableView
extension UITableView {
    public func reloadData(animated: Bool) {
        self.reloadData()
        if animated {
            let animation: CATransition = CATransition()
            animation.type = kCATransitionFade
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            animation.duration = 0.3
            self.layer.add(animation, forKey: "UITableViewReloadDataAnimationKey")
        }
    }
}

// UILabel
extension UILabel {
    public func changeText(data: String) {
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut], animations: {
            self.alpha = 0
        }) { _ in
            self.text = data
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: { 
                self.alpha = 1
            }, completion: { (_) in
                
            })
        }
    }
}

public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

let _CalendouerLogo = CalendouerLogoLayer()

// logo
class CalendouerLogoLayer {
    class func logoLayer() -> CAShapeLayer {
        let layer = CAShapeLayer()
        //// Color Declarations
        let fillColor = UIColor(red: 0.314, green: 0.694, blue: 0.329, alpha: 1.000)
        
        //// LOGO 2
        //// Group 矢量图 5
        //// Group 8
        //// Combined-Shape Drawing
        let combinedShapePath = UIBezierPath()
        combinedShapePath.move(to: CGPoint(x: 276.56, y: 68.81))
        combinedShapePath.addLine(to: CGPoint(x: 210.06, y: 25.62))
        combinedShapePath.addLine(to: CGPoint(x: 160.79, y: 110.96))
        combinedShapePath.addCurve(to: CGPoint(x: 149.87, y: 113.89), controlPoint1: CGPoint(x: 158.58, y: 114.78), controlPoint2: CGPoint(x: 153.69, y: 116.09))
        combinedShapePath.addLine(to: CGPoint(x: 144.62, y: 110.85))
        combinedShapePath.addCurve(to: CGPoint(x: 141.69, y: 99.94), controlPoint1: CGPoint(x: 140.8, y: 108.65), controlPoint2: CGPoint(x: 139.49, y: 103.75))
        combinedShapePath.addLine(to: CGPoint(x: 197.02, y: 4.11))
        combinedShapePath.addCurve(to: CGPoint(x: 207.93, y: 1.19), controlPoint1: CGPoint(x: 199.22, y: 0.29), controlPoint2: CGPoint(x: 204.11, y: -1.02))
        combinedShapePath.addLine(to: CGPoint(x: 208.22, y: 1.35))
        combinedShapePath.addCurve(to: CGPoint(x: 214.72, y: 2.36), controlPoint1: CGPoint(x: 210.35, y: 0.76), controlPoint2: CGPoint(x: 212.72, y: 1.06))
        combinedShapePath.addLine(to: CGPoint(x: 297.02, y: 55.81))
        combinedShapePath.addCurve(to: CGPoint(x: 300.42, y: 60.53), controlPoint1: CGPoint(x: 298.78, y: 56.95), controlPoint2: CGPoint(x: 299.94, y: 58.66))
        combinedShapePath.addCurve(to: CGPoint(x: 301.26, y: 69.32), controlPoint1: CGPoint(x: 302.38, y: 62.95), controlPoint2: CGPoint(x: 302.82, y: 66.4))
        combinedShapePath.addLine(to: CGPoint(x: 29.2, y: 581))
        combinedShapePath.addLine(to: CGPoint(x: 311.98, y: 581))
        combinedShapePath.addLine(to: CGPoint(x: 192.07, y: 403.23))
        combinedShapePath.addLine(to: CGPoint(x: 156.63, y: 464.63))
        combinedShapePath.addCurve(to: CGPoint(x: 145.71, y: 467.56), controlPoint1: CGPoint(x: 154.42, y: 468.46), controlPoint2: CGPoint(x: 149.53, y: 469.77))
        combinedShapePath.addLine(to: CGPoint(x: 140.45, y: 464.53))
        combinedShapePath.addCurve(to: CGPoint(x: 137.53, y: 453.6), controlPoint1: CGPoint(x: 136.63, y: 462.32), controlPoint2: CGPoint(x: 135.32, y: 457.43))
        combinedShapePath.addLine(to: CGPoint(x: 182.18, y: 376.26))
        combinedShapePath.addCurve(to: CGPoint(x: 192.96, y: 373.25), controlPoint1: CGPoint(x: 184.36, y: 372.48), controlPoint2: CGPoint(x: 189.16, y: 371.16))
        combinedShapePath.addCurve(to: CGPoint(x: 200.77, y: 376.69), controlPoint1: CGPoint(x: 195.91, y: 372.81), controlPoint2: CGPoint(x: 198.99, y: 374.05))
        combinedShapePath.addLine(to: CGPoint(x: 336.7, y: 578.21))
        combinedShapePath.addCurve(to: CGPoint(x: 337.45, y: 585.77), controlPoint1: CGPoint(x: 338.26, y: 580.53), controlPoint2: CGPoint(x: 338.45, y: 583.37))
        combinedShapePath.addCurve(to: CGPoint(x: 338.13, y: 588.99), controlPoint1: CGPoint(x: 337.89, y: 586.76), controlPoint2: CGPoint(x: 338.13, y: 587.85))
        combinedShapePath.addLine(to: CGPoint(x: 338.13, y: 595.06))
        combinedShapePath.addCurve(to: CGPoint(x: 330.12, y: 603.05), controlPoint1: CGPoint(x: 338.13, y: 599.47), controlPoint2: CGPoint(x: 334.56, y: 603.05))
        combinedShapePath.addLine(to: CGPoint(x: 18.01, y: 603.05))
        combinedShapePath.addCurve(to: CGPoint(x: 14.79, y: 602.38), controlPoint1: CGPoint(x: 16.87, y: 603.05), controlPoint2: CGPoint(x: 15.78, y: 602.81))
        combinedShapePath.addCurve(to: CGPoint(x: 9.15, y: 601.68), controlPoint1: CGPoint(x: 12.96, y: 602.83), controlPoint2: CGPoint(x: 10.95, y: 602.63))
        combinedShapePath.addLine(to: CGPoint(x: 3.79, y: 598.83))
        combinedShapePath.addCurve(to: CGPoint(x: 0.49, y: 588.01), controlPoint1: CGPoint(x: -0.1, y: 596.75), controlPoint2: CGPoint(x: -1.58, y: 591.92))
        combinedShapePath.addLine(to: CGPoint(x: 276.56, y: 68.81))
        combinedShapePath.close()
        combinedShapePath.usesEvenOddFillRule = true
        fillColor.setFill()
        combinedShapePath.fill()
        
        layer.path = combinedShapePath.cgPath
        layer.bounds = layer.path!.boundingBoxOfPath
        return layer
    }
}
