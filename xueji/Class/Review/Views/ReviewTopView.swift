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
    
    
    func creatUI(arr : Array<ReviewModel>)  {
        let topLine : UIView = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: ip6(2)))
        topLine.backgroundColor = black_22
        self.addSubview(topLine)
        
        //日期
        let subviewW = KSCREEN_WIDTH/7
        let subviewH = ip6(42)
        
        for i in 0..<arr.count {
            let model : ReviewModel = arr[i]
            
            let subView = UIView(frame: CGRect(x: CGFloat(i) * subviewW, y: ip6(2), width: subviewW, height: subviewH))
            let topLabel = UILabel.getLabel(fream: CGRect(x: 0, y: 0, width: subviewW, height: subviewH/3), fontSize: 10, text: ReviewModel.getTitleStr(num: model.week_seq), textColor: UIColor.xj_colorFromRGB(rgbValue: 0x8E8E93), textAlignment: .center)
      
            subView.addSubview(topLabel)
            
//            let dateStr = String.xj_getDate_style1(dateStr: "\(model.date!)", style: 3)
            
            let midLabel = UILabel.getLabel(fream: CGRect(x: 0, y: subviewH/3, width: subviewW, height: subviewH/3), fontSize: 15, text: "5", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x535353 ), textAlignment: .center)
            subView.addSubview(midLabel)
            let weekNum = String.getDayIndex()
            XJLog(message:"星期几" + "\(weekNum)")
            if i == weekNum {
                midLabel.textColor = .white
                subView.backgroundColor = UIColor.xj_colorFromRGB(rgbValue: 0x535353)
            }
            let bottomLabel = UILabel.getLabel(fream: CGRect(x: 0, y: subviewH/3*2, width: subviewW, height: subviewH/3), fontSize: 6, text: "\(model.review_count!)项", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x88B52D), textAlignment: .center)
            
            subView.addSubview(bottomLabel)
     
            self.addSubview(subView)
            
        }
        
        let bottomLine : UIView = UIView(frame: CGRect(x: 0, y: ip6(42), width: KSCREEN_WIDTH, height: ip6(2)))
        bottomLine.backgroundColor = black_22
        self.addSubview(bottomLine)
    }

}
