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
    var topLine : UIView!
    /// 星期几
    let weekNum = String.getDayIndex()
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
        iconImageView.xj_makeRound()
        headBackView.addSubview(iconImageView)
  
        nameLabel = UILabel.getLabel(fream: CGRect(x: ip6(30), y: iconImageView.frame.maxY + ip6(7), width: KSCREEN_WIDTH/2 - ip6(30), height: ip6(24)), fontSize: 14, text: "", textColor: black_53, textAlignment: .left)
        headBackView.addSubview(nameLabel)
        
        //标题
        let titleLabel : UILabel = UILabel.getLabel(fream: CGRect(x: KSCREEN_WIDTH - ip6(45) - ip6(14) * 6, y: ip6(27), width: ip6(14) * 6, height: ip6(20)), fontSize: 14, text: "连续学习天数", textColor: black_53, textAlignment: .right)
        headBackView.addSubview(titleLabel)
        //天数
        dayNumLabel = UILabel.getLabel(fream: CGRect(x: KSCREEN_WIDTH - ip6(45) - ip6(14) * 6, y: titleLabel.frame.maxY + ip6(8), width: ip6(14) * 6, height: ip6(42)), fontSize: 14, text: "", textColor: bluek_0068be, textAlignment: .center)
        headBackView.addSubview(dayNumLabel)
        

        
        timeNumLabel = UILabel.getLabel_AttributedTitle(fream: CGRect(x: KSCREEN_WIDTH - ip6(45) - ip6(14) * 6, y: dayNumLabel.frame.maxY + ip6(8), width: ip6(14) * 7, height: ip6(32)), fontSize: 11, text: NSMutableAttributedString(string: ""), textColor: black_53, textAlignment: .center)
        timeNumLabel.numberOfLines = 0
        headBackView.addSubview(timeNumLabel)
        
        topLine = UIView(frame: CGRect(x: 0, y: headViewHeight - ip6(44), width: KSCREEN_WIDTH, height: ip6(2)))
        topLine.backgroundColor = black_22
        headBackView.addSubview(topLine)
        
        let bottomLine : UIView = UIView(frame: CGRect(x: 0, y: headViewHeight - ip6(2), width: KSCREEN_WIDTH, height: ip6(2)))
        bottomLine.backgroundColor = black_22
        headBackView.addSubview(bottomLine)
    }


    func setData(model : UserInfoModel_head){
        //头像
        iconImageView.setImage_kf(imageName:  model.avatar, placeholderImage: #imageLiteral(resourceName: "book"))
        //姓名
        nameLabel.text = model.username
        //连续天数
        if let days = model.continuous_days {
            let str = "\(days)".getAttributedStr_color(color: bluek_0068be, fontSzie: 30)
            str.append("天".getAttributedStr_color(color: black_53, fontSzie: 14))
            dayNumLabel.attributedText = str
        }

        //开始学习日期  结束学习日期
        if let start = model.beg_long,let end = model.latest_long {
            if start.count > 0 && end.count > 0 {
                timeNumLabel.isHidden = false
                let str = String.xj_getDate_style1(dateStr: start, style: 4).getAttributedStr_color(color: black_53, fontSzie: 11)
                str.append(String.xj_getDate_style1(dateStr: end, style: 4).getAttributedStr_color(color: green_84B53E, fontSzie: 11))
                timeNumLabel.attributedText = str
            } else {
                timeNumLabel.isHidden = true
            }
        }
        //
        let appad = ip6(13)
        let viewappad = ip6(25)
        let subviewW = (KSCREEN_WIDTH - appad * 2 - viewappad * 6)/7
        let subviewH = ip6(42)
        let weakArr = ["周一","周二","周三","周四","周五","周六","周日"]


        for i in 0..<weakArr.count {
            let model : UserInfoModel_head_week_learned_flag = model.week_learned_flag[weakArr.count-i-1]

            let subView = UIView(frame: CGRect(x:appad + CGFloat(i) * (viewappad + subviewW), y: topLine.frame.maxY, width: subviewW, height: subviewH - ip6(4)))
            subView.isUserInteractionEnabled = true

            let topLabel = UILabel.getLabel(fream: CGRect(x: 0, y: 0, width: subviewW, height: subviewH/3), fontSize: 10, text: weakArr[i], textColor: UIColor.xj_colorFromRGB(rgbValue: 0x8E8E93), textAlignment: .center)
            subView.addSubview(topLabel)
            let dateStr = String.xj_getDate_day(dateStr: model.date)

            let midLabel = UILabel.getLabel(fream: CGRect(x: 0, y: subviewH/3 + ip6(4), width: subviewW, height: subviewH/3), fontSize: 15, text: dateStr, textColor: UIColor.xj_colorFromRGB(rgbValue: 0x535353 ), textAlignment: .center)
            subView.addSubview(midLabel)

            XJLog(message:"星期几" + "\(weekNum)")
            if i + 1 == weekNum {
                midLabel.textColor = .white
                topLabel.textColor = .white
                subView.backgroundColor = UIColor.xj_colorFromRGB(rgbValue: 0x535353)
            }


            if model.learned {
                //学习
                let imageView = UIImageView(frame: CGRect(x: 0, y: subviewH/3 + ip6(4), width: subviewW, height:subviewH/3))
                imageView.image = #imageLiteral(resourceName: "base_selected")
                subView.addSubview(imageView)
            } else {

            }

            self.addSubview(subView)
        }



    }
}
