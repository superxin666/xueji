//
//  WeekAimTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2018/5/14.
//  Copyright © 2018年 lvxin. All rights reserved.
//  本周目标cell

import UIKit
let WeekAimTableViewCellID = "WeekAimTableViewCell_id"
let WeekAimTableViewCellHeight = ip6(126)//学习目标
class WeekAimTableViewCell: UITableViewCell {

    var titleLabel : UILabel!

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

    /// 横线
    var lineView : UIView!



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
        titleLabel = UILabel.getLabel(fream:  CGRect(x: Xappading, y: ip6(30), width: KSCREEN_WIDTH - Xappading * 2, height: ip6(20)), fontSize: 10, text: "", textColor: black_53, textAlignment: .center)
        self.addSubview(titleLabel)
        //左边部分
        leftTitleLabel = UILabel.getLabel(fream:  CGRect(x: Xappading, y: ip6(60), width: ip6(14)*4, height: ip6(20)), fontSize: 14, text: "学习时间", textColor: black_53, textAlignment: .left)
        self.addSubview(leftTitleLabel)

        leftPreLabel = UILabel.getLabel(fream:CGRect(x: Xappading, y:leftTitleLabel.frame.maxY + ip6(8), width: ip6(30)*3, height: ip6(30)), fontSize: 30, text: "", textColor: bluek_0068be, textAlignment: .left)
        self.addSubview(leftPreLabel)

        leftAimLabel = UILabel.getLabel(fream:CGRect(x: leftPreLabel.frame.maxX + centerAppading, y:leftTitleLabel.frame.maxY + ip6(8), width: KSCREEN_WIDTH/2 -  leftPreLabel.frame.maxX - centerAppading, height: ip6(10)), fontSize: 10, text: "目标：", textColor: black_53, textAlignment: .left)
        self.addSubview(leftAimLabel)

        leftAchieveLabel = UILabel.getLabel(fream:CGRect(x: leftPreLabel.frame.maxX + centerAppading, y:leftAimLabel.frame.maxY + ip6(5), width: KSCREEN_WIDTH/2 -  leftPreLabel.frame.maxX - centerAppading, height: ip6(10)), fontSize: 10, text: "完成：", textColor: black_53, textAlignment: .left)
        self.addSubview(leftAchieveLabel)

        //右边部分
        rightTitleLabel = UILabel.getLabel(fream:CGRect(x:KSCREEN_WIDTH/2 + Xappading, y: ip6(60), width: ip6(14)*4, height: ip6(20)), fontSize: 14, text: "学习量", textColor: black_53, textAlignment: .left)
        self.addSubview(rightTitleLabel)

        rightPreLabel = UILabel.getLabel(fream:CGRect(x:KSCREEN_WIDTH/2 + Xappading, y:leftTitleLabel.frame.maxY + ip6(8), width: ip6(30)*3, height: ip6(30)), fontSize: 30, text: "", textColor: bluek_0068be, textAlignment: .left)
        self.addSubview(rightPreLabel)

        rightAimLabel = UILabel.getLabel(fream:CGRect(x: rightPreLabel.frame.maxX + centerAppading, y:rightTitleLabel.frame.maxY + ip6(8), width: KSCREEN_WIDTH/2 -  leftPreLabel.frame.maxX - centerAppading, height: ip6(10)), fontSize: 10, text: "目标：", textColor: black_53, textAlignment: .left)
        self.addSubview(rightAimLabel)

        rightAchieveLabel = UILabel.getLabel(fream:CGRect(x: rightPreLabel.frame.maxX + centerAppading, y:rightAimLabel.frame.maxY + ip6(5), width: KSCREEN_WIDTH/2 -  leftPreLabel.frame.maxX - centerAppading, height: ip6(10)), fontSize: 10, text: "完成：", textColor: black_53, textAlignment: .left)
        self.addSubview(rightAchieveLabel)

        lineView = UIView(frame: CGRect(x: ip6(10), y: study_aim_sectionHeight - 0.5, width: KSCREEN_WIDTH - ip6(20), height:  0.5))
        lineView.backgroundColor = black_e3e3e3
        self.addSubview(lineView)

    }

    func setData(model : WeekAimDetailModel_report) {
        //标题
        if let beg = model.beg_date,let end = model.end_date {
            titleLabel.text = beg + "~" + end
        }
        //时间
        if let rate = model.time_rate {
            if rate > 300 {
                leftPreLabel.text = "∞"
            } else {
                leftPreLabel.text = "\(rate)%"
            }

        }
        let str = "目标 ".getAttributedStr_color(color: black_53, fontSzie: 8)
        str.append(model.getTimegoal())
        leftAimLabel.attributedText = str

        let str2 = "完成 ".getAttributedStr_color(color: black_53, fontSzie: 8)
        str2.append(model.getTimedone())
        leftAchieveLabel.attributedText = str2

        //学习量
        if let rate = model.page_rate {
            if rate > 300 {
                rightPreLabel.text = "∞"
            } else {
                rightPreLabel.text = "\(rate)%"
            }

        }
        let str3 = "目标 ".getAttributedStr_color(color: black_53, fontSzie: 8)
        str3.append(model.getPagegoal())
        rightAimLabel.attributedText = str3

        let str4 = "完成 ".getAttributedStr_color(color: black_53, fontSzie: 8)
        str4.append(model.getPagedone())
        rightAchieveLabel.attributedText = str4

    }
}
