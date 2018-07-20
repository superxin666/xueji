
//
//  UIButton+title.swift
//  xueji
//
//  Created by lvxin on 2018/7/20.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class UIButton_title: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageH = ip6(132 + 7)
        let imageW = ip6(100)
        let titleHeight = ip6(14)

        return CGRect(x: 0, y: imageH, width: imageW, height: titleHeight)

    }

    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageH = ip6(132)
        let imageW = ip6(100)
        return CGRect(x: 0, y: 0, width: imageW, height: imageH)
    }

}
