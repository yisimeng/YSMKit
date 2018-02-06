//
//  CustomView.swift
//  YSMSwiftTools
//
//  Created by duanzengguang on 2018/1/26.
//  Copyright © 2018年 忆思梦吧. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let be: UIBezierPath = UIBezierPath()
        be.move(to: CGPoint(x: 0, y: 0))
        be.addLine(to: CGPoint(x: bounds.width/2, y: 0))
        be.addLine(to: CGPoint(x: bounds.width/2, y: bounds.height))
        be.close()
        
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        shapeLayer.path = be.cgPath
        shapeLayer.fillColor = UIColor.blue.cgColor
//        layer.addSublayer(shapeLayer)
        layer.mask = shapeLayer
        
        
        let gradientLayer = CAGradientLayer(layer: shapeLayer)
        // 图层的颜色空间(阶梯显示时按照数组的顺序显示渐进色)
        gradientLayer.colors = [UIColor.red.cgColor,UIColor.green.cgColor]
        gradientLayer.locations = [0,1]
        gradientLayer.frame = bounds
        gradientLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        // 绘图的起点(默认是(0.5,0))
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        // 绘图的终点(默认是(0.5,1))
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)

        layer.addSublayer(gradientLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
