//
//  StudyAimTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2017/11/7.
//  Copyright © 2017年 lvxin. All rights reserved.
//  我的--学习目标

import UIKit
let study_aim_cell_ID = "study_aim_cell_id"
let study_aim_sectionHeight = ip6(80)//学习目标
typealias StudyAimTableViewCellBlock = () ->()

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

    /// 横线
    var lineView : UIView!

    var nestBtn : UIButton!

    var nestBlock : StudyAimTableViewCellBlock!


    
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
        leftTitleLabel = UILabel.getLabel(fream:  CGRect(x: Xappading, y: ip6(30), width: ip6(14)*4, height: ip6(20)), fontSize: 14, text: "学习时间", textColor: black_53, textAlignment: .left)
        self.addSubview(leftTitleLabel)
        
        leftPreLabel = UILabel.getLabel(fream:CGRect(x: Xappading, y:leftTitleLabel.frame.maxY + ip6(8), width: ip6(30)*3, height: ip6(30)), fontSize: 30, text: "", textColor: bluek_0068be, textAlignment: .left)
        self.addSubview(leftPreLabel)
        
        leftAimLabel = UILabel.getLabel(fream:CGRect(x: leftPreLabel.frame.maxX + centerAppading, y:leftTitleLabel.frame.maxY + ip6(8), width: KSCREEN_WIDTH/2 -  leftPreLabel.frame.maxX - centerAppading, height: ip6(10)), fontSize: 10, text: "", textColor: black_53, textAlignment: .left)
        self.addSubview(leftAimLabel)
        
        leftAchieveLabel = UILabel.getLabel(fream:CGRect(x: leftPreLabel.frame.maxX + centerAppading, y:leftAimLabel.frame.maxY + ip6(5), width: KSCREEN_WIDTH/2 -  leftPreLabel.frame.maxX - centerAppading, height: ip6(10)), fontSize: 10, text: "", textColor: black_53, textAlignment: .left)
        self.addSubview(leftAchieveLabel)
        
        //右边部分
        rightTitleLabel = UILabel.getLabel(fream:CGRect(x:KSCREEN_WIDTH/2 + Xappading, y: ip6(30), width: ip6(14)*4, height: ip6(20)), fontSize: 14, text: "学习量", textColor: black_53, textAlignment: .left)
        self.addSubview(rightTitleLabel)
        
        rightPreLabel = UILabel.getLabel(fream:CGRect(x:KSCREEN_WIDTH/2 + Xappading, y:leftTitleLabel.frame.maxY + ip6(8), width: ip6(30)*3, height: ip6(30)), fontSize: 30, text: "", textColor: bluek_0068be, textAlignment: .left)
        self.addSubview(rightPreLabel)
        
        rightAimLabel = UILabel.getLabel(fream:CGRect(x: rightPreLabel.frame.maxX + centerAppading, y:rightTitleLabel.frame.maxY + ip6(8), width: KSCREEN_WIDTH/2 -  leftPreLabel.frame.maxX - centerAppading, height: ip6(10)), fontSize: 10, text: "", textColor: black_53, textAlignment: .left)
        self.addSubview(rightAimLabel)
        
        rightAchieveLabel = UILabel.getLabel(fream:CGRect(x: rightPreLabel.frame.maxX + centerAppading, y:rightAimLabel.frame.maxY + ip6(5), width: KSCREEN_WIDTH/2 -  leftPreLabel.frame.maxX - centerAppading, height: ip6(10)), fontSize: 10, text: "", textColor: black_53, textAlignment: .left)
        self.addSubview(rightAchieveLabel)

        lineView = UIView(frame: CGRect(x: ip6(10), y: study_aim_sectionHeight - 0.5, width: KSCREEN_WIDTH - ip6(20), height:  0.5))
        lineView.backgroundColor = black_e3e3e3
        lineView.isHidden = true
        self.addSubview(lineView)


//        nestBtn = UIButton.getBtn_picStyle(image_normal: #imageLiteral(resourceName: "study_shape_>"), image_selected: #imageLiteral(resourceName: "study_shape_>"), fream: CGRect(x: KSCREEN_WIDTH - ip6(20), y: 0, width: ip6(20), height: study_aim_sectionHeight), selector: #selector(nestClick), vc: self, tag: 0)

//        self.addSubview(nestBtn)

    }

    func setData(model : UserInfoModel_weekgoal) {
        //时间
        if let rate = model.time.rate {
            leftPreLabel.text = "\(rate)%"
        }
        let str = "目标 ".getAttributedStr_color(color: black_53, fontSzie: 8)
        str.append(model.time.getTimegoal())
        leftAimLabel.attributedText = str

        let str2 = "完成 ".getAttributedStr_color(color: black_53, fontSzie: 8)
        str2.append(model.time.getTimedone())
        leftAchieveLabel.attributedText = str2


        //学习量
        if let rate = model.pages.rate {
            rightPreLabel.text = "\(rate)%"
        }
        let str3 = "目标 ".getAttributedStr_color(color: black_53, fontSzie: 8)
        str3.append(model.pages.getPagegoal())
        rightAimLabel.attributedText = str3

        let str4 = "完成 ".getAttributedStr_color(color: black_53, fontSzie: 8)
        str4.append(model.pages.getPagedone())
        rightAchieveLabel.attributedText = str4
    }


    func nestClick()   {
        self.nestBlock()
    }

}
