//
//  StudyTimeTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2017/11/7.
//  Copyright © 2017年 lvxin. All rights reserved.
//  我的--学习时间

import UIKit

class StudyTimeTableViewCell: UITableViewCell {
    var leftBackView : UIView!
    var leftTitleLabel :UILabel!
    var leftTimeLabel :UILabel!
    var leftBtn : UIButton!
    
    var midBackView : UIView!
    var midTitleLabel :UILabel!
    var midTimeLabel :UILabel!
    var midBtn : UIButton!
    
    var rightBackView : UIView!
    var rightTitleLabel :UILabel!
    var rightTimeLabel :UILabel!
    var rightdBtn : UIButton!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.creatUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI() {
        let backViewW = (KSCREEN_WIDTH - ip6(40))/3
        let backViewH = ip6(91)
        let titleLabelY = ip6(8)
        let titleLabelH = ip6(14)
        let titleNameArr = ["今天","本月","总计",]
        let btnNameArr = ["日","周","月",]
        
        for i in 0..<titleNameArr.count {
           let  backView = UIView(frame: CGRect(x: ip6(20) + CGFloat(i) * backViewW, y: 0, width: backViewW, height: backViewH))
            self.addSubview(backView)
            
            let titleLabel = UILabel(frame: CGRect(x: 0, y: titleLabelY, width: backViewW, height: titleLabelH))
            titleLabel.text = titleNameArr[i]
            titleLabel.textAlignment = .center
            titleLabel.font = xj_fzFontMedium(ip6(10))
            titleLabel.textColor = black_53
            backView.addSubview(titleLabel)
            
            let timeLabel = UILabel(frame: CGRect(x: 0, y: titleLabel.frame.maxY + ip6(5), width: backViewW, height: ip6(30)))
            timeLabel.text = "1000页"
            timeLabel.textAlignment = .center
            timeLabel.font = xj_fzFontMedium(ip6(22))
            timeLabel.textColor = black_8c8484
            backView.addSubview(timeLabel)
            
            let btn = UIButton()
            
            btn.frame = CGRect(x: ip6(1), y: timeLabel.frame.maxY + ip6(10) , width: backViewW - ip6(2), height: ip6(23))
            //
            btn.setTitle(btnNameArr[i], for: .normal)
            btn.setTitleColor(black_53, for: .normal)
            btn.backgroundColor = .white
            btn.tag = i
            btn.xj_makeBorderWithBorderWidth(width: 1, color: black_53)
            btn.xj_makeRadius(radius: 3)
            btn.titleLabel?.font = xj_fzFontMedium(ip6(14))
            btn.addTarget(self, action: #selector(self.btnClick(sender:)), for: .touchUpInside)
            backView.addSubview(btn)
            
            if i == 0 {
                leftBackView = backView
                leftTitleLabel = titleLabel
                leftTimeLabel = timeLabel
                leftBtn = btn
                btn.backgroundColor = black_8c8484
            } else if i == 1{
                midBackView = backView
                midTitleLabel = titleLabel
                midTimeLabel = timeLabel
                midBtn = btn
            } else{
                rightBackView = backView
                rightTitleLabel = titleLabel
                rightTimeLabel = timeLabel
                rightdBtn = btn
            }
        }
        
    }
    
    func btnClick(sender : UIButton) {
        let tagNum : Int = sender.tag
        sender.backgroundColor = black_8c8484
        if tagNum == 0 {
           midBtn.backgroundColor = .white
           rightdBtn.backgroundColor = .white
        } else if tagNum == 1 {
            leftBtn.backgroundColor = .white
            rightdBtn.backgroundColor = .white
        } else {
            leftBtn.backgroundColor = .white
            midBtn.backgroundColor = .white
        }
        
    }
    
}
