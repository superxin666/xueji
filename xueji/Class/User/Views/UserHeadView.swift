//
//  UserHeadView.swift
//  xueji
//
//  Created by lvxin on 2017/11/6.
//  Copyright © 2017年 lvxin. All rights reserved.
//  我的--头部视图

import UIKit
let headViewHeight = ip6(189)
class UserHeadView: UIView {
    let headBackView : UIView = UIView()//头部视图背景
    let iconImageView : UIImageView = UIImageView()//头像
    var nameLabel : UILabel!//名字
    var dayNumLabel : UILabel!//天数
    var timeNumLabel : UILabel!//时间
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
  
        nameLabel = UILabel.getLabel(fream: CGRect(x: ip6(30), y: iconImageView.frame.maxY + ip6(7), width: KSCREEN_WIDTH/2 - ip6(30), height: ip6(24)), fontSize: 14, text: "尼古拉斯 赵四", textColor: black_53, textAlignment: .left)
        headBackView.addSubview(nameLabel)
        
        //标题
        let titleLabel : UILabel = UILabel.getLabel(fream: CGRect(x: KSCREEN_WIDTH - ip6(45) - ip6(14) * 6, y: ip6(27), width: ip6(14) * 6, height: ip6(20)), fontSize: 14, text: "连续学习天数", textColor: black_53, textAlignment: .right)
        headBackView.addSubview(titleLabel)
        //天数
        dayNumLabel = UILabel.getLabel(fream: CGRect(x: KSCREEN_WIDTH - ip6(45) - ip6(14) * 6, y: titleLabel.frame.maxY + ip6(8), width: ip6(14) * 6, height: ip6(42)), fontSize: 14, text: "32天", textColor: bluek_0068be, textAlignment: .center)
        headBackView.addSubview(dayNumLabel)
        
        let str = "2017年08月01日".getAttributedStr_color(color: black_53, fontSzie: 11)
        str.append("\n至2017年09月02日".getAttributedStr_color(color: bluek_0068be, fontSzie: 11))
        
        timeNumLabel = UILabel.getLabel_AttributedTitle(fream: CGRect(x: KSCREEN_WIDTH - ip6(45) - ip6(14) * 6, y: dayNumLabel.frame.maxY + ip6(8), width: ip6(14) * 7, height: ip6(32)), fontSize: 11, text: str, textColor: black_53, textAlignment: .center)
        timeNumLabel.numberOfLines = 0
        headBackView.addSubview(timeNumLabel)
        
        let topLine : UIView = UIView(frame: CGRect(x: 0, y: headViewHeight - ip6(44), width: KSCREEN_WIDTH, height: ip6(2)))
        topLine.backgroundColor = black_22
        headBackView.addSubview(topLine)
        
        let bottomLine : UIView = UIView(frame: CGRect(x: 0, y: headViewHeight - ip6(2), width: KSCREEN_WIDTH, height: ip6(2)))
        bottomLine.backgroundColor = black_22
        headBackView.addSubview(bottomLine)
    }
}
