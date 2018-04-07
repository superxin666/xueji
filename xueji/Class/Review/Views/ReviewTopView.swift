//
//  ReviewTopView.swift
//  xueji
//
//  Created by lvxin on 2018/3/26.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class ReviewTopView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    func creatUI()  {
        let topLine : UIView = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: ip6(2)))
        topLine.backgroundColor = black_22
        self.addSubview(topLine)
        
        //日期
        let subviewW = KSCREEN_WIDTH/8
        let subviewH = ip6(42)
        
        for i in 0..<8 {
            let subView = UIView(frame: CGRect(x: 0, y: 0, width: subviewW, height: subviewH))
            let topLabel = UILabel.getLabel(fream: CGRect(x: 0, y: 0, width: subviewW, height: subviewH), fontSize: 10, text: "", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x999999), textAlignment: .center)
            subView.addSubview(topLabel)
            
            self.addSubview(subView)
            
        }
        
        let bottomLine : UIView = UIView(frame: CGRect(x: 0, y: ip6(42), width: KSCREEN_WIDTH, height: ip6(2)))
        bottomLine.backgroundColor = black_22
        self.addSubview(bottomLine)
    }

}
