//
//  Color+fun.swift
//  学记
//
//  Created by lvxin on 2017/10/30.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// 输入16进制返回颜色
    ///
    /// - parameter rgbValue: 16进制颜色
    ///
    /// - returns: UIColor
    static func xj_colorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    /// 输入三色值返回颜色
    ///
    /// - parameter red:   红的
    /// - parameter green: 绿
    /// - parameter blue:  蓝
    /// - parameter alpha: 透明度
    ///
    /// - returns: UIColor
    static func xj_ColorFromInt(red:CGFloat,green:CGFloat,blue:CGFloat,alpha:CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }

    
    static func xj_colorFromString(hexColor: String) -> UIColor {

        // 存储转换后的数值
        var red:UInt32 = 0, green:UInt32 = 0, blue:UInt32 = 0
        // 分别转换进行转换
        let startIndex = hexColor.index(hexColor.startIndex, offsetBy:1)//获取d的索引
        let endIndex = hexColor.index(startIndex, offsetBy:2)//的索引开始往后两个,即获取f的索引
        let redStr = hexColor.substring(with: startIndex..<endIndex)

        let startIndex2 = hexColor.index(hexColor.startIndex, offsetBy:3)//获取d的索引
        let endIndex2 = hexColor.index(startIndex2, offsetBy:2)//的索引开始往后两个,即获取f的索引
        let greenStr = hexColor.substring(with: startIndex2..<endIndex2)

        let startIndex3 = hexColor.index(hexColor.startIndex, offsetBy:5)//获取d的索引
        let endIndex3 = hexColor.index(startIndex3, offsetBy:2)//的索引开始往后两个,即获取f的索引
        let blueStr = hexColor.substring(with: startIndex3..<endIndex3)
//        XJLog(message: hexColor)
//        XJLog(message: redStr)
//        XJLog(message: greenStr)
//        XJLog(message: blueStr)

        Scanner(string: redStr).scanHexInt32(&red)
        Scanner(string: greenStr).scanHexInt32(&green)
        Scanner(string: blueStr).scanHexInt32(&blue)
        return UIColor.xj_ColorFromInt(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
    }

}
