//
//  UIColor-Extension.swift
//  DYZB
//
//  Created by 1 on 16/9/14.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    class func getRGBDelta(_ firstColor: UIColor, _ secondColor: UIColor)->(CGFloat,CGFloat,CGFloat){
        let firstRGB = firstColor.getRGB()
        let secondRGB = secondColor.getRGB()
        return (firstRGB.0 - secondRGB.0,firstRGB.1 - secondRGB.1,firstRGB.2 - secondRGB.2)
    }
    
    
    // 类方法 获取一个颜色的RGB值（返回的是元祖）
    func getRGB() -> (CGFloat,CGFloat,CGFloat){
        guard let cmps = cgColor.components else {
            fatalError("颜色需要由RGB方式传入")
        }
        return(cmps[0] * 255,cmps[1] * 255,cmps[2] * 255)
    }
    
}
