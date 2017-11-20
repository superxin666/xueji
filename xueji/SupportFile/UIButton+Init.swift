//
//  UIButton+Init.swift
//  xueji
//
//  Created by lvxin on 2017/11/20.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit

extension UIButton {

    
    /// 初始化标题按钮 只有标题
    ///
    /// - Parameters:
    ///   - title_normal: 标题
    ///   - title_selected: 选中状态 标题
    ///   - fream: 尺寸
    ///   - backgroundColor: 背景颜色
    ///   - textColor: 文字颜色
    ///   - fontSize: 字体大小 适配前
    ///   - textAlignment:字体偏转
    ///   - selector: 点击事件
    ///   - vc: 拥有者
    /// - Returns: 按钮
    static func getBtn_titleStyle(title_normal : String,title_selected : String,fream : CGRect,backgroundColor : UIColor,textColor : UIColor,fontSize : CGFloat,textAlignment : NSTextAlignment,selector : Selector,vc : Any,tag : Int) ->(UIButton)  {
        let btn = UIButton(type: .custom)
        btn.frame = fream
        btn.tag = tag
        btn.setTitle(title_normal, for: .normal)
        btn.setTitle(title_selected, for: .selected)
        btn.backgroundColor = backgroundColor
        btn.titleLabel?.font = xj_fzFontMedium(ip6(Int(fontSize)))
        btn.setTitleColor(textColor, for: .normal)
        btn.titleLabel?.textAlignment = textAlignment
        btn.addTarget(vc, action: selector, for: .touchUpInside)
        return btn
    }
    
    
    static func getBtn_picStyle(title_normal : String,title_selected : String,fream : CGRect,backgroundColor : UIColor,textColor : UIColor,fontSize : CGFloat,textAlignment : NSTextAlignment,selector : Selector,vc : Any) ->(UIButton)  {
        let btn = UIButton(type: .custom)
        btn.frame = fream
        btn.setTitle(title_normal, for: .normal)
        btn.setTitle(title_selected, for: .selected)
        btn.backgroundColor = backgroundColor
        btn.titleLabel?.font = xj_fzFontMedium(ip6(Int(fontSize)))
        btn.titleLabel?.textColor = textColor
        btn.titleLabel?.textAlignment = textAlignment
        btn.addTarget(vc, action: selector, for: .touchUpInside)
        return btn
    }
    
}
