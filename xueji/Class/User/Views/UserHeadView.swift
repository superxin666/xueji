//
//  UserHeadView.swift
//  xueji
//
//  Created by lvxin on 2017/11/6.
//  Copyright © 2017年 lvxin. All rights reserved.
//  tab 我的界面头部视图

import UIKit
let headViewHeight = ip6(189)
class UserHeadView: UIView {
    let headBackView : UIView = UIView()//头部视图背景
    let iconImageView : UIImageView = UIImageView()//头像
    let nameLabel : UILabel = UILabel()//名字
    let dayNumLabel : UILabel = UILabel()//天数
    let timeNumLabel : UILabel = UILabel()//时间
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.creatUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func creatUI()  {
        headBackView.frame = CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: headViewHeight)
        headBackView.backgroundColor = .white
        self.addSubview(headBackView)
        //头像
        iconImageView.frame = CGRect(x: ip6(30), y: ip6(27), width: ip6(80), height: ip6(80))
        iconImageView.setImage_kf(imageName: "", placeholderImage: #imageLiteral(resourceName: "book"))
        iconImageView.xj_makeRound()
        headBackView.addSubview(iconImageView)
        
        nameLabel.frame = CGRect(x: ip6(30), y: iconImageView.frame.maxY + ip6(7), width: KSCREEN_WIDTH/2 - ip6(30), height: ip6(24))
        nameLabel.font = xj_fzFontMedium(ip6(14))
        nameLabel.text = "尼古拉斯 赵四"
        nameLabel.textColor = black_53
        nameLabel.textAlignment = .left
        headBackView.addSubview(nameLabel)
        //标题
        let titleLabel : UILabel = UILabel(frame: CGRect(x: KSCREEN_WIDTH - ip6(45) - ip6(14) * 6, y: ip6(27), width: ip6(14) * 6, height: ip6(20)))
        titleLabel.font = xj_fzFontMedium(ip6(14))
        titleLabel.text = "连续学习天数"
        titleLabel.textColor = black_53
        titleLabel.textAlignment = .right
        headBackView.addSubview(titleLabel)
        //天数

        dayNumLabel.frame = CGRect(x: KSCREEN_WIDTH - ip6(45) - ip6(14) * 6, y: titleLabel.frame.maxY + ip6(8), width: ip6(14) * 6, height: ip6(42))
        dayNumLabel.font = xj_fzFontMedium(ip6(30))
        dayNumLabel.text = "32天"
        dayNumLabel.textColor = bluek_0068be
        dayNumLabel.textAlignment = .center
        headBackView.addSubview(dayNumLabel)
        
        timeNumLabel.frame = CGRect(x: KSCREEN_WIDTH - ip6(45) - ip6(14) * 6, y: dayNumLabel.frame.maxY + ip6(8), width: ip6(14) * 6, height: ip6(32))
        timeNumLabel.font = xj_fzFontMedium(ip6(11))
        timeNumLabel.text = "起2017年08月01日\n至2017年09月02日"
        timeNumLabel.textColor = black_53
        timeNumLabel.textAlignment = .center
        headBackView.addSubview(timeNumLabel)
        
        let topLine : UIView = UIView(frame: CGRect(x: 0, y: headViewHeight - ip6(44), width: KSCREEN_WIDTH, height: ip6(2)))
        topLine.backgroundColor = black_22
        headBackView.addSubview(topLine)
        
        let bottomLine : UIView = UIView(frame: CGRect(x: 0, y: headViewHeight - ip6(2), width: KSCREEN_WIDTH, height: ip6(2)))
        bottomLine.backgroundColor = black_22
        headBackView.addSubview(bottomLine)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


}
