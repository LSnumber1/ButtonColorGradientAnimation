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
    var progress: CGFloat = 0.0 //用于控制显示动画次数哦
    var caGradientLayer: CAGradientLayer? //渐变色实现
    var firstColors:[Any]?  //动画处使用，动画开始颜色组
    var endColors:[Any]? //动画处使用，动画结束颜色组
    override func viewDidLoad() {
        super.viewDidLoad()
        colorButton.layer.cornerRadius = 10
        initGradientLayerView()
    }
}
//MARK: - CAAnimationDelegate
extension ViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if progress < 10 {
            caGradientLayer?.colors = endColors
            gradientAnimation()
        }
        progress += 1.0
    }
}
//MARK: - UI
extension ViewController {
    ///初始化CAGradientLayer
    func initGradientLayerView() {
        caGradientLayer = CAGradientLayer()
        caGradientLayer?.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        caGradientLayer?.cornerRadius = 10
        caGradientLayer?.startPoint = CGPoint(x: 0.0, y: 0)
        caGradientLayer?.endPoint = CGPoint(x: 1.0, y: 0)
        let colors = [
            UIColor.brown.cgColor,
            UIColor.red.cgColor,
            UIColor.orange.cgColor,
            UIColor.cyan.cgColor
        ]
        caGradientLayer?.colors = colors
        firstColors = colors
        //Button上添加Layer
        colorButton.layer.addSublayer(caGradientLayer!)
        //开始动画
        self.gradientAnimation()
    }
}
//MARK: - 动画
extension ViewController {
    ///Layer动画
    @objc func gradientAnimation() {
        var colorArray = caGradientLayer?.colors
        
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
        caGradientLayer?.add(animation, forKey: "animateGradient")
    }
}
