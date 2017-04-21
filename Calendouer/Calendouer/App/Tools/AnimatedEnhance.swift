//
//  AnimatedEnhance.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/4/21.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit

let Animated = AnimatedEnhance.shared

class AnimatedEnhance: NSObject {
    static let shared = AnimatedEnhance()
    
    public func getExplosion(view: UIView) {
        let explodeView = ExplodeAnimationView(frame: view.bounds)
        view.insertSubview(explodeView, at: 0)
        explodeView.animate()
    }
}


class ExplodeAnimationView: UIView {
    private var emitterLayer: CAEmitterLayer! = nil
    
    private func ready() {
        self.clipsToBounds = false
        self.isUserInteractionEnabled = false
        
        let emitter = CAEmitterCell()
        emitter.contents = UIImage(named: "spark")?.cgImage
        emitter.name = "explosion"
        emitter.alphaRange = 0.2
        emitter.alphaSpeed = -1
        emitter.lifetime = 0.7
        emitter.birthRate = 0
        emitter.velocity = 40
        emitter.velocityRange = 10
        emitter.emissionRange = CGFloat(Double.pi / 4)
        emitter.scale = 0.05
        emitter.scaleRange = 0.02
        
        emitterLayer = CAEmitterLayer()
        emitterLayer.name = "emitterLayer"
        emitterLayer.emitterShape = kCAEmitterLayerCircle
        emitterLayer.emitterMode = kCAEmitterLayerOutline
        emitterLayer.emitterPosition = self.center
        emitterLayer.emitterSize = CGSize(width: 25, height: 0)
        emitterLayer.renderMode = kCAEmitterLayerOldestFirst
        emitterLayer.masksToBounds = false
        emitterLayer.emitterCells = [emitter]
        emitterLayer.frame = UIScreen.main.bounds
        self.layer.addSublayer(emitterLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        ready()
    }
    
    public func animate() {
        let delayTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.emitterLayer.beginTime = CACurrentMediaTime()
            let ani = CABasicAnimation(keyPath: "emitterCells.explosion.birthRate")
            ani.fromValue = 0
            ani.toValue = 500
            self.emitterLayer.add(ani, forKey: nil)
        }
    }
}
