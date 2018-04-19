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
    var startColors:[Any]?  //动画处使用，动画开始颜色组
    var endColors:[Any]? //动画处使用，动画结束颜色组
    let colors = [
        UIColor.init(red: 162/255, green: 94/255, blue: 255/255, alpha: 1).cgColor,
        UIColor.init(red: 108/255, green: 153/255, blue: 255/255, alpha: 1).cgColor,
        UIColor.init(red: 105/255, green: 201/255, blue: 255/255, alpha: 1).cgColor,
        UIColor.init(red: 102/255, green: 235/255, blue: 221/255, alpha: 1).cgColor,
        UIColor.init(red: 103/255, green: 249/255, blue: 145/255, alpha: 1).cgColor,
        UIColor.init(red: 228/255, green: 250/255, blue: 139/255, alpha: 1).cgColor,
        UIColor.init(red: 255/255, green: 198/255, blue: 88/255, alpha: 1).cgColor,
        UIColor.init(red: 255/255, green: 120/255, blue: 102/255, alpha: 1).cgColor,
        UIColor.init(red: 162/255, green: 94/255, blue: 255/255, alpha: 1).cgColor
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        colorButton.layer.cornerRadius = 10
        initGradientLayerView()
    }
}
//MARK: - CAAnimationDelegate
extension ViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        caGradientLayer?.colors = endColors
        gradientAnimation()
        progress += 1.0
        if Int(progress + 2) >= colors.count {
            progress = 0
        }
    }
}
//MARK: - UI
extension ViewController {
    ///初始化CAGradientLayer
    func initGradientLayerView() {
        caGradientLayer = CAGradientLayer()
        caGradientLayer?.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        caGradientLayer?.cornerRadius = 10
        caGradientLayer?.startPoint = CGPoint(x: 0, y: 0)
        caGradientLayer?.endPoint = CGPoint(x: 1, y: 0)
        let colors2 = [
            colors[0],
            colors[1]
        ]
        caGradientLayer?.colors = colors2
        startColors = colors2
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
            startColors = endColors
        }
        colorArray?.removeFirst()
        colorArray?.append(colors[Int(progress) + 2])
        endColors = colorArray
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = startColors
        animation.toValue = endColors
        animation.duration = 1
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        caGradientLayer?.add(animation, forKey: "animateGradient")
    }
}
