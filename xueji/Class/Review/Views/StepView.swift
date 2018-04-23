//
//  StepView.swift
//  xueji
//
//  Created by lvxin on 2018/4/23.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class StepView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func setData(arr : Array<String>) {

        self.backgroundColor = .white

        let cancleBtn = UIButton(frame: CGRect(x: ip6(10), y: ip6(10), width: ip6(40), height: ip6(20)))
        cancleBtn.setTitle("关闭", for: .normal)
        cancleBtn.setTitleColor(UIColor.xj_colorFromRGB(rgbValue: 0x535353), for: .normal)
        cancleBtn.titleLabel?.font = xj_fzFontMedium(ip6(15))
        cancleBtn.addTarget(self, action: #selector(closedView), for: .touchUpInside)
        self.addSubview(cancleBtn)


        let scroView : UIScrollView = UIScrollView(frame: CGRect(x: 0, y:  ip6(50), width: self.frame.size.width, height: self.frame.size.height))
        scroView.contentSize = CGSize(width: 0, height: CGFloat(arr.count) * CGFloat(40))

        self.addSubview(scroView)
        for i in 0..<arr.count {
            let str = arr[i]
            let titleStr = "第\(i+1)复习阶段 " + str

            let subView = UIView(frame: CGRect(x: ip6(80), y: ip6(40) * CGFloat(i), width: self.frame.size.width - ip6(160), height: ip6(20)))
            let label = UILabel.getLabel(fream: CGRect(x: 0, y: 0, width: subView.frame.size.width, height: subView.frame.size.height), fontSize: 13, text: titleStr, textColor: UIColor.xj_colorFromRGB(rgbValue: 0x535353), textAlignment: .center)
            subView.addSubview(label)
            scroView.addSubview(subView)
        }
    }
    func closedView() {
        self.removeFromSuperview()
    }
}
