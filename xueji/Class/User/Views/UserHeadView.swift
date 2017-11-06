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
    let dayNumLabel : UILabel = UILabel()//天数
    
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
        //标题
        let titleLabel : UILabel = UILabel(frame: CGRect(x: KSCREEN_WIDTH - ip6(45) - ip6(14) * 6, y: ip6(27), width: ip6(14) * 6, height: ip6(20)))
        titleLabel.font = xj_fzFontMedium(ip6(14))
        titleLabel.text = "连续学习天数"
        titleLabel.textColor = black_53
        titleLabel.textAlignment = .right
        headBackView.addSubview(titleLabel)
        //天数
        
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


}
