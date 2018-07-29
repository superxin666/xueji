//
//  ReviewTopView.swift
//  xueji
//
//  Created by lvxin on 2018/3/26.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
protocol ReviewTopViewDelegate {
    func headDateClick(num : Int)
}

class ReviewTopView: UIView {

    var delegate : ReviewTopViewDelegate!
    
    
    /// 上次选择
    var lastView : UIView!
    
     /// 星期几
    let weekNum = String.getDayIndex()
    
    func creatUI(arr : Array<ReviewModel>)  {
        let topLine : UIView = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: ip6(2)))
        topLine.backgroundColor = black_22
        self.addSubview(topLine)
        
        //日期
        let subviewW = ip6(25)
        let subviewH = ip6(49)

        let appading = (KSCREEN_WIDTH - 7 * subviewW)/8

        
        for i in 0..<arr.count {
            let model : ReviewModel = arr[i]
            
            let subView = UIView(frame: CGRect(x: appading + CGFloat(i) * (subviewW + appading), y: ip6(2), width: subviewW, height: subviewH))
            subView.isUserInteractionEnabled = true
            subView.tag = i + 1
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick(sender:)))
            subView.addGestureRecognizer(tap)
            
            let topLabel = UILabel.getLabel(fream: CGRect(x: 0, y: 0, width: subviewW, height: subviewH/3), fontSize: 8, text: ReviewModel.getTitleStr(num: model.week_seq), textColor: UIColor.xj_colorFromRGB(rgbValue: 0x8E8E93), textAlignment: .center)
            topLabel.tag = 1
            subView.addSubview(topLabel)
            
            let dateStr = String.xj_getDate_style1(dateStr: "\(model.date!)", style: 3)
            
            let midLabel = UILabel.getLabel(fream: CGRect(x: 0, y: subviewH/3, width: subviewW, height: subviewH/3), fontSize: 15, text: dateStr, textColor: UIColor.xj_colorFromRGB(rgbValue: 0x535353 ), textAlignment: .center)
            midLabel.tag = 2
            subView.addSubview(midLabel)
           
            XJLog(message:"星期几" + "\(weekNum)")
            if i + 1 == weekNum {
                topLabel.textColor = .white
                midLabel.textColor = .white
                subView.backgroundColor = UIColor.xj_colorFromRGB(rgbValue: 0x535353)
                lastView = subView
            }
            let bottomLabel = UILabel.getLabel(fream: CGRect(x: 0, y: subviewH/3*2, width: subviewW, height: subviewH/3), fontSize: 6, text: "\(model.review_count!)项", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x88B52D), textAlignment: .right)
            
            subView.addSubview(bottomLabel)
     
            self.addSubview(subView)
            
        }
        
        let bottomLine : UIView = UIView(frame: CGRect(x: 0, y: ip6(52), width: KSCREEN_WIDTH, height: ip6(2)))
        bottomLine.backgroundColor = black_22
        self.addSubview(bottomLine)
    }
    
    func tapClick(sender : UITapGestureRecognizer) {
        let view = sender.view
        if view?.tag == lastView.tag {
            return
        }
        for subView in lastView.subviews {
            if subView is UILabel {
                let label : UILabel = subView as! UILabel
                if label.tag == 1 {
                    label.textColor = UIColor.xj_colorFromRGB(rgbValue: 0x8E8E93)
                } else if label.tag == 2 {
                    label.textColor = UIColor.xj_colorFromRGB(rgbValue: 0x535353)
                }
            }
        }
        lastView.backgroundColor = .white

        view?.backgroundColor = UIColor.xj_colorFromRGB(rgbValue: 0x535353)
        for subView in (view?.subviews)! {
            if subView is UILabel {
                let label : UILabel = subView as! UILabel
                if subView.tag == 1 {
                    label.textColor = .white
                } else if subView.tag == 2 {
                    label.textColor = .white
                }

            }
        }


        lastView = view
        let viewTag : Int = (sender.view?.tag)!
        XJLog(message: "点击\(viewTag)")
        if  self.delegate != nil {
            self.delegate.headDateClick(num: viewTag)
        }
    }

}
