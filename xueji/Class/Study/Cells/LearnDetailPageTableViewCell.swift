//
//  LearnDetailPageTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2018/5/8.
//  Copyright © 2018年 lvxin. All rights reserved.
//  页码

import UIKit

protocol LearnDetailPageTableViewCellDelegate {
    func endText(contentStr : String,tagNum : Int)
}

let LearnDetailPageTableViewCellID = "LearnDetailTitleTableViewCell_id"
let LearnDetailPageTableViewCellH = CGFloat(32)
class LearnDetailPageTableViewCell: UITableViewCell,UITextFieldDelegate {
    var delegate : LearnDetailPageTableViewCellDelegate!

    /// 标题
    var titleLabel : UILabel!

    /// 第
    var leftTitleLabel : UILabel!

    /// 页
    var rightTitleLabel : UILabel!


    /// 页数
    var textFiled : UITextField!

    var conTent :String = ""

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

        titleLabel = UILabel.getLabel(fream: CGRect(x: 0, y: ip6(10), width: ip6(60), height: ip6(20)), fontSize: 15, text: "", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x535353), textAlignment: .center)
        backView.addSubview(titleLabel)

        leftTitleLabel = UILabel.getLabel(fream: CGRect(x: titleLabel.frame.maxX +  ip6(30), y: ip6(10), width: ip6(15) , height: ip6(20)), fontSize: 15, text: "第", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x6FA15F), textAlignment: .center)
        backView.addSubview(leftTitleLabel)


        textFiled = UITextField(frame: CGRect(x: leftTitleLabel.frame.maxX, y: ip6(10), width: ip6(60), height: ip6(20)))
        textFiled.textColor = black_53
        textFiled.delegate = self
        textFiled.font = xj_fontThin(15)
        backView.addSubview(textFiled)

        rightTitleLabel = UILabel.getLabel(fream: CGRect(x: textFiled.frame.maxX , y: ip6(10), width:   ip6(15) , height: ip6(20)), fontSize: 15, text: "页", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x6FA15F), textAlignment: .center)
        backView.addSubview(rightTitleLabel)


        let lineView = UIView(frame: CGRect(x: 0, y: viewH - 0.5, width: viewW, height: 0.5))
        lineView.backgroundColor = UIColor.xj_colorFromRGB(rgbValue: 0xcccccc)
        backView.addSubview(lineView)

    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let str = textField.text {
            conTent = str
            if let delgate = self.delegate {
                delgate.endText(contentStr: conTent, tagNum: self.textFiled.tag)
            }
        }
    }

    func setData_start(contentStr : String) {
        self.textFiled.tag = 10
        titleLabel.text = "开       始"

    }
    func setData_end(contentStr : String) {
        self.textFiled.tag = 11
        titleLabel.text = "结       束"
    }

    func setData_tolat(contentStr : String) {
        self.textFiled.tag = 12
        titleLabel.text = "页       数"
        leftTitleLabel.text = "共"
        rightTitleLabel.text = "页"
    }

}
