//
//  SetHeadView.swift
//  xueji
//
//  Created by lvxin on 2018/1/7.
//  Copyright © 2018年 lvxin. All rights reserved.
//  个人设置头部视图

import UIKit


class SetHeadView: UIView {

    /// 头像
    var iconImageView : UIImageView!

    /// 名字
    var nameLabel : UILabel!


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.creatUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func creatUI()  {
        iconImageView = UIImageView(frame: CGRect(x: (KSCREEN_WIDTH - ip6(115))/2, y: ip6(30), width: ip6(115), height: ip6(115)))
        iconImageView.xj_makeRound()
        self.addSubview(iconImageView)

        nameLabel = UILabel.getLabel(fream: CGRect(x: ip6(25), y: iconImageView.frame.maxY + ip6(10), width: KSCREEN_WIDTH - ip6(50), height: ip6(20)), fontSize: 15, text: "", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x535353), textAlignment: .center)
        self.addSubview(nameLabel)
    }

    func setData(model : UserInfoModel_head) {
        if let str = model.avatar {
            iconImageView.setImage_kf(imageName:  str, placeholderImage: #imageLiteral(resourceName: "bookLoading"))
        }
        if let str = model.username {
            nameLabel.text = str
        }


    }
}
