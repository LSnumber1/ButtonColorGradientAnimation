//
//  ViewController.swift
//  ButtonColorGradientAnimation
//
//  Created by ls on 2018/4/16.
//  Copyright © 2018年 ls. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorButton: UIButton!
    var progress: CGFloat = 0.0
    var progressGradientLayer: CAGradientLayer?
    var firstColors:[Any]?
    var endColors:[Any]?
    override func viewDidLoad() {
        super.viewDidLoad()
        colorButton.layer.cornerRadius = 10
        setupProgressView()
    }
}
//MARK: - CAAnimationDelegate
extension ViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
//        if progress < 1 {
            progressGradientLayer?.colors = endColors
            progressGradient()
//        }
        progress += 1.0
    }
}
//MARK: - CAAnimationDelegate
extension ViewController {
    func setupProgressView() {
        progressGradientLayer = CAGradientLayer()
        progressGradientLayer?.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        progressGradientLayer?.cornerRadius = 10
        progressGradientLayer?.startPoint = CGPoint(x: 0.0, y: 0)
        progressGradientLayer?.endPoint = CGPoint(x: 1.0, y: 0)
        let colors = [
            UIColor.brown.cgColor,
            UIColor.red.cgColor,
            UIColor.orange.cgColor,
            UIColor.cyan.cgColor
        ]
        progressGradientLayer?.colors = colors
        firstColors = colors
        colorButton.layer.addSublayer(progressGradientLayer!)
        
        self.progressGradient()
    }
    
    @objc func progressGradient() {
        var colorArray = progressGradientLayer?.colors
        
        if endColors != nil {
            firstColors = endColors
        }
        let lastColor = colorArray?.last
        colorArray?.removeLast()
        
        if let aColor = lastColor {
            colorArray?.insert(aColor, at: 0)
        }
        endColors = colorArray
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = firstColors
        animation.toValue = endColors
        animation.duration = 2
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        progressGradientLayer?.add(animation, forKey: "animateGradient")
    }
}
