//
//  pch.swift
//  学记
//
//  Created by lvxin on 2017/8/30.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit
import Kingfisher
//MARK:尺寸
let KSCREEN_WIDTH = UIScreen.main.bounds.size.width
let KSCREEN_HEIGHT = UIScreen.main.bounds.size.height
let LNAVIGATION_HEIGHT = CGFloat(44+20)
var ip6 = { (num : Int) ->  CGFloat in
    return CGFloat(num)/375 * CGFloat(KSCREEN_WIDTH)
}
//MARK:字体
var xj_fontThin = { (num : CGFloat) ->  UIFont in
    return  UIFont.init(name: "HelveticaNeue-Thin", size: num)!
}
var xj_fzFontMedium = { (num : CGFloat) ->  UIFont in
    return  UIFont.init(name: "HelveticaNeue-Medium", size: num)!
}
//MARK:色值
let black_53 = UIColor.xj_colorFromRGB(rgbValue: 0x535353)
let black_8c8484 = UIColor.xj_colorFromRGB(rgbValue: 0x8c8484)
let black_97 = UIColor.xj_colorFromRGB(rgbValue: 0x979797)
let blue_tab_selected = UIColor.xj_colorFromRGB(rgbValue: 0x2c73b2)
//自定义调试信息打印
func XJLog<T>(message : T, file : String = #file, lineNumber : Int = #line) {
    //#if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("[\(fileName):line:\(lineNumber)]- \(message)")
    
    //#endif
}

