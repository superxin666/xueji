//
//  LearnDetailTitleTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2018/5/7.
//  Copyright © 2018年 lvxin. All rights reserved.
//  标题

import UIKit
let LearnDetailTitleTableViewCellID = "LearnDetailTitleTableViewCell_id"
let LearnDetailTitleTableViewCellH = CGFloat(32)


class LearnDetailTitleTableViewCell: UITableViewCell {

    /// 标题
    var titleLabel : UILabel!

    /// 内容
    var contentLabel : UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle  = .none
        self.creatUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func creatUI() {
        let X = ip6(20)
        let viewW = KSCREEN_WIDTH - ip6(40)
        let viewH = ip6(32)

        let backView = UIView(frame: CGRect(x: X, y: 0, width: viewW, height: viewH))
        backView.backgroundColor = .white
        self.addSubview(backView)

        titleLabel = UILabel.getLabel(fream: CGRect(x: 0, y: ip6(10), width: ip6(90), height: ip6(20)), fontSize: 15, text: "", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x535353), textAlignment: .left)
        backView.addSubview(titleLabel)

        contentLabel = UILabel.getLabel(fream: CGRect(x: titleLabel.frame.maxX , y: ip6(10), width: viewW - titleLabel.frame.maxX -  ip6(30) , height: ip6(20)), fontSize: 15, text: "", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x535353), textAlignment: .left)
        backView.addSubview(contentLabel)

        let lineView = UIView(frame: CGRect(x: 0, y: viewH - 0.5, width: viewW, height: 0.5))
        lineView.backgroundColor = UIColor.xj_colorFromRGB(rgbValue: 0xcccccc)
        backView.addSubview(lineView)

    }

    func setData_title( contentStr : String) {
        titleLabel.text = "标       题"
        contentLabel.text = contentStr
    }

    func setData_date(timeStr : String) {
        titleLabel.text = "日       期"
        contentLabel.text = timeStr
    }
    func setData_time(timeStr : String)  {
        titleLabel.text = "学习时间"
        contentLabel.text = timeStr
    }

    func setData_firstTime(timeStr  : String) {
        contentLabel.frame = CGRect(x: titleLabel.frame.maxX + ip6(10) , y: ip6(10), width: KSCREEN_WIDTH - ip6(40) - titleLabel.frame.maxX -  ip6(40),height: ip6(20))
        contentLabel.text = timeStr
        contentLabel.textColor = UIColor.xj_colorFromRGB(rgbValue: 0x535353)

        titleLabel.textColor = UIColor.xj_colorFromRGB(rgbValue: 0xE7E5E5)
        titleLabel.text = "首次学习时间"
    }
    func setData_firstTime_enble() {
        titleLabel.textColor = UIColor.xj_colorFromRGB(rgbValue: 0x535353)
        contentLabel.textColor = UIColor.xj_colorFromRGB(rgbValue: 0x535353)
    }
    func setData_firstTime_unenble() {
        titleLabel.textColor = UIColor.xj_colorFromRGB(rgbValue: 0xE7E5E5)
        contentLabel.textColor = UIColor.xj_colorFromRGB(rgbValue: 0xE7E5E5)
    }
}
