//
//  CateCollectionViewCell.swift
//  xueji
//
//  Created by lvxin on 2018/5/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let CateCollectionViewCellID = "CateCollectionViewCell_id"

class CateCollectionViewCell: UICollectionViewCell {

    var btn : UIButton!
    var label : UILabel!


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.creatUI()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func creatUI() {
//        btn = UIButton.getBtn_titleStyle(title_normal: "", title_selected: "", fream: CGRect(x: 0, y: 0, width: itemW, height: itemH), backgroundColor: UIColor.xj_colorFromRGB(rgbValue: 0xefefef), textColorSelectrd: .white, textColor: black_53, fontSize: 11, textAlignment: .center, selector: #selector(click(sender:)), vc: self, tag: 0)
//        btn.xj_makeRadius(radius: ip6(16))
//        self.addSubview(btn)

        label = UILabel.getLabel(fream: CGRect(x: 0, y: 0, width: itemW, height: itemH), fontSize: 11, text: "", textColor: black_53, textAlignment: .center)
        label.backgroundColor = UIColor.xj_colorFromRGB(rgbValue: 0xefefef)
        label.xj_makeRadius(radius: ip6(16))
        self.addSubview(label)
    }

    func setData(title : String) {
        label.text = title
    }

    func setNormal() {
        label.textColor = black_53
        label.backgroundColor = UIColor.xj_colorFromRGB(rgbValue: 0xefefef)


    }

    func setSlected() {
        label.textColor = .white
        label.backgroundColor = black_53

    }
    
}
