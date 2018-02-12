//
//  UIColor+LYDeveloper.swift
//  kemiBear
//
//  Created by 李扬 on 2017/4/18.
//  Copyright © 2017年 李扬. All rights reserved.
//

import UIKit

extension UIColor {

    /// 通过RGBA，得到一个颜色
    ///
    ///     let color = UIColor.colorRGBA(0x001122, 1)
    ///
    /// - Parameter RGB: Red Green Blue 0 ~ 255
    ///
    /// - Parameter alpha: alpha值 0.0 ~ 1.0
    ///
    /// - Returns: UIColor
    class func ly_color(_ RGB: Int, _ alpha: Float = 1) -> UIColor {
        let red = Float(((RGB & 0xFF0000) >> 16)) / 255.0
        let green = Float(((RGB & 0x00FF00) >> 8)) / 255.0
        let blue = Float(RGB & 0x0000FF) / 255.0
        return UIColor.init(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
}


