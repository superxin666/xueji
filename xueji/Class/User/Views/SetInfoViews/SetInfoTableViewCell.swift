//
//  SetInfoTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2018/1/7.
//  Copyright © 2018年 lvxin. All rights reserved.
//  个人设置界面cell

import UIKit
let SetInfoCellHeight = ip6(35)
class SetInfoTableViewCell: UITableViewCell {

    var titleLabel : UILabel!
    var titleNameStr : String!




    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.creatUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func creatUI()  {
        titleLabel = UILabel.getLabel(fream: CGRect(x: ip6(25), y: ip6(8), width: ip6(90), height: ip6(20)), fontSize: 18, text: "", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x535353), textAlignment: .left)
        self.addSubview(titleLabel)

        let lineView = UIView(frame: CGRect(x: ip6(25), y:  SetInfoCellHeight - 1, width: KSCREEN_WIDTH - ip6(50), height: 1))
        lineView.backgroundColor = UIColor.xj_colorFromRGB(rgbValue: 0xaaaaaa)
        self.addSubview(lineView)

    }
    func setName(name : String) {
        titleLabel.text = name
    }

}
