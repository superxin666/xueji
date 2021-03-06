//
//  pch.swift
//  学记
//
//  Created by lvxin on 2017/8/30.
//  Copyright © 2017年 lvxin. All rights reserved.
//
//import Foundation
import UIKit
import Kingfisher
import SVProgressHUD
//MARK:尺寸
let KSCREEN_WIDTH = UIScreen.main.bounds.size.width
let KSCREEN_HEIGHT = UIScreen.main.bounds.size.height

var ip6 = { (num : Int) ->  CGFloat in
    return CGFloat(num)/375 * CGFloat(KSCREEN_WIDTH)
}


let iPhoneX = __CGSizeEqualToSize((UIScreen.main.currentMode?.size)!, CGSize(width: 1125, height: 2436)) ? true : false

let LNAVIGATION_HEIGHT = iPhoneX ? CGFloat(44+20+24):CGFloat(44+20)

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
let black_8E8E93 = UIColor.xj_colorFromRGB(rgbValue: 0x8E8E93)

let black_97 = UIColor.xj_colorFromRGB(rgbValue: 0x979797)
let black_e3e0e0 = UIColor.xj_colorFromRGB(rgbValue: 0xe3e0e0)
let black_e3e3e3 = UIColor.xj_colorFromRGB(rgbValue: 0xe3e3e3)
let black_ebebee = UIColor.xj_colorFromRGB(rgbValue: 0xebebee)
let black_22 = UIColor.xj_colorFromRGB(rgbValue: 0x222222)
let black_fcf9f9 = UIColor.xj_colorFromRGB(rgbValue: 0xfcf9f9)

let bluek_0068be = UIColor.xj_colorFromRGB(rgbValue: 0x0068be)
let blue_0076f9 = UIColor.xj_colorFromRGB(rgbValue: 0x0076f9)
let blue_tab_selected = UIColor.xj_colorFromRGB(rgbValue: 0x2c73b2)
//
let purple_5657CE = UIColor.xj_colorFromRGB(rgbValue: 0x5657CE)
let orange_F46F56 = UIColor.xj_colorFromRGB(rgbValue: 0xF46F56)
let green_84B53E = UIColor.xj_colorFromRGB(rgbValue: 0x84B53E)
//自定义调试信息打印
func XJLog<T>(message : T, file : String = #file, lineNumber : Int = #line) {
    //#if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("[\(fileName):line:\(lineNumber)]- \(message)")
    
    //#endif
}

