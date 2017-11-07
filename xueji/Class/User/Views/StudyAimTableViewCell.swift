//
//  StudyAimTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2017/11/7.
//  Copyright © 2017年 lvxin. All rights reserved.
//  我的--学习目标

import UIKit

class StudyAimTableViewCell: UITableViewCell {
    //左边
    var leftTitleLabel : UILabel!
    var leftPreLabel : UILabel!
    var leftAimLabel : UILabel!
    var leftAchieveLabel : UILabel!
    
    //右边
    var rightTitleLabel : UILabel!
    var rightPreLabel : UILabel!
    var rightAimLabel : UILabel!
    var rightAchieveLabel : UILabel!
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.creatUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI() {
        let Xappading = ip6(19)
        let centerAppading = ip6(0)
        
        //左边部分
        leftTitleLabel = UILabel(frame: CGRect(x: Xappading, y: ip6(30), width: ip6(14)*4, height: ip6(20)))
        leftTitleLabel.text = "学习时间"
        leftTitleLabel.textAlignment = .left
        leftTitleLabel.font = xj_fzFontMedium(ip6(14))
        leftTitleLabel.textColor = black_53
        self.addSubview(leftTitleLabel)
        
        leftPreLabel = UILabel(frame: CGRect(x: Xappading, y:leftTitleLabel.frame.maxY + ip6(8), width: ip6(30)*3, height: ip6(30)))
        leftPreLabel.text = "100%"
        leftPreLabel.textAlignment = .left
        leftPreLabel.font = xj_fzFontMedium(ip6(30))
        leftPreLabel.textColor = bluek_0068be
        self.addSubview(leftPreLabel)
        
        leftAimLabel = UILabel(frame: CGRect(x: leftPreLabel.frame.maxX + centerAppading, y:leftTitleLabel.frame.maxY + ip6(8), width: KSCREEN_WIDTH/2 -  leftPreLabel.frame.maxX - centerAppading, height: ip6(10)))
        leftAimLabel.text = "目标：10h00m"
        leftAimLabel.textAlignment = .left
        leftAimLabel.font = xj_fzFontMedium(ip6(10))
        leftAimLabel.textColor = black_53
        self.addSubview(leftAimLabel)
        
        leftAchieveLabel = UILabel(frame: CGRect(x: leftPreLabel.frame.maxX + centerAppading, y:leftAimLabel.frame.maxY + ip6(5), width: KSCREEN_WIDTH/2 -  leftPreLabel.frame.maxX - centerAppading, height: ip6(10)))
        leftAchieveLabel.text = "完成：10h00m"
        leftAchieveLabel.textAlignment = .left
        leftAchieveLabel.font = xj_fzFontMedium(ip6(10))
        leftAchieveLabel.textColor = black_53
        self.addSubview(leftAchieveLabel)
        
        //右边部分
        rightTitleLabel = UILabel(frame: CGRect(x:KSCREEN_WIDTH/2 + Xappading, y: ip6(30), width: ip6(14)*4, height: ip6(20)))
        rightTitleLabel.text = "学习量"
        rightTitleLabel.textAlignment = .left
        rightTitleLabel.font = xj_fzFontMedium(ip6(14))
        rightTitleLabel.textColor = black_53
        self.addSubview(rightTitleLabel)
        
        rightPreLabel = UILabel(frame: CGRect(x:KSCREEN_WIDTH/2 + Xappading, y:leftTitleLabel.frame.maxY + ip6(8), width: ip6(30)*3, height: ip6(30)))
        rightPreLabel.text = "100%"
        rightPreLabel.textAlignment = .left
        rightPreLabel.font = xj_fzFontMedium(ip6(30))
        rightPreLabel.textColor = bluek_0068be
        self.addSubview(rightPreLabel)
        
        rightAimLabel = UILabel(frame: CGRect(x: rightPreLabel.frame.maxX + centerAppading, y:rightTitleLabel.frame.maxY + ip6(8), width: KSCREEN_WIDTH/2 -  leftPreLabel.frame.maxX - centerAppading, height: ip6(10)))
        rightAimLabel.text = "目标：1000页"
        rightAimLabel.textAlignment = .left
        rightAimLabel.font = xj_fzFontMedium(ip6(10))
        rightAimLabel.textColor = black_53
        self.addSubview(rightAimLabel)
        
        rightAchieveLabel = UILabel(frame: CGRect(x: rightPreLabel.frame.maxX + centerAppading, y:rightAimLabel.frame.maxY + ip6(5), width: KSCREEN_WIDTH/2 -  leftPreLabel.frame.maxX - centerAppading, height: ip6(10)))
        rightAchieveLabel.text = "完成：100页"
        rightAchieveLabel.textAlignment = .left
        rightAchieveLabel.font = xj_fzFontMedium(ip6(10))
        rightAchieveLabel.textColor = black_53
        self.addSubview(rightAchieveLabel)
        
        
    }

}
