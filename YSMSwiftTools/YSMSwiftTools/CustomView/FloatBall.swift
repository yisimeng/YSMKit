//
//  FloatBall.swift
//  YSMSwiftTools
//
//  Created by duanzengguang on 2018/1/22.
//  Copyright © 2018年 忆思梦吧. All rights reserved.
//

import UIKit

class FloatBall: UIButton {
    
    enum HorizonPosition {
        case left, right
    }
    
    /// 是否是移动了
    private var isMove = false
    /// 开始移动的位置
    private var beginPoint = CGPoint.zero
    /// 水平贴边
    fileprivate var position: HorizonPosition = .right
    
    var arrImage = UIImageView(image: UIImage(named: "nav_back"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        arrImage.center = CGPoint(x: frame.width/2, y: frame.height/2)
        addSubview(arrImage)
        addTarget(self, action: #selector(floatBallAction(_:)), for: .touchUpInside)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        addTarget(self, action: #selector(floatBallAction(_:)), for: .touchUpInside)
        arrImage.center = CGPoint(x: frame.width/2, y: frame.height/2)
        addSubview(arrImage)
    }
    
    /// 半圆
    ///
    /// - Parameter rect: <#rect description#>
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(arcCenter: CGPoint(x: rect.maxX, y: rect.midY), radius: rect.width, startAngle: CGFloat(Double.pi/2), endAngle: CGFloat(Double.pi*3), clockwise: true)
        UIColor.red.setFill()
        path.fill()
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        isMove = false
        beginPoint = point
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let current: CGPoint = touches.first?.location(in: self) else {return}
        let delta_x = current.x-beginPoint.x
        let delta_y = current.y-beginPoint.y
        guard fabsf(Float(delta_x)) > 5 || fabsf(Float(delta_y)) > 5 else {return}
        isMove = true
        self.superview?.center = CGPoint(x: (self.superview?.center.x)!+delta_x, y: (self.superview?.center.y)!+delta_y)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isMove == true else {
            sendActions(for: .touchUpInside)
            return
        }
        hideMenu()
        // 移动结束
        var side_x: CGFloat
        var side_y: CGFloat
        if (self.superview!.center.x < UIScreen.main.bounds.size.width/2) {
            // 靠左
            side_x = self.frame.size.width/2;
            if position != .left {
                rotationFloatBall(true)
            }
            position = .left
        }else{
            // 靠右
            side_x = UIScreen.main.bounds.size.width-self.frame.size.width/2;
            if position != .right {
                rotationFloatBall(false)
            }
            position = .right
        }
        
        // 上下边界
        if (self.superview!.center.y < 20 + self.frame.size.height/2) {
            side_y = 20 + self.frame.size.height/2;
        }else if (self.superview!.center.y > UIScreen.main.bounds.size.height-10-self.frame.size.height/2) {
            side_y = UIScreen.main.bounds.size.height-10-self.frame.size.height/2;
        }else {
            side_y = self.superview!.center.y;
        }
        
        // 最终位置
        let sidePoint = CGPoint(x: side_x, y: side_y)
        
        if !self.center.equalTo(sidePoint) {
            endMove(to: sidePoint, isBounce: true)
        }
    }
    
    /// 点击事件
    ///
    /// - Parameter btn: <#btn description#>
    @objc private func floatBallAction(_ btn: UIButton){
        rotationArrowImage(btn.isSelected)
        self.isSelected = !self.isSelected
    }
}

// MARK: - public
extension FloatBall{
    func hide() {
        hideMenu()
        self.removeFromSuperview()
    }
}


// MARK: - menu
extension FloatBall{
    fileprivate func showMenu() {
        self.isSelected = true
        rotationArrowImage(true)
    }
    fileprivate func hideMenu() {
        self.isSelected = false
        rotationArrowImage(false)
    }
}

// MARK: - animation
extension FloatBall{
    
    /// 悬浮球拖拽后动画
    ///
    /// - Parameters:
    ///   - point: <#point description#>
    ///   - isBounce: <#isBounce description#>
    fileprivate func endMove(to point: CGPoint, isBounce: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveLinear, animations: {
            self.superview?.center = point
        }, completion: nil)
    }
    
    fileprivate func rotationArrowImage(_ flag: Bool) {
        let animat = CABasicAnimation(keyPath: "transform.rotation.y")
        if flag{
            animat.toValue = -Double.pi
        }else {
            animat.byValue = -Double.pi/2
            animat.toValue = 0
        }
        animat.isRemovedOnCompletion = false
        animat.fillMode = kCAFillModeForwards
        animat.duration = 0
        arrImage.layer.add(animat, forKey: "rotation")
    }
    
    fileprivate func rotationFloatBall(_ flag: Bool) {
        
        let animat = CABasicAnimation(keyPath: "transform.rotation.y")
        if flag{
            animat.toValue = -Double.pi
        }else {
            animat.toValue = 0
        }
        animat.isRemovedOnCompletion = false
        animat.fillMode = kCAFillModeForwards
        animat.duration = 0
        self.layer.add(animat, forKey: "ro")
    }
}



